import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff000f18)
          ),
          child: Center(
            child: Image.asset(
              'lib/asset/SplashScree.png', // Replace with your image asset
              fit: BoxFit.cover, // Scale the image to fit within the screen
            ),
          ),
        ),
      ),
    );
  }
}
