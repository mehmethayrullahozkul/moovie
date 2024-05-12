import 'package:flutter/material.dart';

class Car {
  final String name;
  final String model;
  final int price;

  static Car? Audi;

  // named parameter

  Car.privateConstructor(int price)
      : this.name = "Audi",
        this.model = "E5",
        this.price = price;

  factory Car(int price) {
    if (Audi == null) {
      Audi = Car.privateConstructor(price);
    }
    return Audi!;
  }

  // Burası constructor son alanı burada final variable initialize edilmez
}

// Car.Dondur()

class User {
  final String username;

  const User({this.username = ""});
}

class Hayrullah extends User {
  Hayrullah({required super.username});
}
