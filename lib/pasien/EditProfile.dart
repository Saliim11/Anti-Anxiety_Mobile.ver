import 'package:flutter/material.dart';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _usernameFromFirestore = '';
  String _userEmail = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _tglLahirController = TextEditingController();
  TextEditingController _usiaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _kotaController = TextEditingController();
  TextEditingController _kontakController = TextEditingController();

  void _getProfileDataFromFirestore() async {
    setState(() {
      _userEmail = Auth().currentUser?.email ?? '';
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot snapshot = querySnapshot.docs.first;
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        setState(() {
          _usernameFromFirestore = data['nama'] ?? '';
          _nameController.text = _usernameFromFirestore;
          _emailController.text = _userEmail;
          _usernameController.text = data['username'] ?? '';
          _passwordController.text = ''; // Set password field to blank
          _tglLahirController.text = data['tglLahir'] ?? '';
          _usiaController.text = data['usia'] ?? '';
          _alamatController.text = data['alamat'] ?? '';
          _kotaController.text = data['kota'] ?? '';
          _kontakController.text = data['kontak'] ?? '';
        });
      }
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.updateEmail(newEmail);
      // If the email update is successful, update the user email in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'email': newEmail});
    } catch (e) {
      // Handle errors
      print('Error updating email: $e');
      throw Exception('Failed to update email');
    }
  }

  Future<void> _updateEmail(String newEmail) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.updateEmail(newEmail);
      // If the email update is successful, update the user email in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'email': newEmail});
    } catch (e) {
      // Handle errors
      print('Error updating email: $e');
      String errorMessage = 'Failed to update email';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Invalid email address';
            break;
          case 'email-already-in-use':
            errorMessage = 'Email address already in use';
            break;
          case 'requires-recent-login':
            errorMessage =
                'This action requires reauthentication. Please log out and log in again.';
            break;
          default:
            errorMessage = 'An error occurred while updating the email address';
            break;
        }
      }
      throw Exception(errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfileDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color.fromARGB(255, 1, 54, 90),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 50,
                      // backgroundImage: AssetImage('profile.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _usernameFromFirestore,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pasien',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _tglLahirController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _usiaController,
                  decoration: InputDecoration(
                    labelText: 'Usia',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _kotaController,
                  decoration: InputDecoration(
                    labelText: 'Kota',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _kontakController,
                  decoration: InputDecoration(
                    labelText: 'Kontak',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, //latar belakang
                          onPrimary: Colors.white, //warna teks
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final newName = _nameController.text.trim();
                          final newEmail = _emailController.text.trim();
                          final newPassword =
                              _passwordController.text.trim();
                          final newTglLahir =
                              _tglLahirController.text.trim();
                          final newUsia = _usiaController.text.trim();
                          final newAlamat = _alamatController.text.trim();
                          final newKota = _kotaController.text.trim();
                          final newKontak = _kontakController.text.trim();

                          // Validate the input
                          if (newName.isEmpty ||
                              newEmail.isEmpty ||
                              newTglLahir.isEmpty ||
                              newUsia.isEmpty ||
                              newAlamat.isEmpty ||
                              newKota.isEmpty ||
                              newKontak.isEmpty) {
                            // Show an error message if any field is empty
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please fill all fields.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }

                          try {
                            User user =
                                FirebaseAuth.instance.currentUser!;
                            // Update the email if it has changed
                            if (newEmail != _userEmail) {
                              await _updateEmail(newEmail);
                            }

                            // Update the profile data in Firestore
                            final updateData = {
                              'nama': newName,
                              'email': newEmail,
                              'tglLahir': newTglLahir,
                              'usia': newUsia,
                              'alamat': newAlamat,
                              'kota': newKota,
                              'kontak': newKontak,
                            };

                            if (newPassword.isNotEmpty) {
                              updateData['password'] = newPassword;
                            }

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .update(updateData);

                            // Show a success message and handle other UI updates
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Success'),
                                  content:
                                      Text('Profile updated successfully.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );

                            // Clear the TextFields
                            _nameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                            _tglLahirController.clear();
                            _usiaController.clear();
                            _alamatController.clear();
                            _kotaController.clear();
                            _kontakController.clear();

                            // Update the displayed username
                            setState(() {
                              _usernameFromFirestore = newName;
                            });
                          } catch (e) {
                            // Show an error message
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'Failed to update profile. Error: $e'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(
                              255, 1, 54, 90), // Background color
                          onPrimary: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
