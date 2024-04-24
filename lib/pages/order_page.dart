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
  const ItemsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            if (snapshot.data!.docs.length % 2 == 0) {
              return GridView.count(
                childAspectRatio: 0.7,
                shrinkWrap: true,
                  crossAxisCount: 2,
                  children: snapshot.data!.docs.map((element) {
                    return MenuItem(doc: element);
                  }
                  ).toList()
              );
            }
          }
          return CircularProgressIndicator();
        }
    );
  }
}

class MenuItem extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> doc;
  const MenuItem({super.key, required this.doc});

  @override
  State<StatefulWidget> createState() => MenuItemState();

}

class MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        //clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: lightMode.colorScheme.primary
                  ),
                  child: Image.network(widget.doc['image']),
                  ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                  child: Text(
                    widget.doc['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    '${widget.doc['nutritional-value-per-100-g'].toString()} ккал',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300
                    ),
                  )
              ),
            ],
        ),
      ),
    );
  }

}