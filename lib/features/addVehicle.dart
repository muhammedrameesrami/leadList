import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(
    {required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Colors.blueGrey,
      content: Text(
        content,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ));
}
class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}
class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mileageController = TextEditingController();
  final _ageController = TextEditingController();
  File? _imageFile;
  bool imgloading = false;
  String imgfile = '';

  Future<void> photoPicker() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile == null) {
      // If no image is selected, show a snackbar and return
      showSnackBar(
        context: context,
        content: "No image selected",
      );
      return; // Exit the function
    }

    setState(() {
      _imageFile = File(imageFile.path);
      imgloading = true;
    });

    showSnackBar(
      context: context,
      content: "Image Uploading Please Wait",
    );

    try {
      String imageId = _imageFile!.path.split(".").last;
      var uploadingImg = await FirebaseStorage.instance
          .ref()
          .child("vehicle/images/${DateTime.now().toString()}")
          .putFile(_imageFile!, SettableMetadata(contentType: "images/$imageId"));

      imgfile = await uploadingImg.ref.getDownloadURL();

      setState(() {
        imgloading = false;
      });

      showSnackBar(
        context: context,
        content: "Image Upload completed",
      );
    } catch (e) {
      showSnackBar(
        context: context,
        content: "Failed to upload image: $e",
      );
      setState(() {
        imgloading = false;
      });
    }
  }
  Future<void> _addVehicle() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      final name = _nameController.text;
      final mileage = double.parse(_mileageController.text);
      final age = int.parse(_ageController.text);

      // Upload image and get URL
      // final imageUrl = await _uploadImage();

      // Add vehicle to Firestore
      await FirebaseFirestore.instance.collection('vehicles').add({
        'name': name,
        'mileage': mileage,
        'age': age,
        'imageUrl': imgfile,
      });

      // Clear the form
      _nameController.clear();
      _mileageController.clear();
      _ageController.clear();
      setState(() {
        _imageFile = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Vehicle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Vehicle Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mileageController,
                decoration: InputDecoration(labelText: 'Mileage (km/litre)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mileage';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age (years)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              // SizedBox(height: 20),
              // _imageFile == null
              //     ? Text('No image selected.')
              //     : Image.file(_imageFile!, height: 100),
              // ElevatedButton(
              //   onPressed: () {
              //     photoPicker();
              //   },
              //   child: Text('Pick Image'),
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addVehicle();
                },
                child: Text('Add Vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}