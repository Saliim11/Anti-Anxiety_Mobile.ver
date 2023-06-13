import 'package:anti_anxiety/RegisterPage.dart';
import 'package:anti_anxiety/admin/admin.dart';
import 'package:anti_anxiety/pasien/Pasien.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dokter/dokter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errMsgLogin1 = '';
  String? errMsgLogin2 = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errMsgLogin1 = e.message;
      });
    }
  }

  Future<bool> _loginPressed() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      return userCredential.user !=
          null; // Check if userCredential.user is not null
    } catch (e) {
      // Handle login error, e.g. display error message
      setState(() {
        errMsgLogin2 = e.toString();
      });
      return false;
    }
  }

  // ----------------------------------------------------------------------Method Login---------------------------------------------------------------------------------
  void _onLoginButtonPressed() async {
    bool isLoggedIn = await _loginPressed();
    if (isLoggedIn && mounted) {
      // Get the current user's document from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Get the user's role from the document
      final role = userDoc['role'];
      print(role);

      // Navigate to the appropriate screen based on the user's role
      if (role == 'Pasien') {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Pasien()),
          );
        }
      } else if (role == 'Psikolog' || role == 'Psikiater') {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dokter()),
          );
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Admin()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.0),
              child: Text(
                'Welcome Back !',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: Image.asset(
                "assets/background.png",
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.0),
              child: TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.0),
              child: TextField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            Text('$errMsgLogin1'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text('$errMsgLogin2'),
            ),
            const SizedBox(
              height: 250,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Pasien()));
                    _onLoginButtonPressed();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF01365A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Don't have account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Text('Login error : $errMsg'),
          ],
        ),
      ),
    );
  }
}