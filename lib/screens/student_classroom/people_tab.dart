import 'package:flutter/material.dart';
import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/widgets/profile_tile.dart';

class PeopleTab extends StatefulWidget {
  ClassRooms classRoom;
  Color uiColor;

  PeopleTab({required this.classRoom, required this.uiColor});

  @override
  _PeopleTabState createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
          child: Text(
            "Teachers",
            style: TextStyle(
                fontSize: 30, color: widget.uiColor, letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width - 30,
          height: 2,
          color: widget.uiColor,
        ),
        Profile(
          user: widget.classRoom.creator,
        ),
        SizedBox(width: 30),
        Container(
          padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
          child: Text(
            "Classmates",
            style: TextStyle(
                fontSize: 30, color: widget.uiColor, letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width - 30,
          height: 2,
          color: widget.uiColor,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: widget.classRoom.students.length,
                itemBuilder: (context, int index) {
                  return Profile(
                    user: widget.classRoom.students[index]
                  );
                }))
      ],
    );
  }
}
