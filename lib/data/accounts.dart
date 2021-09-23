
class Account {
  String firstName;
  String lastName;
  String type;
  String email;
  String password;
  String userDp;

  Account({required this.firstName, required this.lastName, required this.type, required this.email, required this.password, required this.userDp});
}

List<Account> accountList = [
  Account(
      firstName: 'Mario',
      lastName: 'Dias',
      type: 'Student',
      email: 'mario@gmail.com',
      password: 'mario123',
      userDp: "Assets/Images/Dp/default.png"
  ),
  Account(
      firstName: 'Nijo',
      lastName: 'Ninan',
      type: 'Student',
      email: 'nijo@gmail.com',
      password: 'nijo123',
      userDp: "Assets/Images/Dp/default.png",
  ),
  Account(
      firstName: 'Hansie',
      lastName: 'Aloj',
      type: 'Student',
      email: 'hansie@gmail.com',
      password: 'hansie123',
      userDp: "Assets/Images/Dp/default.png"
  ),
  Account(
      firstName: 'Monali',
      lastName: 'Shetty',
      type: 'Teacher',
      email: 'monali@gmail.com',
      password: 'monali123',
      userDp: "Assets/Images/Dp/default.png"
  ),
  Account(
      firstName: 'Sunil',
      lastName: 'Surve',
      type: 'Teacher',
      email: 'sunil@gmail.com',
      password: 'sunil123',
      userDp: "Assets/Images/Dp/default.png"
  ),
  Account(
      firstName: 'Sushma',
      lastName: 'Nagdeote',
      type: 'Teacher',
      email: 'sushma@gmail.com',
      password: 'sushma123',
      userDp: "Assets/Images/Dp/default.png"
  ),
  Account(
      firstName: 'Swati',
      lastName: 'Ringe',
      type: 'Teacher',
      email: 'swati@gmail.com',
      password: 'swati123',
      userDp: "Assets/Images/Dp/default.png"
  ),
];