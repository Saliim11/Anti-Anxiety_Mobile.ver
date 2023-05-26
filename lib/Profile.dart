import 'package:flutter/material.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:anti_anxiety/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pasien/EditProfile.dart';
import 'dart:async';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _usernameFromFirestore = '';
  String _userEmail = '';
  String _role = '';

  Stream<String> _getUsernameFromFirestore() async* {
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
        String username = data['nama'] ?? '';
        setState(() {
          _usernameFromFirestore = username;
        });
        yield username;
      }
    }
  }

  StreamSubscription<String>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _getUsernameFromFirestore().listen((String username) {
      // do something with the new username
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> signOut() async {
    Auth auth = Auth();
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  bool isConnected = false;

  void checkConnectID() async {
    final currentUserUid = Auth().currentUser?.uid;

    if (currentUserUid != null) {
      final currentUserSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();

      if (currentUserSnapshot.exists) {
        final connectID = currentUserSnapshot['connect_id'];

        if (connectID.isNotEmpty) {
          final connectUserSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(connectID)
              .get();

          if (mounted && connectUserSnapshot.exists) {
            setState(() {
              isConnected = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              isConnected = false;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkConnectID();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Profil',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _usernameFromFirestore,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Pasien',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 125),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              icon: Icon(Icons.person),
              label: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 54, 90),
                minimumSize: Size(355, 50),
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text(
                        'No',
                        style: TextStyle(color: Color(0xFF01365A)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        signOut();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF01365A))),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              icon: Icon(Icons.logout),
              label: Text('Log Out'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 54, 90),
                minimumSize: Size(355, 50),
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
