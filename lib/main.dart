import 'package:flutter/material.dart';
import 'package:fusion_app/pages/navigation.dart';
import 'package:fusion_app/themes/light_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("product/chicken/chicken")
        .get();
  }
  // var data = await getData();
  var snapshot = await getData();
  var docs = snapshot.docs;
  docs.forEach((element) { print(element['title']); });
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
