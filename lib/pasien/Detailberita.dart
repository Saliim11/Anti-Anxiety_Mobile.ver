import 'package:flutter/material.dart';

class DetailNews extends StatefulWidget {
  const DetailNews({super.key});

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

List<Map<String, dynamic>> dataList = [
  {
    "Nama": "tanda-tanda enxiety",
    "Kelas1": "Lorem Ipsum",
    "gambar":"../../assets/strees.png",
    "kelas2":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  },
  {
    "Nama": "gejala anxiety",
    "Kelas1": "Lorem Ipsum",
    "gambar":"../../assets/melotot.jpg",
    "kelas2":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  },
];
List<String> warna = [' blue', ' yellow ', 'green'];
var title = TextEditingController();
var platform = TextEditingController();
var lang = TextEditingController();

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    String pilih_warna = warna.first;
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
                        //borderRadius: BorderRadius.circular(15),
                        border: Border(
                            left: BorderSide(color: Colors.blue, width: 10))),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        // child: Container(
                        //   width: 60,
                        //   height: 60,
                        //   child: Image.asset(dataList[index]["gambar"]),
                        // ),
                      ),
                      title: Text(dataList[index]["Nama"]),
                      subtitle: Text(dataList[index]["Kelas1"]),
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
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> dataList;

  DetailScreen({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Detail")),
      body: Center(
        child: Container(
          height: 500,
          width: 350,
          child: Card(
            elevation: 10,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  child: Image.asset(dataList["gambar"]),

                ),
              ),
              title: Text(dataList["Nama"]),

              subtitle: Text(dataList["kelas2"]),
            ),

            // child:Image.asset('assets/strees.png'),

            // child: Padding(

            //   padding: EdgeInsets.all(16),
            //   child: Column(
            //     children: <Widget>[
            //       Text(
            //         " ${dataList["Nama"]}",
            //         style: TextStyle(
            //           color: Colors.blue,
            //           fontSize: 22,
            //         ),
            //       ),
            //       SizedBox(height: 10),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(" ${dataList["kelas2"]}"),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
