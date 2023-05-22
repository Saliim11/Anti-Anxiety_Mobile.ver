import 'package:flutter/material.dart';

// ignore: camel_case_types
class detailKonsul extends StatelessWidget {
  const detailKonsul({super.key, required this.detailList});

  final Map<String, dynamic> detailList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, top: 40, bottom: 10),
            child: Row(
              children: [
                Text(
                  "With : ${detailList["nama"]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Psikolog",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Date : ${detailList["tanggal"]}",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF01365A),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 500,
              width: 300,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, right: 20, bottom: 30, left: 20),
                  child: Text(
                    detailList["isi"],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
