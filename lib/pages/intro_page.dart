import 'package:flutter/material.dart';

// Эта странцица будет использована для регистрации

class IntroPage extends StatelessWidget{
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/fusion-logo.png'),
              width: 250,
              height: 250,
            ),
          ],
        ),
      ),
    );
  }

}