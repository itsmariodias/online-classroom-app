import 'package:firebase_auth/firebase_auth.dart';

// just stores the required parts of the firebase User
class CustomUser {
  final String uid;
  final String? name;
  final String? email;

  CustomUser({required this.uid, required this.name, required this.email});
}
