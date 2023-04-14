import 'package:flutter/material.dart';
import 'detail_consul.dart';

final List<Map<String, dynamic>> consulNote = [
  {
    "nama": "Dr Marisa",
    "posisi": "PSIKOLOG",
    "tanggal": "07/04/2023",
    "isi":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam elementum fringilla pulvinar. Duis massa arcu, pulvinar a convallis at, tincidunt ut risus. Donec interdum turpis a quam aliquam fringilla. Mauris fringilla ipsum sed justo convallis suscipit. Fusce eget semper massa. Vestibulum ac ipsum lobortis, finibus ipsum et, dignissim leo. Pellentesque id turpis non justo placerat varius ac nec ante. Donec scelerisque odio id mauris malesuada mattis. Curabitur dignissim sit amet lorem sed efficitur. Praesent pellentesque hendrerit nulla, eget vestibulum mauris lacinia in. Vivamus mauris leo, pulvinar et tristique id, suscipit at odio. Aenean scelerisque lacinia cursus. Maecenas a magna mauris. Etiam at cursus mi.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam elementum fringilla pulvinar. Duis massa arcu, pulvinar a convallis at, tincidunt ut risus. Donec interdum turpis a quam aliquam fringilla. Mauris fringilla ipsum sed justo convallis suscipit. Fusce eget semper massa. Vestibulum ac ipsum lobortis, finibus ipsum et, dignissim leo.",
  },
  {
    "nama": "Dr Sulistyo",
    "posisi": "PSIKIATER",
    "tanggal": "12/01/2023",
    "isi": "nalalabnlfhna",
  },
  {
    "nama": "Dr Sulistyo",
    "posisi": "PSIKIATER",
    "tanggal": "12/01/2023",
    "isi": "nalalabnlfhna",
  },
  {
    "nama": "Dr Sulistyo",
    "posisi": "PSIKIATER",
    "tanggal": "12/01/2023",
    "isi": "nalalabnlfhna",
  },
  {
    "nama": "Dr Sulistyo",
    "posisi": "PSIKIATER",
    "tanggal": "12/01/2023",
    "isi": "nalalabnlfhna",
  },
];

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
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
                                              detailList: consulNote[index])));
                                },
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 15, bottom: 30, right: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "With : ${consulNote[index]["nama"]}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              consulNote[index]["posisi"],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
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
    ));
  }
}
