import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';

class BeriCatatan extends StatefulWidget {
  @override
  _BeriCatatanState createState() => _BeriCatatanState();
}

class _BeriCatatanState extends State<BeriCatatan> {
  final User? user = Auth().currentUser;
  TextEditingController _isi = TextEditingController();

  Future<void> _createCatatanKonsultasi() async {
    try {
      final connectIdSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      final connectId = connectIdSnapshot.get('connect_id');

      final namaDokterSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();
      final namaDokter = namaDokterSnapshot.get('nama');

      final namaPasienSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(connectId)
          .get();
      final namaPasien = namaPasienSnapshot.get('nama');

      final catatanData = {
        'id_dokter': user?.uid,
        'id_pasien': connectId,
        'isi_catatan': _isi.text,
        'nama_dokter': namaDokter,
        'nama_pasien': namaPasien,
        'tgl_waktu_catatan': DateFormat('dd MMMM yyyy').format(DateTime.now()),
      };

      await FirebaseFirestore.instance
          .collection('catatan_konsultasi')
          .add(catatanData);

      _isi.clear(); // Clear the text field after submitting the data
    } catch (e) {
      print('Error creating catatan konsultasi: $e');
    }
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error fetching user data: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while fetching data
                  }

                  final connectId = snapshot.data?.get('connect_id');
                  print("Ini connectID: $connectId");

                  if (connectId != null && connectId.isNotEmpty) {
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(connectId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Error fetching patient data: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Show a loading indicator while fetching data
                        }

                        final namaPasien = snapshot.data?.get('nama') ?? '';
                        return Column(
                          children: [
                            // info nama pasien dan tanggal
                            Container(
                              padding: const EdgeInsets.only(left: 45, top: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "To: $namaPasien",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${DateFormat('dd MMMM yyyy').format(DateTime.now())}",
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //------------------------Text Field-----------------------
                            Container(
                              padding: EdgeInsets.all(30),
                              child: TextFormField(
                                controller: _isi,
                                maxLines: 15,
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan pesan...',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 10),
                                  ),
                                ),
                                onChanged: (value) {
                                  // Handle text field changes here
                                },
                              ),
                            ),

                            //-------------------------button submit-------------------------
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _createCatatanKonsultasi();
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 10,
                                        children: [
                                          Text("Data"),
                                          Icon(Icons.send),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return SizedBox(); // Return an empty container if there's no connectId
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
