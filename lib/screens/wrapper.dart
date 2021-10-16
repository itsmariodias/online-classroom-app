// ignore_for_file: prefer_const_constructors

import 'package:classroom/data/custom_user.dart';
import 'package:classroom/screens/Authenticate/authenticate.dart';
import 'package:classroom/screens/Authenticate/userform.dart';
import 'package:classroom/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    // logic for if logged in
    if (user != null) {
      return ClassRoom();
      // return Userform();
    }

    // user isnt logged in
    else {
      return Authenticate();
    }
  }
}
