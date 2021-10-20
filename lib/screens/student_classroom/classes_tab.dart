import 'package:flutter/material.dart';
import 'package:online_classroom/data/classrooms.dart';

import 'package:online_classroom/screens/student_classroom/class_room_page.dart';

class ClassesTab extends StatefulWidget {

  @override
  _ClassesTabState createState() => _ClassesTabState();
}

class _ClassesTabState extends State<ClassesTab> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: classRoomList.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ClassRoomPage(
                  uiColor: classRoomList[index].uiColor,
                  classRoom: classRoomList[index],
                ))),
            child: Stack(
              children: [
                Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   fit: BoxFit.cover, image: classRoomList[index].bannerImg,),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: classRoomList[index].uiColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 30),
                  width: 220,
                  child: Text(
                    classRoomList[index].className,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 58, left: 30),
                  child: Text(
                    classRoomList[index].description,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 80, left: 30),
                  child: Text(
                    classRoomList[index].creator.firstName + " " + classRoomList[index].creator.lastName,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                        letterSpacing: 1),
                  ),
                )
              ],
            ),
          );
        });
  }
}
