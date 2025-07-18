import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> signUp(String name, String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _db.collection('users').doc(cred.user!.uid).set({
        'name': name,
        'email': email,
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }
}
