import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:anti_anxiety/login_register_auth/widget_tree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Fix the constructor usage here

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: WidgetTree());
  }
}
