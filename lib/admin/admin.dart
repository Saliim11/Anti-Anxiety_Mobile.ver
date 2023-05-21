import 'package:flutter/material.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home_admin.dart';
import '../Profile.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key); 

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _selectedIndex = 0;

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

    if (querySnapshot.docs.isNotEmpty) {
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
    HomePageAdmin(),
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
