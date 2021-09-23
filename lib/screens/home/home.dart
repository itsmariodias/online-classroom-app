// ignore_for_file: prefer_const_constructors

import 'package:online_classroom/models/custom_user.dart';
import 'package:online_classroom/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassRoom extends StatefulWidget {
  const ClassRoom({Key? key}) : super(key: key);

  @override
  ClassRoomState createState() => ClassRoomState();
}

class ClassRoomState extends State<ClassRoom> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Classroom"),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text("Logout"),
            ),
            SizedBox(height: 12.0),
            Text("Name : ${user!.name}"),
            Text("Email: ${user.email}"),
            Text("uid : ${user.uid}"),
          ],
        )));
  }
}
