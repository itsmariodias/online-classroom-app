import 'package:flutter/material.dart';
import 'package:online_classroom/data/submissions.dart';
import 'package:online_classroom/widgets/attachment_composer.dart';

class SubmissionPage extends StatefulWidget {
  Submission submission;

  SubmissionPage({required this.submission});

  @override
  _SubmissionPageState createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {

  @override
  Widget build(BuildContext context) {

    print(widget.submission.attachments);

    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 50, left: 15, bottom: 10),
                child: Text(
                  widget.submission.assignment.title + " - Submitted",
                  style: TextStyle(
                      fontSize: 25, color: widget.submission.assignment.classroom.uiColor, letterSpacing: 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width - 30,
                height: 2,
                color: widget.submission.assignment.classroom.uiColor,
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
                                AssetImage("${widget.submission.user.userDp}"),
                              ),
                              SizedBox(width: 10),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.submission.user.firstName! + " " + widget.submission.user.lastName!,
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      widget.submission.dateTime,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ]),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
              ),
              SizedBox(width: 10),
              widget.submission.attachments.isNotEmpty ? Padding(
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: Text(
                    "Attachments:",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black, letterSpacing: 1, fontWeight: FontWeight.bold),
                  )
              ) : Container(),
              AttachmentComposer(widget.submission.attachments)
            ]
        )
    );
  }
}
