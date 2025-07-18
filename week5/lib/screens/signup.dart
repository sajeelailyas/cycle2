import 'package:flutter/material.dart';
import 'package:week5/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool isLoading = false;

  void signupUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all fields")),
        );
        return;
      }

      // Firebase Auth - Signup
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Firestore - Save user info
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'uid': userCredential.user!.uid,
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup successful!")),
      );

      Navigator.pop(context); // Go back to login screen

    } on FirebaseAuthException catch (e) {
      String message = "Signup failed.";
      if (e.code == 'email-already-in-use') {
        message = "Email already in use.";
      } else if (e.code == 'weak-password') {
        message = "Password should be at least 6 characters.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print("Signup Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred.")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Name',
                controller: nameController,
              ),
              CustomTextField(
                hintText: 'Email',
                controller: emailController,
              ),
              CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                isPassword: true,
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: signupUser,
                      child: Text("Sign Up"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
