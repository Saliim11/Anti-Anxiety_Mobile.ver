import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat/private_chat.dart';

import 'CatatanKonsulPasien.dart';

final User? user = Auth().currentUser;
String namaPasien = "";

class HomePageDokter extends StatefulWidget {
  const HomePageDokter({Key? key}) : super(key: key);

  @override
  State<HomePageDokter> createState() => _HomePageDokterState();
}

class _HomePageDokterState extends State<HomePageDokter> {
  bool isButtonEnabled = false;
  String _connectID = '';
  @override
  void initState() {
    super.initState();
    fetchUserData((connectID) {
      _connectID = connectID;
    });
  }

  Future<void> fetchUserData(
      void Function(String connectID) onConnectIDReceived) async {
    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      final connectId = userSnapshot.get('connect_id');
      print("Ini connectID : $connectId");

      if (connectId != '') {
        final DocumentSnapshot pasienSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(connectId)
            .get();
        namaPasien = pasienSnapshot.get('nama');
      }

      if (connectId == '') {
        namaPasien = "";
      }

      setState(() {
        isButtonEnabled = connectId != '';
      });

      onConnectIDReceived(
          connectId); // Pass the connectID to the callback function
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void deleteConnectID() async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);

      // Fetch docA
      final userDocSnapshot = await userDocRef.get();
      final connectID = userDocSnapshot.get('connect_id');

      // Search for docB
      if (connectID != '') {
        final pasienDocRef =
            FirebaseFirestore.instance.collection('users').doc(connectID);
        final pasienDocSnapshot = await pasienDocRef.get();

        // Update "connect_id" field in docA to empty
      await userDocRef.update({'connect_id': ''});

      // Update "connect_id" field in docB to empty
      await pasienDocRef.update({'connect_id': ''});

      setState(() {
        isButtonEnabled = false;
      });
      }

      const snackBar = SnackBar(
        content: Text('Berhasil menyelesaikan konsultasi!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print('Error deleting connect ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardButton(
                title: namaPasien,
                imagePath: 'assets/pasien.png',
                onTap: () {
                  // untuk trigger
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      userUid: Auth().currentUser!.uid,
                                      otherUserUid: _connectID)));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary:
                            isButtonEnabled ? Color(0xFF01365A) : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Chat Pasien',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CatatanKonsulPasien()));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary:
                            isButtonEnabled ? Color(0xFF01365A) : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Consultation Notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 54,
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? deleteConnectID : null,
                  style: ElevatedButton.styleFrom(
                    primary: isButtonEnabled ? Color(0xFF01365A) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Finish Consultation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CardButton({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 160,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 95,
                width: 95,
              ),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
