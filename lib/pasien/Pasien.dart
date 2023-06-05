import 'package:flutter/material.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home.dart';
import 'NotePage.dart';
import '../Profile.dart';

class Pasien extends StatefulWidget {
  const Pasien({Key? key}) : super(key: key); // Fix the constructor usage here

  @override
  State<Pasien> createState() => _PasienState();
}

class _PasienState extends State<Pasien> {
  int _selectedIndex = 1;

  String _usernameFromFirestore = '';
  String _userEmail = '';
  void _getUsernameFromFirestore() async {
    setState(() {
      _userEmail = Auth().currentUser?.email ?? '';
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _userEmail)
        .get();

    if (mounted && querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot snapshot = querySnapshot.docs.first;
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        setState(() {
          _usernameFromFirestore = data['nama'] ?? '';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsernameFromFirestore();
  }

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
    // final User? user = Auth().currentUser;
    // _userEmail = user?.email ?? '';
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
                      'Hello, $_usernameFromFirestore',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Positioned(
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
