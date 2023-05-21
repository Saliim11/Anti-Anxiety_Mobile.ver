import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'BeriCatatanKonsultasi.dart';

class CatatanKonsulPasien extends StatefulWidget {
  const CatatanKonsulPasien({super.key});

  @override
  State<CatatanKonsulPasien> createState() => _CatatanKonsulPasienState();
}

class _CatatanKonsulPasienState extends State<CatatanKonsulPasien> {
  final List<Map<String, dynamic>> items = [
    {
      "namaP": "Yanto",
      "dokter": "Saliim",
      "tgl": "5/21/2023",
      "isi": "jangan lupa makan"
    },
    {
      "namaP": "Yanto",
      "dokter": "Panji",
      "tgl": "5/13/2023",
      "isi": "perbanyak tidur yang benar"
    }
  ];

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
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BeriCatatan()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
