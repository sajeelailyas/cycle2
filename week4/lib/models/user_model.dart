class User {
  final int id;
  final String name;
  final String email;
  final String avatar;

  User({required this.id, required this.name, required this.email, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: 'https://picsum.photos/200?random=${json['id']}',
    );
  }
}
