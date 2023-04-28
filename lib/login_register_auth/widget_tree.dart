import 'package:anti_anxiety/login_register_auth/auth.dart';
import 'package:anti_anxiety/pasien/Home.dart';
import 'package:anti_anxiety/LoginPage.dart';
import 'package:anti_anxiety/pasien/Pasien.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key})
      : super(key: key); // Fix the constructor usage here

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Pasien();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
