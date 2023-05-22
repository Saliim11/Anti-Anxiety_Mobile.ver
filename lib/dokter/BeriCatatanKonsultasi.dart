import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';

class BeriCatatan extends StatefulWidget {
  const BeriCatatan({super.key});

  @override
  State<BeriCatatan> createState() => _BeriCatatanState();
}

final User? user = Auth().currentUser;
String namaPasien = "";

class _BeriCatatanState extends State<BeriCatatan> {

  Future<void> fetchNamaPasien() async {
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

      // if (connectId == '') {
      //   namaPasien = "";
      // }

      // setState(() {
      //   isButtonEnabled = connectId != '';
      // });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void initState() {
    super.initState();
    fetchNamaPasien();
  }

  late Map<String, dynamic> detailList = {
    "nama": "Dr Marisa",
    "posisi": "PSIKOLOG",
    "tanggal": "07/04/2023",
    "isi":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam elementum fringilla pulvinar. Duis massa arcu, pulvinar a convallis at, tincidunt ut risus. Donec interdum turpis a quam aliquam fringilla. Mauris fringilla ipsum sed justo convallis suscipit. Fusce eget semper massa. Vestibulum ac ipsum lobortis, finibus ipsum et, dignissim leo. Pellentesque id turpis non justo placerat varius ac nec ante. Donec scelerisque odio id mauris malesuada mattis. Curabitur dignissim sit amet lorem sed efficitur. Praesent pellentesque hendrerit nulla, eget vestibulum mauris lacinia in. Vivamus mauris leo, pulvinar et tristique id, suscipit at odio. Aenean scelerisque lacinia cursus. Maecenas a magna mauris. Etiam at cursus mi.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam elementum fringilla pulvinar. Duis massa arcu, pulvinar a convallis at, tincidunt ut risus. Donec interdum turpis a quam aliquam fringilla. Mauris fringilla ipsum sed justo convallis suscipit. Fusce eget semper massa. Vestibulum ac ipsum lobortis, finibus ipsum et, dignissim leo.",
  };

  String isiPesanKonsultasi = "";

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
            // info nama pasien dan tanggal
            Container(
              padding: const EdgeInsets.only(left: 45, top: 30),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "To : $namaPasien",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
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
              ]),
            ),

            const SizedBox(
              height: 20,
            ),

            //------------------------Text Field-----------------------
            Container(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                maxLines: 15,
                decoration: const InputDecoration(
                    hintText: 'Masukkan pesan...',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 10))),
                onChanged: (value) => isiPesanKonsultasi = value,
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
                      onPressed: () {},
                      style: ButtonStyle(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            Text("Data"),
                            Icon(
                              Icons.send,
                            )
                          ],
                        ),
                      )),
                )
              ],
            )
            // ElevatedButton(
            //     onPressed: () {},
            //     child: Container(
            //       height: 50,
            //       width: 80,
            //       color: Colors.black,
            //       child: Row(
            //         children: [
            //           Text("Submit"),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Icon(Icons.send)
            //         ],
            //       ),
            //       // decoration: BoxDecoration(
            //       //   color: Colors.black,
            //       // ),
            //     )),
          ],
        ),
      )),
    );
  }
}
