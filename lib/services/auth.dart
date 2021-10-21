import 'package:online_classroom/data/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Converts Firebase user to Custom User
  CustomUser? _convertUser(User? user) {
    if (user == null) {
      return null;
    }
    
    else {
      return CustomUser(uid: user.uid, email: user.email);
    }
  }

  // Setting up stream
  // this continuously listens to auth changes (that is login or log out)
  // this will return the user if logged in or return null if not
  Stream<CustomUser?> get streamUser {
    return _auth.authStateChanges().map((User? user) => _convertUser(user));
  }


  // Sign out part
  Future signOut() async {
    await _auth.signOut();
  }

  // Register part with email and password
  Future registerStudent(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _convertUser(user);
    }
    
    catch (e) {
      print("Error in registering");
      return null;
    }
  }

  // Login part with email and password
  Future loginStudent(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _convertUser(user);
    }
    
    catch (e) {
      print("Error in login");
      return null;
    }
  }
}
