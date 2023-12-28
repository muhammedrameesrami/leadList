import 'package:ayamutty/features/auth/repository/auth-repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../list/screen/list.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container for TextFields
          Positioned(
            top: 290,
            left: 20,
            right: 20,
            child: Container(
              width: 400,
              height: 900,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 210,),
                      child: Text('Sign In', style: TextStyle(color: Colors.blue, fontSize: 20)),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 30,top: 5),
                      child: Text(
                        'Welcome back! Please enter your credentials to login',
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Decrease the height of the TextField
                    SizedBox(
                      height: 50,
                      child: TextFormField(controller: username,
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email address';
                        }
                        if (!value.endsWith('@gmail.com')) {
                          return 'Please enter a Gmail address';
                        }
                        return null;
                      },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Decrease the height of the TextField
                    SizedBox(
                      height: 50,
                      child: TextFormField(controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          // Add more password validation if needed
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding:  EdgeInsets.only(left: 170),
                      child: Text('Forgot your Password ?',style: TextStyle(fontSize: 9),),
                    ),
                    SizedBox(height: 15,),
                    // Increase the width of the ElevatedButton
                    ElevatedButton(
                      onPressed: () {if(_formKey.currentState!.validate()){
                        login(username.text, password.text);
                        showSnackBar(context, 'login successfully');
                      }else{
                        showSnackBar(context, 'error to login');
                      }

                       },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        minimumSize: Size(double.infinity, 50), // Adjust the width
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Don\'t have an account? Sign up')
                  ],
                ),
              ),
            ),
          ),
          // Background Container with Curved Bottom Right Corner
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 270,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue, // Adjust the color as needed
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(120),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  login(username,password) async {
    AuthService().login(username, password,context);

    // if(storedToken!=""||storedToken!=null){
    //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyList(),), (route) => false);
    // }
  }
}
