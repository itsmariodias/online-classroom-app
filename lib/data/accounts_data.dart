// here the actual details of User (AccountDB) is stored

import 'package:classroom/services/accounts_db.dart';

class Account {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? type;

  Account({this.uid, this.firstname, this.lastname, this.email, this.type});
}

List accountList = [];


// getting the list
Future<bool> getListAccount() async {
  accountList = [];

  List? jsonList = await AccountsDB().createAccountDataList();
  jsonList!.forEach((element) {
    
    var data = element.data();
    
    accountList.add(Account(
      uid: data["uid"],
      firstname: data["firstname"],
      lastname: data["lastname"],
      email: data["email"],
      type: data["type"],
    ));
  });

  print("\t\t\t\tGot Account list");
  return true;
  
}

// returns whether the account exists
bool accountExists(uid) {
  var data = accountList.firstWhere((element) => element.uid == uid, orElse: () => null);
  return data!= null? true:false;
}


// returns the account of the user
Account? getAccount(uid) {
  var data = accountList.firstWhere((element) => element.uid == uid, orElse: () => null);
  return data;
}