import 'package:flutter/material.dart';
import 'package:fusion_app/pages/home_page.dart';
import 'package:fusion_app/pages/qr_page.dart';
import 'package:fusion_app/themes/light_theme.dart';

class FABBottomNavigationBarItem {
  FABBottomNavigationBarItem({required this.iconData, required this.text, required this.style});
  IconData iconData;
  String text;
  TextStyle style;
}

class FABBottomNavigationBar extends StatefulWidget {

  final List<FABBottomNavigationBarItem> items = [
    FABBottomNavigationBarItem(
        text: 'Главная',
        iconData: Icons.home_outlined,
        style: TextStyle(decoration: TextDecoration.underline)
    ),
    FABBottomNavigationBarItem(
        text: 'Заказать',
        iconData: Icons.menu_sharp,
        style: TextStyle(decoration: TextDecoration.none)
    ),
    FABBottomNavigationBarItem(
        text: 'Корзина',
        iconData: Icons.shopping_cart_outlined,
        style: TextStyle(decoration: TextDecoration.none)
    ),
    FABBottomNavigationBarItem(
        text: 'Профиль',
        iconData: Icons.person_outlined,
        style: TextStyle(decoration: TextDecoration.none)
    ),
  ];

  final ButtonStyle _buttonStyle = ButtonStyle(
    shape: const MaterialStatePropertyAll(CircleBorder()),
    foregroundColor: MaterialStatePropertyAll<Color>(lightMode.colorScheme.onPrimaryContainer),
  );

  FABBottomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => _FABBottomNavigationBarState();

}

class _FABBottomNavigationBarState extends State<FABBottomNavigationBar> {

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    HomePage(),
    Text('Order'),
    Text('cart'),
    Text('profile'),
    QrPage()
  ];
  
  _updateIndex(int index) {
    setState(() {
      if(_selectedIndex != 4) {
        widget.items[_selectedIndex].style = TextStyle(
            decoration: TextDecoration.none,
            color: lightMode.colorScheme.onPrimaryContainer);
      }
      if(index != 4) {
        widget.items[index].style = TextStyle(
            decoration: TextDecoration.underline,
            color: lightMode.colorScheme.onPrimaryContainer);
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FABBottomNavigationBarItem> items = widget.items;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      body: _widgetOptions[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () { _updateIndex(4); },
        backgroundColor: theme.colorScheme.primary,
        shape: const CircleBorder(),
        elevation: 2,
        child: const Icon(Icons.qr_code_outlined),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: const CircularNotchedRectangle(),
        color: theme.colorScheme.primaryContainer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
                onPressed: () {_updateIndex(0);},
                style: widget._buttonStyle,
                child: Column(
                    children: [
                      Icon(widget.items[0].iconData),
                      Text(widget.items[0].text, style: widget.items[0].style)
                    ]
                )
            ),
            TextButton(
                onPressed: () {_updateIndex(1);},
                style: widget._buttonStyle,
                child: Column(
                    children: [
                      Icon(widget.items[1].iconData),
                      Text(widget.items[1].text, style: widget.items[1].style)
                    ]
                )
            ),
            TextButton(
                onPressed: () {_updateIndex(2);},
                style: widget._buttonStyle,
                child: Column(
                    children: [
                      Icon(widget.items[2].iconData),
                      Text(widget.items[2].text, style: widget.items[2].style)
                    ]
                )
            ),
            TextButton(
                onPressed: () {_updateIndex(3);},
                style: widget._buttonStyle,
                child: Column(
                    children: [
                      Icon(widget.items[3].iconData,),
                      Text(widget.items[3].text, style: widget.items[3].style)
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }

}

