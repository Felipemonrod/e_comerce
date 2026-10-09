import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
      title: "E-comerce",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueGrey)),
      home: Home(),
    ),
  );
}