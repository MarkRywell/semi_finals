import 'package:flutter/material.dart';
import 'package:semi_finals/views/home_page.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey
        ),
        home: const HomePage(),
      ));
}

