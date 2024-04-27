import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app/themes/light_theme.dart';

class ProductPage extends StatefulWidget {

  final QueryDocumentSnapshot productData;
  const ProductPage({super.key, required this.productData});

  @override
  State<StatefulWidget> createState() => ProductPageState();

}

class ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightMode.colorScheme.secondaryContainer,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              Container(
                width: constraints.maxWidth,
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30
                ),
                color: lightMode.colorScheme.secondaryContainer,
                child: Image.network(
                  widget.productData['image'],
                  width: constraints.maxWidth/2,
                ),
              ),
              ProductInfo(productData: widget.productData),

            ],
          );
        },

      ),
      bottomNavigationBar: ProductOrderBar(productData: widget.productData,),
    );
  }

}

class ProductInfo extends StatelessWidget {
  final QueryDocumentSnapshot productData;
  const ProductInfo({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productData['title'],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              '${productData['weight'].toString()} г',
              style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14
              ),
            ),
          ),
          const Text(
            'Пищевая ценность',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16
            ),
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Калории',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16
                  ),
                ),
                Text(
                  '${productData['nutritional-value-per-100-g'].toString()}/100г',
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16
                  ),
                ),
              ],
            ),
          ),
          productData['have-side-dish']?Container(
            height: 300,
            child: SideDishMenu()
          ):Container()
        ],
      ),
    );
  }

}

class ProductOrderBar extends StatefulWidget {

  final QueryDocumentSnapshot productData;
  const ProductOrderBar({super.key, required this.productData, });


  @override
  State<StatefulWidget> createState() => ProductOrderBarState();

}

class ProductOrderBarState extends State<ProductOrderBar> {

  late int _productPrice;
  late int _totalCost;
  int _productCount = 1;

  @override
  void initState() {
    _productPrice = widget.productData['cost'];
    _totalCost = _productPrice;
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _productCount++;
      _totalCost = _productCount * _productPrice;
    });
  }

  void _decrementCounter() {
    setState(() {
      if(_productCount > 1) {
        _productCount--;
        _totalCost = _productCount * _productPrice;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lightMode.colorScheme.primaryContainer
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: _decrementCounter,
                  icon: const Icon(Icons.remove)
              ),
              Text(
                  _productCount.toString()
              ),
              IconButton(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add)
              ),
            ],
          ),
          TextButton(
              onPressed: () {},
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(180, 40)),
              backgroundColor: MaterialStateProperty.all<Color>(lightMode.colorScheme.primary)
            ),
              child: Text(
                'В корзину ${_totalCost.toString()}₽',
                style: TextStyle(
                    color: lightMode.colorScheme.onPrimaryContainer
                ),
              ),
          )
        ],
      ),
    );
  }

}

class SideDishMenu extends StatefulWidget {
  const SideDishMenu({super.key});

  @override
  State<StatefulWidget> createState() => SideDishMenuState();

}

class SideDishMenuState extends State<SideDishMenu> {

  int selected = 0;

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection('product/side-dish/side-dish')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  String title = snapshot.data!.docs.elementAt(index)['title'];
                  var image = snapshot.data!.docs.elementAt(index)['image'];
                  int weight = snapshot.data!.docs.elementAt(index)['weight'];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: RadioListTile(
                      selectedTileColor: lightMode.colorScheme.primary,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.network(image),
                          ),
                          Text(title),
                          Text('$weightг'),
                        ],
                      ),
                      value: index,
                      groupValue: selected,
                      onChanged: (value) {
                        setState(() {
                          selected = value!;
                        });
                      },
                    ),
                  );
                }
            );
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }

}

