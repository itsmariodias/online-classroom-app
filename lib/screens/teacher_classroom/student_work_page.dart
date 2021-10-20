import 'package:flutter/material.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/widgets/profile_tile.dart';
import 'package:online_classroom/data/submissions.dart';
import 'package:online_classroom/screens/teacher_classroom/submission_page.dart';

class StudentWorkPage extends StatefulWidget {
  Account student;
  ClassRooms classRoom;

  StudentWorkPage({required this.student, required this.classRoom});

  @override
  _StudentWorkPageState createState() => _StudentWorkPageState();
}

class _StudentWorkPageState extends State<StudentWorkPage> {

  @override
  Widget build(BuildContext context) {
    List<Submission> assignedWork = submissionList.where((i) => i.user == widget.student && i.classroom == widget.classRoom && !i.submitted).toList();
    List<Submission> submittedWork = submissionList.where((i) => i.user == widget.student && i.classroom == widget.classRoom && i.submitted).toList();

    return Scaffold(
        body: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
                child: Text(
                  "Student Classwork",
                  style: TextStyle(
                      fontSize: 30, color: widget.classRoom.uiColor, letterSpacing: 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width - 30,
                height: 2,
                color: widget.classRoom.uiColor,
              ),
              Profile(
                user: widget.student,
              ),
              if (submittedWork.length > 0) Container(
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
                child: Text(
                  "Submitted",
                  style: TextStyle(
                      fontSize: 20,
                      color: widget.classRoom.uiColor,
                      letterSpacing: 1),
                ),
              ),
              if (submittedWork.length > 0) Container(
                margin: EdgeInsets.only(left: 15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 30,
                height: 2,
                color: widget.classRoom.uiColor,
              ),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: submittedWork.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SubmissionPage(
                                    submission:  submittedWork[index]
                                ))),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: widget.classRoom.uiColor),
                                      child: Icon(
                                        Icons.assignment,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          submittedWork[index].assignment.title,
                                          style: TextStyle(letterSpacing: 1),
                                        ),
                                        Text(
                                          "Submitted on" + submittedWork[index].dateTime,
                                          style: TextStyle(color: Colors.grey),
                                        ),],)
                                  ],),
                              ),
                            ));
                      })
              ),
              if (assignedWork.length > 0) Container(
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
                child: Text(
                  "Pending",
                  style: TextStyle(
                      fontSize: 20,
                      color: widget.classRoom.uiColor,
                      letterSpacing: 1),
                ),
              ),
              if (assignedWork.length > 0) Container(
                margin: EdgeInsets.only(left: 15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 30,
                height: 2,
                color: widget.classRoom.uiColor,
              ),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: assignedWork.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: widget.classRoom.uiColor),
                                  child: Icon(
                                    Icons.assignment,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      assignedWork[index].assignment.title,
                                      style: TextStyle(letterSpacing: 1),
                                    ),
                                  ])
                              ],),
                          ),
                        );
                      })
              )
            ]
        )
    );
  }
}
