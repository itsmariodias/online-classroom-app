// ignore_for_file: prefer_const_constructors

import 'package:classroom/data/accounts_data.dart';
import 'package:classroom/data/attachments.dart';
import 'package:classroom/data/classrooms.dart';
import 'package:classroom/data/custom_user.dart';
import 'package:classroom/services/accounts_db.dart';
import 'package:classroom/services/announcements_db.dart';
import 'package:classroom/services/attachments_db.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/services/classes_db.dart';
import 'package:classroom/services/submissions_db.dart';
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

                // // form
                //   TextFormField(
                //       decoration: InputDecoration(hintText: "className"),
                //       onChanged: (val) { className = val; }
                //     ),


                    ElevatedButton(
                      child: Text("Button"),
                      onPressed: () async {
                        
                        // await AttachmentsDB().createAttachmentsDB("America","www.america.com","jpg");
                        // await AttachmentsDB().createAttachAnnounceDB("Announce1","www.america.com");
                        // await AnnouncementDB(user: user).addAnnouncements("Announce2","Notice","Two","class one");
                        // await SubmissionDB().addSubmissions(user.uid, "class one", "class one__Announce1");
                        // await AttachmentsDB().createAttachmentStudentsDB(user.uid,"www.google.com","class one__Announce1");
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
            
            
                  // // form
                  // TextFormField(
                  //     decoration: InputDecoration(hintText: "className"),
                  //     onChanged: (val) { className = val; }
                  //   ),

                  //   TextFormField(
                  //     decoration: InputDecoration(hintText: "description"),
                  //     onChanged: (val) { description = val; }
                  //   ),

                    ElevatedButton(
                      child: Text("Button"),
                      onPressed: () async {
                        
                        // await AttachmentsDB().createAttachmentsDB("Attach2","www.india.com","ppt");
                        await updateAllData();
                      },


                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                    
                    ]
                  
            
            
              )),
            ));
  }
}