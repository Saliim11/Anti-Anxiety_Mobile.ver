import 'package:flutter/material.dart';
import '../chat/text_composer.dart';
import '../chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Firebase/login_register_auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailDokter extends StatefulWidget {
  const DetailDokter({Key? key}) : super(key: key);

  @override
  _DetailDokterState createState() => _DetailDokterState();
}

String selectedDoctor = "";

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
        final connectUserRef =
            FirebaseFirestore.instance.collection('users').doc(connectID);

        connectUserRef.get().then((connectUserSnapshot) {
          if (connectUserSnapshot.exists) {
            final selectedDoctor = connectUserSnapshot['nama'];
            // Use the selectedDoctor variable as needed
          }
        });
      } else {
        selectedDoctor = '';
      }
    }
  }
}

class _DetailDokterState extends State<DetailDokter> {
  void initState() {
    super.initState();
    checkConnectID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 54, 90),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Detail Dokter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/random/200x200',
              ),
            ),
            SizedBox(height: 16),
            Text(
              selectedDoctor,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bandar Lampung',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => ChatPage()));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              icon: Icon(Icons.chat),
              label: Text('Chat Dokter'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF01365A)),
                fixedSize: MaterialStateProperty.all(Size(275, 55)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
