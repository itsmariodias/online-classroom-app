// ignore_for_file: prefer_const_constructors

import 'package:classroom/models/custom_user.dart';
import 'package:classroom/screens/Authenticate/authenticate.dart';
import 'package:classroom/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // getting user from the Stream Provider
    final user = Provider.of<CustomUser?>(context);

    print("\n\n\t\tProvider");
    print("\t\t$user");
    if (user != null) print("\t\t${user.name}");

    // logic for if logged in
    if (user != null) {
      return ClassRoom();
    }

    // user isnt logged in
    else {
      return Authenticate();
    }

    // for testing
    // return Authenticate();
  }
}
