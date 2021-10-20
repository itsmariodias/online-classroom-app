// ignore_for_file: prefer_const_constructors

import 'package:classroom/data/accounts_data.dart';
import 'package:classroom/data/custom_user.dart';
import 'package:classroom/services/accounts_db.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/services/classes_db.dart';
import 'package:classroom/services/updatealldata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    var account = getAccount(user!.uid);


    String className = "";
    
    
    return Scaffold(
            appBar: AppBar(
              title: Text("Student"),
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
                Text("First Name : ${account!.firstname}"),
                Text("Last Name : ${account.lastname}"),
                Text("Email: ${account.email}"),
                Text("uid : ${account.uid}"),
                Text("type : ${account.type}"),

                // form
                  TextFormField(
                      decoration: InputDecoration(hintText: "className"),
                      onChanged: (val) { className = val; }
                    ),


                    ElevatedButton(
                      child: Text("Add Class"),
                      onPressed: () async {
                        
                        await ClassesDB(user: user).updateStudentClasses(className);
                        await updateAllData();
                      },


                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),

              ],
            )));
  }
}


class TeacherRoom extends StatefulWidget {
  const TeacherRoom({ Key? key }) : super(key: key);

  @override
  _TeacherRoomState createState() => _TeacherRoomState();
}

class _TeacherRoomState extends State<TeacherRoom> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    String className = "";
    String description = "";

    
    return Scaffold(
            appBar: AppBar(
              title: Text("Teacher"),
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text("Logout"),
                  ),
                  SizedBox(height: 12.0),
                  Text("First Name : ${account!.firstname}"),
                  Text("Last Name : ${account.lastname}"),
                  Text("Email: ${account.email}"),
                  Text("uid : ${account.uid}"),
                  Text("type : ${account.type}"),
            
            
                  // form
                  TextFormField(
                      decoration: InputDecoration(hintText: "className"),
                      onChanged: (val) { className = val; }
                    ),

                    TextFormField(
                      decoration: InputDecoration(hintText: "description"),
                      onChanged: (val) { description = val; }
                    ),

                    ElevatedButton(
                      child: Text("Add Class"),
                      onPressed: () async {
                        
                        await ClassesDB(user: user).updateClasses(className, description);
                        await updateAllData();
                      },


                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                    
                    ]
                  
            
            
              )),
            ));
  }
}