import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anti_anxiety/login_register_auth/auth.dart';

import 'Home.dart';
import 'NotePage.dart';
import 'Profile.dart';

class Pasien extends StatefulWidget {
  const Pasien({Key? key}) : super(key: key); // Fix the constructor usage here

  @override
  State<Pasien> createState() => _PasienState();
}

class _PasienState extends State<Pasien> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    NotePage(),
    HomePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    String _userEmail = user?.email ?? '';
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      'Hello, $_userEmail',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/200',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels:
            false, 
        showUnselectedLabels:
            false, 
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_day_sharp),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
