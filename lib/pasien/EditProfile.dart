import 'package:flutter/material.dart';
import 'package:anti_anxiety/login_register_auth/auth.dart';
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
  TextEditingController _passwordController = TextEditingController();

  void _getUsernameFromFirestore() async {
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
    _getUsernameFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: Color.fromARGB(255, 1, 54, 90),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                            // Get the new name, email, and password from the TextFields
                            final newName = _nameController.text.trim();
                            final newEmail = _emailController.text.trim();
                            final newPassword = _passwordController.text.trim();
                            // print(n)

                            // Validate the input
                            if (newName.isEmpty ||
                                newEmail.isEmpty ||
                                newPassword.isEmpty) {
                              // Show an error message if any field is empty
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Please fill all fields.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            // Update the user profile data in Firestore
                            try {
                              QuerySnapshot qS = await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .where('email', isEqualTo: _userEmail)
                                  .get();

                              final documentReference = qS.docs.first.reference;

                              if (qS.docs.isEmpty) {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content:
                                          const Text('User data not found.'),
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

                              await documentReference.update({
                                'nama': newName,
                                'email': newEmail,
                                'password': newPassword,
                              });

                              final user = Auth().currentUser;

                              await _updateEmail(newEmail);
                              
                              // Show a success message
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Success'),
                                    content:
                                        Text('Profile updated successfully.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
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
                                        onPressed: () => Navigator.pop(context),
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
                            primary:
                                Color.fromARGB(255, 1, 54, 90), //latar belakang
                            onPrimary: Colors.white, //warna teks
                          ),
                        ),
                      ),
                    ],
                  ),
                ]))));
  }
}
