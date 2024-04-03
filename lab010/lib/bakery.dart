import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bakery{
  //String id;
  String name;
  int price;

  Bakery({
   // this.id = '',
    required this.name,
    required this.price,
  });

  Bakery.fromJson(Map<String, Object?> json) : this(
      name: json['name']! as String, price: json['price']! as int
  );

  Bakery copyWith({
    String? name,
    int? price,
    }){
      return Bakery(name: name ?? this.name, price: price ?? this.price);
  }

  Map<String, Object?> toJson(){
    return{
      'name': name,
      'price': price,
    };
  }
}