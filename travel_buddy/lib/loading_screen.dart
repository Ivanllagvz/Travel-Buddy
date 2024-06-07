// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 6), () {});
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);

    return Scaffold(
      backgroundColor: componentes,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100), 
            const Text(
              'Travel Buddy',
              style: TextStyle(
                fontFamily: 'Pattaya',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
            const SizedBox(height: 80), 
            Image.asset(
              'assets/carga.gif',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
