import 'package:flutter/material.dart';
import 'package:online_classroom/data/announcements.dart';
import 'package:online_classroom/widgets/attachment_composer.dart';
import 'package:online_classroom/widgets/submit_composer.dart';

class AnnouncementPage extends StatefulWidget {
  Announcement announcement;

  AnnouncementPage({required this.announcement});

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 15, bottom: 10),
              child: Text(
                widget.announcement.title,
                style: TextStyle(
                    fontSize: 25, color: widget.announcement.classroom.uiColor, letterSpacing: 1),
              ),
            ),
            if(widget.announcement.type == 'Assignment') Container(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Due " + widget.announcement.dueDate,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width - 30,
              height: 2,
              color: widget.announcement.classroom.uiColor,
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage:
                              AssetImage("${widget.announcement.user.userDp}"),
                            ),
                            SizedBox(width: 10),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.announcement.user.firstName! + " " + widget.announcement.user.lastName!,
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    "Last updated " + widget.announcement.dateTime,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ]),
                          ],
                        )
                      ],
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 40,
                        margin:
                        EdgeInsets.only(top: 15),
                        child: Text(widget.announcement.description)
                    )
                  ],
                )
            ),
            SizedBox(width: 10),
            widget.announcement.attachments.isNotEmpty ? Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  "Attachments:",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black, letterSpacing: 1, fontWeight: FontWeight.bold),
                )
            ) : Container(),
            AttachmentComposer(widget.announcement.attachments),
            widget.announcement.type == "Assignment" ? SubmissionComposer(widget.announcement, widget.announcement.classroom.uiColor) : Container()
            //Attachments(widget.announcement.attachments)
          ]
      )
    );
  }
}
