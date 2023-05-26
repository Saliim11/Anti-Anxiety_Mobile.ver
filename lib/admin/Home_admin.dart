import 'package:anti_anxiety/admin/admin.dart';
import 'package:anti_anxiety/pasien/Pasien.dart';
import 'package:flutter/material.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key); // Add 'const' here

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DetailNews(),
      ),
    );
  }
}

class DetailNews extends StatefulWidget {
  const DetailNews({Key? key});

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

// List<Map<String, dynamic>> dataList = [
//   {
//     "Nama": "tanda-tanda anxiety",
//     "Kelas1": "Lorem Ipsum",
//     "kelas2":
//         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
//   },
//   {
//     "Nama": "gejala anxiety",
//     "Kelas1": "Lorem Ipsum",
//     "kelas2":
//         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
//   },
// ];
// List<String> warna = [' blue', ' yellow ', 'green'];
var title = TextEditingController();
var platform = TextEditingController();
var lang = TextEditingController();

class _DetailNewsState extends State<DetailNews> {
  List<Map<String, dynamic>> dataList = [];
  late StreamSubscription<List<Map<String, dynamic>>> subscription;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  StreamSubscription<List<Map<String, dynamic>>> fetchDataFromFirestore() {
    return FirebaseFirestore.instance
        .collection('informasi')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return {
          "Judul": doc['judul'],
          "Source": doc['source'],
          "Isi": doc['isi'],
        };
      }).toList();
    }).listen((List<Map<String, dynamic>> newDataList) {
      setState(() {
        dataList = newDataList; // Update the dataList when new data arrives
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // String pilih_warna = warna.first;
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: Color(0xFF01365A), width: 10))),
                    child: ListTile(
                      title: Text(dataList[index]["Judul"]),
                      subtitle: Text(dataList[index]["Source"]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(dataList: dataList[index])),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahKonsultasi()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> dataList;

  DetailScreen({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.black,
                  )),
            ],
          ),
          Center(
            child: Container(
              height: 500,
              width: 350,
              child: Card(
                elevation: 10,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        " ${dataList["Judul"]}",
                        style: TextStyle(
                          color: Color(0xFF01365A),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" ${dataList["Isi"]}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class TambahKonsultasi extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Card Example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: MyCard(),
//       ),
//     );
//   }
// }

// class MyCard extends StatefulWidget {
//   @override
//   _MyCardState createState() => _MyCardState();
// }

class TambahKonsultasi extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _sourceController = TextEditingController();
  TextEditingController _photoController = TextEditingController();

  void createDocument() async {
    String title = _titleController.text;
    String content = _contentController.text;
    String source = _sourceController.text;

    try {
      await FirebaseFirestore.instance.collection('informasi').add({
        'judul': title,
        'isi': content,
        'source': source,
        'tgl_pembuatan': DateFormat('dd MMMM yyyy').format(DateTime.now()),
        'gambar': _photoController.text,
      });

      // Document created successfully
      print('Document created successfully');
    } catch (e) {
      // Error occurred while creating document
      print('Error creating document: $e');
    }
  }

  // @override
  // void dispose() {
  //   _textEditingController.dispose();
  //   _titleController.dispose();
  //   _contentController.dispose();
  //   _sourceController.dispose();
  //   _dateController.dispose();
  //   super.dispose();
  // }

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Admin()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _contentController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    labelText: 'Isi',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _sourceController,
                  decoration: InputDecoration(
                    labelText: 'Sumber',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _photoController,
                  decoration: InputDecoration(
                    labelText: 'Link foto',
                  ),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    createDocument();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Admin()),
                    );
                    const snackBar = SnackBar(
                      content: Text('Informasi telah berhasil ditambahkan!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 1, 54, 90))),
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
