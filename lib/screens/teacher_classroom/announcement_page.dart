import 'package:flutter/material.dart';
import 'package:online_classroom/data/announcements.dart';
import 'package:online_classroom/widgets/profile_tile.dart';
import 'package:online_classroom/data/submissions.dart';
import 'package:online_classroom/widgets/attachment_composer.dart';
import 'package:online_classroom/screens/teacher_classroom/submission_page.dart';

class AnnouncementPage extends StatefulWidget {
  Announcement announcement;

  AnnouncementPage({required this.announcement});

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {

  List<Widget> buildSubmissions() {
    if(widget.announcement.type == 'Assignment') {
      List<Submission> submissionsAssigned = submissionList.where((i) => i.assignment == widget.announcement && !i.submitted).toList();
      List<Submission> submissionsDone = submissionList.where((i) => i.assignment == widget.announcement && i.submitted).toList();
      return [
        Container(
          padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
          child: Text(
            "Submitted",
            style: TextStyle(
                fontSize: 20,
                color: widget.announcement.classroom.uiColor,
                letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery
              .of(context)
              .size
              .width - 30,
          height: 2,
          color: widget.announcement.classroom.uiColor,
        ),
        Container(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: submissionsDone.length,
                itemBuilder: (context, int index) {
                  return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SubmissionPage(
                              submission:  submissionsDone[index]
                          ))),
                      child: Profile(
                          user: submissionsDone[index].user
                      ));
                })
        ),
        Container(
          padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
          child: Text(
            "Pending",
            style: TextStyle(
                fontSize: 20,
                color: widget.announcement.classroom.uiColor,
                letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery
              .of(context)
              .size
              .width - 30,
          height: 2,
          color: widget.announcement.classroom.uiColor,
        ),
        Container(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: submissionsAssigned.length,
                itemBuilder: (context, int index) {
                  return Profile(
                          user: submissionsAssigned[index].user
                      );
                })
        )
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 15, bottom: 10),
              child: Text(
                widget.announcement.title,
                style: TextStyle(
                    fontSize: 25, color: widget.announcement.classroom.uiColor, letterSpacing: 1),
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
                                    widget.announcement.user.firstName + " " + widget.announcement.user.lastName,
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    widget.announcement.dateTime,
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
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
                child: Text(
                  "Attachments:",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black, letterSpacing: 1, fontWeight: FontWeight.bold),
                )
            ) : Container(),
            AttachmentComposer(widget.announcement.attachments),
          ] + buildSubmissions()
      )
    );
  }
}
