import 'package:online_classroom/screens/Authenticate/login.dart';
import 'package:online_classroom/screens/Authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showRegister = false;
  void toggle_reg_log() {
    setState(() => showRegister = !showRegister);
  }

  @override
  Widget build(BuildContext context) {
    if (showRegister)
      return Register(toggle_reg_log: toggle_reg_log);
    else
      return Login(toggle_reg_log: toggle_reg_log);
  }
}
