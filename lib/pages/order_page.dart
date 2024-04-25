import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app/pages/product_page.dart';
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
          return Center(child: CircularProgressIndicator(),);
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
  late String image;
  late String title;
  late String nutritionalValue;
  late int cost;

  @override
  Widget build(BuildContext context) {
    image = widget.doc['image'];
    title = widget.doc['title'];
    nutritionalValue = widget.doc['nutritional-value-per-100-g'].toString();
    cost = widget.doc['cost'];
    return SizedBox(
      height: 500,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        //clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(productData: widget.doc)
                )
            );
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightMode.colorScheme.secondaryContainer
                    ),
                    child: Image.network(image),
                    ),
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.all(5.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                      ),
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          '$nutritionalValue ккал',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300
                          ),
                        )
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('$cost₽')
                    )
                  ],
                ),
              ],
          ),
        ),
      ),
    );
  }

}