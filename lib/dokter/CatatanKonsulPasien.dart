import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BeriCatatanKonsultasi.dart';
import 'dart:async';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';

class CatatanKonsulPasien extends StatefulWidget {
  const CatatanKonsulPasien({Key? key});

  @override
  State<CatatanKonsulPasien> createState() => _CatatanKonsulPasienState();
}

class _CatatanKonsulPasienState extends State<CatatanKonsulPasien> {
  List<Map<String, dynamic>> items = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  @override
  void initState() {
    super.initState();
    getCatatanKonsultasi();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Future<String> getConnectID() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (snapshot.exists) {
          String connectID = snapshot.data()?['connect_id'] ?? '';
          return connectID;
        }
      }
      return '';
    } catch (e) {
      print('Error fetching connect ID: $e');
      return '';
    }
  }

  Future<void> getCatatanKonsultasi() async {
    try {
      String pasienUid = await getConnectID();
      print(pasienUid);
      subscription = FirebaseFirestore.instance
          .collection('catatan_konsultasi')
          .where('id_pasien', isEqualTo: pasienUid)
          .snapshots()
          .listen((snapshot) {
        List<Map<String, dynamic>> fetchedItems = snapshot.docs.map((doc) {
          return {
            "pasien": doc['nama_pasien'],
            "dokter": doc['nama_dokter'],
            "tgl": doc['tgl_waktu_catatan'],
            "isi": doc['isi_catatan'],
          };
        }).toList();

        setState(() {
          items = fetchedItems;
        });
      });
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    }
    return '';
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
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 10,
            child: ListTile(
              title: Text("${items[index]["tgl"]}"),
              subtitle: Text("${items[index]["isi"]}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BeriCatatan()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
