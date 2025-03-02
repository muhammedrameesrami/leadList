import 'dart:ui';

import 'package:flutter/material.dart';

class Vehicle {
  final String id;
  final String name;
  final double mileage; // km/litre
  final int age; // years
  final String imageUrl; // URL of the image

  Vehicle({
    required this.id,
    required this.name,
    required this.mileage,
    required this.age,
    required this.imageUrl,
  });

  // Helper method to determine the color coding
  Color getColor() {
    if (mileage >= 15 && age <= 5) {
      return Colors.green; // Fuel efficient and low pollutant
    } else if (mileage >= 15 && age > 5) {
      return Colors.amber; // Fuel efficient but moderately pollutant
    } else {
      return Colors.red; // Not fuel efficient
    }
  }
}