import 'package:flutter/material.dart';
import 'package:anti_anxiety/login_register_auth/auth.dart';
import 'package:anti_anxiety/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'EditProfile.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  Future<void> signOut() async {
    Auth auth = Auth();
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final User? user = Auth().currentUser;
    // String _userEmail = user?.email ?? '';
    //? Nyoba get from firestore
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
                    // backgroundImage: AssetImage('/assets/psikiater.png'),
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
              onPressed: () {
                signOut();
              },
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

