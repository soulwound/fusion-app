import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app/themes/light_theme.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<StatefulWidget> createState() => OrderPageState();

}

class OrderPageState extends State<OrderPage> {

  int cartCost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Меню'),
      ),
      body: ItemsMenu(),
    );
  }

}

class ItemsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProductCategory(categoryTitle: 'chicken',),
      ],
    );
  }

}

class ProductCategory extends StatelessWidget {
  final String categoryTitle;

  const ProductCategory({super.key, required this.categoryTitle});

  Future<QuerySnapshot<Map<String, dynamic>>> getData(String categoryName) async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection('product/$categoryName/$categoryName')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(categoryTitle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: []
            );
          }
          return CircularProgressIndicator();
        }
    );
  }
}