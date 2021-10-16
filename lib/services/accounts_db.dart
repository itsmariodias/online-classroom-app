import 'package:classroom/data/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountsDB {
  // object to get instance of Accounts table
  final CollectionReference account_reference =
      FirebaseFirestore.instance.collection("Accounts");

  // uid used to reference the auth user
  final CustomUser user;

  AccountsDB({required this.user});

  Future<void> updateAccounts(String fname, String lname, String type) async {
    return await account_reference.doc(user.uid).set({
      'firstname': fname,
      'lastname': lname,
      'type': type,
      'email': user.email,
    });
  }
}
