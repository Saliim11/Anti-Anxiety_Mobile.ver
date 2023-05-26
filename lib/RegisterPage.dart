// import 'package:anti_anxiety/LoginPage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   String? errorMessage = '';

//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerNama = TextEditingController();
//   final TextEditingController _controllerTglLahir = TextEditingController();
//   final TextEditingController _controllerUsia = TextEditingController();
//   final TextEditingController _controllerKontak = TextEditingController();
//   final TextEditingController _controllerAlamat = TextEditingController();
//   final TextEditingController _controllerKota = TextEditingController();

//   // Future<void> createUserWithEmailAndPassword() async {
//   //   try {
//   //     await Auth().createUserWithEmailAndPassword(
//   //         email: _controllerEmail.text, password: _controllerPassword.text);
//   //     Navigator.of(context).pushReplacement(
//   //       MaterialPageRoute(
//   //         builder: (context) => LoginPage(),
//   //       ),
//   //     );
//   //   } on FirebaseAuthException catch (e) {
//   //     setState(() {
//   //       errorMessage = e.message;
//   //     });
//   //   }
//   // }

//   Future<void> createUserWithEmailAndPassword(_RadioUsersState radioState) async {
//   try {
//       UserCredential userCredential =
//           await Auth().createUserWithEmailAndPassword(
//               email: _controllerEmail.text,
//               password: _controllerPassword.text);

//       // Create a new document in the "users" collection with the user's email, password, and role
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set(
//             {
//               'username': _controllerUsername,
//               'password': _controllerPassword.text,
//               'email': _controllerEmail.text,
//               'nama': _controllerNama.text,
//               'tglLahir': _controllerTglLahir.text,
//               'role' : radioState.getSelectedValue(),
//               'usia': _controllerUsia.text,
//               'kontak': _controllerKontak.text,
//               'alamat': _controllerAlamat.text,
//               'kota': _controllerKota.text,
//               'stat_login': "off",
//               'connect_id': ""

//       });

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => LoginPage(),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Welcome!",
//                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),

//               Image.asset(
//                 'assets/background.png',
//                 height: 300,
//                 width: 300,
//               ),

//               // input username
//               TextField(
//                 controller: _controllerUsername,
//                 decoration: const InputDecoration(
//                   label: Text('Username'),
//                 ),
//               ),

//               // input password
//               TextField(
//                 controller: _controllerPassword,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   label: Text('Password'),
//                 ),
//               ),

//               // input email
//               TextField(
//                 controller: _controllerEmail,
//                 decoration: const InputDecoration(
//                   label: Text('Email'),
//                 ),
//               ),

//               // input nama
//               TextField(
//                 controller: _controllerNama,
//                 decoration: const InputDecoration(
//                   label: Text('Nama'),
//                 ),
//               ),

//               // date picker
//               TextField(
//                 controller: _controllerTglLahir,
//                 decoration: const InputDecoration(
//                   label: Text('Tgl Lahir *yyyy-MM-dd'),
//                 ),
//               ),

//               // RadioButton Role
//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 child: Text("Role")),
//               const RadioUsers(),

//               // input usia
//               TextField(
//                 controller: _controllerUsia,
//                 decoration: const InputDecoration(
//                   label: Text('Usia'),
//                 ),
//               ),

//               // input kontak
//               TextField(
//                 controller: _controllerKontak,
//                 decoration: const InputDecoration(
//                   label: Text('No Kontak'),
//                 ),
//               ),

//               // input alamat
//               TextField(
//                 controller: _controllerAlamat,
//                 decoration: const InputDecoration(
//                   label: Text('Alamat'),
//                 ),
//               ),

//               // input kota
//               TextField(
//                 controller: _controllerKota,
//                 decoration: const InputDecoration(
//                   label: Text('Kota'),
//                 ),
//               ),

//               SizedBox(height: 40),

//               ElevatedButton(
//                 onPressed: () {
//                   createUserWithEmailAndPassword(_RadioUsersState());
//                 },
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF01365A),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 child: Container(
//                     height: 50,
//                     width: 300,
//                     child: const Center(child: Text("Sign Up"))),
//               ),

//               const SizedBox(height: 20),

//               Text(errorMessage == '' ? '' : 'Error: $errorMessage'),

//               const SizedBox(height: 20),

//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                   );
//                 },
//                 child: const Text(
//                   "Already have an account? Sign In",
//                   style: TextStyle(fontSize: 16.0, color: Colors.black),
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum RoleUsers { Pasien, Dokter }

// class RadioUsers extends StatefulWidget {
//   const RadioUsers({super.key});

//   @override
//   State<RadioUsers> createState() => _RadioUsersState();
// }

// class _RadioUsersState extends State<RadioUsers> {
//   RoleUsers? _character = RoleUsers.Pasien;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           title: const Text('Pasien'),
//           leading: Radio<RoleUsers>(
//             value: RoleUsers.Pasien,
//             groupValue: _character,
//             onChanged: (RoleUsers? value) {
//               setState(() {
//                 _character = value;
//               });
//             },
//           ),
//         ),
//         ListTile(
//           title: const Text('Dokter'),
//           leading: Radio<RoleUsers>(
//             value: RoleUsers.Dokter,
//             groupValue: _character,
//             onChanged: (RoleUsers? value) {
//               setState(() {
//                 _character = value;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   String getSelectedValue() {
//     return _character.toString().split('.').last;
//   }
// }

import 'package:anti_anxiety/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerUsia = TextEditingController();
  final TextEditingController _controllerKontak = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerKota = TextEditingController();

  String _selectedRole = RoleUsers.Pasien.toString().split('.').last;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      // Create a new document in the "users" collection with the user's email, password, and role
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
        {
          'username': _controllerUsername.text,
          'password': _controllerPassword.text,
          'email': _controllerEmail.text,
          'nama': _controllerNama.text,
          'tglLahir': _controllerTglLahir.text,
          'role': _selectedRole,
          'usia': _controllerUsia.text,
          'kontak': _controllerKontak.text,
          'alamat': _controllerAlamat.text,
          'kota': _controllerKota.text,
          'stat_login': "off",
          'connect_id': "",
        },
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome!",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/background.png',
                  height: 300,
                  width: 300,
                ),
                // input nama
                TextField(
                  controller: _controllerNama,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                  ),
                ),
                // date picker
                TextField(
                  controller: _controllerTglLahir,
                  decoration: const InputDecoration(
                    labelText: 'Tgl Lahir *yyyy-MM-dd',
                  ),
                ),
                // input email
                TextField(
                  controller: _controllerEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                // input username
                TextField(
                  controller: _controllerUsername,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                // input password
                TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                // input usia
                TextField(
                  controller: _controllerUsia,
                  decoration: const InputDecoration(
                    labelText: 'Usia',
                  ),
                ),
                // input kontak
                TextField(
                  controller: _controllerKontak,
                  decoration: const InputDecoration(
                    labelText: 'No Kontak',
                  ),
                ),
                // input alamat
                TextField(
                  controller: _controllerAlamat,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                  ),
                ),
                // input kota
                TextField(
                  controller: _controllerKota,
                  decoration: const InputDecoration(
                    labelText: 'Kota',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // RadioButton Role
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Role",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RadioUsers(
                  onValueChanged: (selectedValue) {
                    setState(() {
                      _selectedRole = selectedValue;
                    });
                  },
                ),
                SizedBox(height: 40),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createUserWithEmailAndPassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF01365A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          height: 50,
                          width: 300,
                          child: const Center(child: Text("Sign Up")),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(errorMessage == '' ? '' : 'Error: $errorMessage'),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        // child: const Text(
                        //   "Already have an account? Sign In",
                        //   style: TextStyle(fontSize: 16.0, color: Colors.black),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum RoleUsers { Pasien, Psikolog, Psikiater }

class RadioUsers extends StatefulWidget {
  final ValueChanged<String> onValueChanged;

  const RadioUsers({Key? key, required this.onValueChanged}) : super(key: key);

  @override
  State<RadioUsers> createState() => _RadioUsersState();
}

class _RadioUsersState extends State<RadioUsers> {
  RoleUsers? _character = RoleUsers.Pasien;

  void _handleRadioValueChanged(RoleUsers? value) {
    setState(() {
      _character = value;
    });
    widget.onValueChanged(_character.toString().split('.').last);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Pasien'),
          leading: Radio<RoleUsers>(
            value: RoleUsers.Pasien,
            groupValue: _character,
            onChanged: _handleRadioValueChanged,
          ),
        ),
        ListTile(
          title: const Text('Psikolog'),
          leading: Radio<RoleUsers>(
            value: RoleUsers.Psikolog,
            groupValue: _character,
            onChanged: _handleRadioValueChanged,
          ),
        ),
        ListTile(
          title: const Text('Psikiater'),
          leading: Radio<RoleUsers>(
            value: RoleUsers.Psikiater,
            groupValue: _character,
            onChanged: _handleRadioValueChanged,
          ),
        ),
      ],
    );
  }
}
