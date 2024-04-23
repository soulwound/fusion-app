import 'package:flutter/material.dart';
import 'package:fusion_app/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {

  final Uri termsOfUseUrl = Uri.parse('https://app.loyalhub.ru/FusionExpress/terms_of_service/');

  Future<void> openUrl(Uri urlString) async {
    launchUrl(urlString);
    /* if (await canLaunchUrl(urlString)) { // Check if the URL can be launched
      await launchUrl(urlString);
    } else {
      throw 'Could not launch $urlString'; // throw could be used to handle erroneous situations
    } */
  }

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('Виктор'),
            subtitle: Text('+7(921)610-87-10'),
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: lightMode.colorScheme.primaryContainer
              ),
              child: Icon(Icons.person_outline, size: 60),
            ),
          ),
          ListTile(
            title: Text('Мои данные'),
            leading: Icon(Icons.admin_panel_settings_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserDataPage()
                )
              );
            },
          ),
          ListTile(
            title: Text('История заказов'),
            leading: Icon(Icons.calendar_month_rounded),
            onTap: () {},
          ),
          ListTile(
            title: Text('Мои карты'),
            leading: Icon(Icons.credit_card_rounded),
            onTap: () {},
          ),
          ListTile(
            title: Text('О нас'),
            leading: Icon(Icons.info_rounded),
            onTap: () {},
          ),
          ListTile(
            title: Text('Выйти'),
            leading: Icon(Icons.exit_to_app_rounded),
            onTap: () {},
          ),
          TextButton(
              onPressed:() {}, //openUrl(termsOfUseUrl),
              child: Text('Условия пользования')
          )
        ],
      ),
    );
  }
}

class UserDataPage extends StatelessWidget{
  const UserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои данные'),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10
        ),
        child: const Column(
          children: [
            UserDataTextField(textFieldLabel: 'Ваше имя'),
            UserDataTextField(textFieldLabel: 'E-mail'),
            UserDataTextField(textFieldLabel: 'Дата рождения'),
            Row(
              children: [
                UserDataGenderRadio(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserDataTextField extends StatelessWidget{

  final String textFieldLabel;

  const UserDataTextField({super.key, required this.textFieldLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          label: Text(textFieldLabel, style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}

class UserDataGenderRadio extends StatefulWidget {
  const UserDataGenderRadio({super.key});


  @override
  State<StatefulWidget> createState() => UserDataGenderRadioState();

}

class UserDataGenderRadioState extends State<UserDataGenderRadio> {

  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserDataGenderRadioTile(
            value: 1,
            onChanged: (value) => setState(() { _value = value; }),
            leading: 'М',
            selectedValue: _value
        ),
        UserDataGenderRadioTile(
            value: 2,
            onChanged: (value) => setState(() { _value = value; }),
            leading: 'Ж',
            selectedValue: _value
        ),
      ],
    );
  }

}

class UserDataGenderRadioTile extends StatelessWidget {
  final int value;
  final int selectedValue;
  final String leading;
  final ValueChanged<int> onChanged;

  const UserDataGenderRadioTile({super.key, required this.value, required this.onChanged, required this.leading, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = (value == selectedValue);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      alignment: AlignmentDirectional.center,
      width: 75,
      decoration: BoxDecoration(
        color: isSelected ? lightMode.colorScheme.primary : null,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? lightMode.colorScheme.onPrimaryContainer : lightMode.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

}