import 'package:online_classroom/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Converts Firebase user to Custom User
  CustomUser? _convertUser(User? user) {
    if (user == null)
      return null;
    else {
      print("Firebase user");
      print(user);
      return CustomUser(
          uid: user.uid, name: user.displayName, email: user.email);
    }
  }

  // Setting up stream
  // this continuously listens to auth changes (that is login or log out)
  // this will return the user if logged in or return null if not
  Stream<CustomUser?> get streamUser {
    return _auth.authStateChanges().map((User? user) => _convertUser(user));
  }

  // sign in part (anonymous)
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _convertUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out part
  Future signOut() async {
    await _auth.signOut();
  }

  // Register part with email and password
  Future registerStudent(String email, String password, String name) async {
    try {
      print("Registering");

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) return null;

      print("Updating Display Name");
      // updating the user Display name
      await user.updateDisplayName(name);
      await user.reload();

      return _convertUser(_auth.currentUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login part with email and password
  Future loginStudent(String email, String password) async {
    try {
      print("Logging in");

      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _convertUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
