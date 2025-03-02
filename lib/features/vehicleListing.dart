import 'package:ayamutty/features/vehicleModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addVehicle.dart';


class VehicleListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle List')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No vehicles found.'));
          }

          final vehicles = snapshot.data!.docs.map((doc) {
            return Vehicle(
              id: doc.id,
              name: doc['name'],
              mileage: doc['mileage'],
              age: doc['age'],
              imageUrl: doc['imageUrl'],
            );
          }).toList();

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return Card(
                color: vehicle.getColor(),
                child: ListTile(
                  leading: vehicle.imageUrl.isNotEmpty
                      ? Image.network(vehicle.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.car_repair),
                  title: Text(vehicle.name),
                  subtitle: Text('Mileage: ${vehicle.mileage} km/l, Age: ${vehicle.age} years'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVehicleScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}