import 'package:flutter/material.dart';
import 'package:online_classroom/screens/teacher_classroom/classes_tab.dart';
import 'package:online_classroom/services/auth.dart';
import 'package:online_classroom/models/custom_user.dart';
import 'package:provider/provider.dart';

class TeacherHomePage extends StatefulWidget {
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          "Your Classes",
          style: TextStyle(
              color: Colors.black, fontFamily: "Roboto", fontSize: 22),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: const EdgeInsets.only(top:10, bottom: 10),
              child: CircleAvatar(
                backgroundImage:
                AssetImage("Assets/Images/Dp/default.png"),
              )),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black87,
              size: 30,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: ClassesTab(user!.name)
    );
  }
}
