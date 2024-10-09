import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4),() {
      Navigator.pushReplacementNamed(context, '/home');
    },);
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/img/bg.png')),
      ),
    );
  }
}
