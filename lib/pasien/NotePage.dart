import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detail_consul.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final List<Map<String, dynamic>> consulNote = [];

  @override
  void initState() {
    super.initState();
    fetchConsultationNotes();
  }

  Future<void> fetchConsultationNotes() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final currentUserUID = currentUser.uid;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('catatan_konsultasi') // Replace with your collection name
          .where('id_pasien', isEqualTo: currentUserUID)
          .get();

      // "isiList" : data["formFirebase"]
      querySnapshot.docs.forEach((doc) {
        final data = doc.data();
        final consultationNote = {
          'nama': data['nama_dokter'],
          'tanggal': data['tgl_waktu_catatan'],
          'isi': data['isi_catatan'],
        };
        consulNote.add(consultationNote);
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Consultation Notes',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: consulNote.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Color(0xFF01365A), width: 20)),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => detailKonsul(
                                          detailList: consulNote[index],
                                        ),
                                      ),
                                    );
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 15,
                                        bottom: 30,
                                        right: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "With : ${consulNote[index]["nama"]}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Dokter",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Date : ${consulNote[index]["tanggal"]}",
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
