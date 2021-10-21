//
// class Account {
//   String firstName;
//   String lastName;
//   String type;
//   String email;
//   String password;
//   String userDp;
//
//   Account({required this.firstName, required this.lastName, required this.type, required this.email, required this.password, required this.userDp});
// }
//
// List<Account> accountList = [
//   Account(
//       firstName: 'Mario',
//       lastName: 'Dias',
//       type: 'Student',
//       email: 'mario@gmail.com',
//       password: 'mario123',
//       userDp: "Assets/Images/Dp/default.png"
//   ),
//   Account(
//       firstName: 'Nijo',
//       lastName: 'Ninan',
//       type: 'Student',
//       email: 'nijo@gmail.com',
//       password: 'nijo123',
//       userDp: "Assets/Images/Dp/default.png",
//   ),
//   Account(
//       firstName: 'Hansie',
//       lastName: 'Aloj',
//       type: 'Student',
//       email: 'hansie@gmail.com',
//       password: 'hansie123',
//       userDp: "Assets/Images/Dp/default.png"
//   ),
//   Account(
//       firstName: 'Monali',
//       lastName: 'Shetty',
//       type: 'Teacher',
//       email: 'monali@gmail.com',
//       password: 'monali123',
//       userDp: "Assets/Images/Dp/default.png"
//   ),
//   Account(
//       firstName: 'Sunil',
//       lastName: 'Surve',
//       type: 'Teacher',
//       email: 'sunil@gmail.com',
//       password: 'sunil123',
//       userDp: "Assets/Images/Dp/default.png"
//   ),
//   Account(
//       firstName: 'Sushma',
//       lastName: 'Nagdeote',
//       type: 'Teacher',
//       email: 'sushma@gmail.com',
//       password: 'sushma123',
//       userDp: "Assets/Images/Dp/default.png"
//   ),
//   Account(
//       firstName: 'Swati',
//       lastName: 'Ringe',
//       type: 'Teacher',
//       email: 'swati@gmail.com',
//       password: 'swati123',
//       userDp: "Assets/Images/Dp/default.png"
//   ),
// ];

// here the actual details of User (AccountDB) is stored

import 'package:online_classroom/services/accounts_db.dart';

class Account {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? type;
  String userDp;

  Account({this.uid, this.firstName, this.lastName, this.email, this.type, this.userDp = ""});
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
      firstName: data["firstname"],
      lastName: data["lastname"],
      email: data["email"],
      type: data["type"],
      userDp: "Assets/Images/Dp/default.png"
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