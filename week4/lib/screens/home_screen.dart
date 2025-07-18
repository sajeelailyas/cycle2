import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    _users = ApiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UserProfileScreen(user: user)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
