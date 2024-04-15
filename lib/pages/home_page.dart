import 'package:flutter/material.dart';
import 'package:fusion_app/themes/light_theme.dart';

class HomePage extends StatelessWidget{

  HomePage({super.key});

  bool isQRMenuExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Фиксит баг внизу у кнопки QR, но цвет остального придется менять
      // backgroundColor: lightMode.colorScheme.primaryContainer,
      body: ListView(
        children: [
          ListTile(
            title: Text('Виктор'),
            subtitle: Text('+7(921)610-87-10'),
            leading: Container(
              child: Icon(Icons.person_outline, size: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lightMode.colorScheme.primaryContainer
              ),
            ),
          ),
          QRMenu(),
          BallBalance(balance:12),
          NewsBlock()
        ],
      ),
    );
  }
}

class QRMenu extends StatefulWidget {
  const QRMenu({super.key});

  @override
  State<StatefulWidget> createState() => QRMenuState();

}

// TODO: Попробовать Hero для анимации

class QRMenuState extends State<QRMenu>{

  bool isExpanded = false;

  late Widget _currentMenu;

  @override
  void initState() {
    _currentMenu = qrMenuCasual;
    super.initState();
  }

  Widget qrMenuCasual = LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image(
              image: AssetImage('assets/images/fusion-logo.png'),
              width: constraints.maxWidth / 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(
              image: AssetImage('assets/images/fusion-logo.png'),
              width: constraints.maxWidth / 2.2,
            ),
          ),
        ],
      );
    },
  );

  Widget qrMenuExpanded = LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image(
              image: AssetImage('assets/images/fusion-logo.png'),
              width: constraints.maxWidth / 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(
              image: AssetImage('assets/images/fusion-logo.png'),
              width: constraints.maxWidth / 2.2,
            ),
          ),
        ],
      );
    },
  );


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: lightMode.colorScheme.primary
        ),
        child: TextButton(
          onPressed: () {
            if(isExpanded) {
              setState(() {
                isExpanded = false;
                _currentMenu = qrMenuCasual;
              });
            }
            else {
              setState(() {
                isExpanded = true;
                _currentMenu = qrMenuExpanded;
              });
            }
          },
          child: _currentMenu
        ),
      ),
    );
  }
}

class BallBalance extends StatelessWidget{
  int balance;
  BallBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: lightMode.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'У вас $balance',
                  style: const TextStyle(
                    fontSize: 30
                  ),
                ),
                Icon(Icons.attach_money,size: 30)
              ],
            ),
            const Text(
              'Заказывайте и получайте баллы',
              style: TextStyle(
                fontSize: 20
              ),
            )
          ],
        ),
      ),
    );
  }
  
}

class NewsBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: lightMode.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: NewsNavigation(),
      ),
    );
  }
}

class NewsNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsNavigationState();

}

class NewsNavigationState extends State<NewsNavigation> with SingleTickerProviderStateMixin {

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Новости'),
    Tab(text: 'Акции'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: lightMode.colorScheme.primary
        ),
        labelColor: lightMode.colorScheme.onPrimaryContainer,
        unselectedLabelColor: lightMode.colorScheme.onPrimaryContainer,
        tabs: myTabs,
        controller: _tabController,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: lightMode.colorScheme.primaryContainer,
        ),
        child: TabBarView(
          clipBehavior: Clip.none,
          controller: _tabController,
          children: [
            Container(child: Text('Новости')),
            Text('Акции')
          ],
        ),
      ),
    );
  }
}
