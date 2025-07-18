import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  UserProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.avatar)),
            SizedBox(height: 16),
            Text(user.name, style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text(user.email, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
