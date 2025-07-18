import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = AuthService();
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final data = await auth.getUserData();
    setState(() {
      name = data?['name'];
      email = data?['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          )
        ],
      ),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)),
                  SizedBox(height: 20),
                  Text("Name: $name", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text("Email: $email", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
    );
  }
}
