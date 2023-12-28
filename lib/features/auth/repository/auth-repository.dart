import 'dart:convert';

import 'package:ayamutty/end-points/api-contant.dart';
import 'package:ayamutty/end-points/auth-endpoint/auth-endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../list/screen/list.dart';

String storedToken="";

class AuthService{
  login(String username,String password,BuildContext context)async{
    try{
      var url=Uri.parse(ApiConstants.baseUrl+AuthEndpoints.login);
      var response=await http.post(url,body: {
        "username":username,
        "password":password
      });
      if(response.statusCode==200){
        String jsonResponse = response.body;

          Map<String, dynamic> data = json.decode(jsonResponse);

          if (data['success'] == true) {

            String token = data['data']['token'];
            SharedPreferences pref=await SharedPreferences.getInstance();
            pref.setString("token", token);
            storedToken=token;
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyList(),), (route) => false);
            print('Token: $token');
          } else {

            print('Login failed: ${data['message']}');
          }
        }
      else if(response.statusCode==401){
        String jsonResponse = response.body;
        Map<String, dynamic> data = json.decode(jsonResponse);
        showSnackBar(context, data['message']);
      }
    }
    catch (e){
showSnackBar(context, e.toString());
    }
  }
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}