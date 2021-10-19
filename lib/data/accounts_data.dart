// here the actual details of User (AccountDB) is stored

import 'package:classroom/services/accounts_db.dart';

class AccountsData {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? type;

  AccountsData({this.uid, this.firstname, this.lastname, this.email, this.type});
}

List accountList = [];


// getting the list
Future<bool> getListAccount() async {
  accountList = [];

  List? jsonList = await AccountsDB().createAccountDataList();
  jsonList!.forEach((element) {
    
    var data = element.data();
    
    accountList.add(AccountsData(
      uid: data["uid"],
      firstname: data["firstname"],
      lastname: data["lastname"],
      email: data["email"],
      type: data["type"],
    ));
  });

  print("\t\t\t\tGot list");
  print(accountList);

  return true;
  
}

// returns true if teacher else false
AccountsData? getAccount(uid)
{


  var data = accountList.firstWhere((element) => element.uid == uid, orElse: () => null);

  if (data != null)
  {
    return data;
  }
  
  else
  {
    return null;
  }
}


// returns whether the account exists
bool accountExists(uid) {
  var data = accountList.firstWhere((element) => element.uid == uid, orElse: () => null);

  if (data!= null )
  {
    return true;
  }
  
  return false;
}