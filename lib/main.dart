import 'package:flutter/material.dart';
import 'package:fusion_app/pages/navigation.dart';
import 'package:fusion_app/themes/light_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FABBottomNavigationBar(),
      theme: lightMode,
    );
  }

}
