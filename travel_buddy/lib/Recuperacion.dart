// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Recuperacion extends StatefulWidget {
  const Recuperacion({super.key});

  @override
  _RecuperacionState createState() => _RecuperacionState();
}

class _RecuperacionState extends State<Recuperacion> {
  final TextEditingController emailController = TextEditingController();

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Fluttertoast.showToast(
          msg: "Correo de recuperación enviado. Revisa tu correo.");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.message}");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Travel Buddy',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Pattaya',
          ),
        ),
        centerTitle: true,
        backgroundColor: fondo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [fondo, componentes],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Recuperación',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'FugazOne',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/recuperacion.gif'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Introduzca su correo electrónico',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pattaya',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: componentes,
                      hintText: 'Correo electrónico',
                      hintStyle: const TextStyle(
                          color: Colors.white, fontFamily: 'Times New Roman'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: fondo,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: fondo,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: fondo,
                          width: 2,
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Se le enviará un enlace a su cuenta de correo electrónico para que pueda actualizar su contraseña, en caso de no disponer del correo, revise su carpeta de SPAM, por favor.',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: componentes,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: fondo,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Recuperar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontFamily: 'Caveat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
