import 'package:flutter/material.dart';

class DetailDokter extends StatefulWidget {
  const DetailDokter({Key? key}) : super(key: key);

  @override
  _DetailDokterState createState() => _DetailDokterState();
}

class _DetailDokterState extends State<DetailDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 54, 90),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Detail Informasi'),
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
              'Nama Dokter',
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
              onPressed: () {},
              icon: Icon(Icons.chat),
              label: Text('Cek Dokter'),
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
