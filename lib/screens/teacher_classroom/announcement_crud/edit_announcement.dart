import 'package:flutter/material.dart';
import 'package:online_classroom/data/announcements.dart';
import 'package:online_classroom/data/custom_user.dart';
import 'package:online_classroom/data/submissions.dart';
import 'package:online_classroom/data/attachments.dart';
import 'package:online_classroom/services/announcements_db.dart';
import 'package:online_classroom/services/submissions_db.dart';
import 'package:online_classroom/services/updatealldata.dart';
import 'package:online_classroom/utils/datetime.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditAnnouncement extends StatefulWidget {
  Announcement announcement;

  EditAnnouncement({required this.announcement});

  @override
  _EditAnnouncementState createState() => _EditAnnouncementState();
}

class _EditAnnouncementState extends State<EditAnnouncement> {
  String title = '';
  String description = '';
  String dateTime = todayDate();
  String dueDate = todayDate();
  List attachments = [];
  bool firstTime = true;

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // build func
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    if(firstTime) {
      title = widget.announcement.title;
      description = widget.announcement.description;
      dueDate = widget.announcement.dueDate;
      attachments = widget.announcement.attachments;
      firstTime = false;
    }
    DateTime defaultDate = new DateFormat('h:mm a EEE, MMM d, yyyy').parse(
        widget.announcement.dueDate);

    return Scaffold(
      // appbar part
        appBar: AppBar(
          backgroundColor: widget.announcement.classroom.uiColor,
          elevation: 0.5,
          title: Text(
            "Edit " + widget.announcement.type,
            style: TextStyle(
                color: Colors.white, fontFamily: "Roboto", fontSize: 22),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {},
            )
          ],
        ),

        // body part
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0),

                  TextFormField(
                    initialValue: title,
                    decoration: InputDecoration(labelText: "Title", border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? 'Enter a title' : null,
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),

                  if(widget.announcement.type == 'Assignment') SizedBox(height: 20.0),

                  if(widget.announcement.type == 'Assignment') DateTimeField(
                    decoration: InputDecoration(labelText: "Due Date", border: OutlineInputBorder()),
                    format: DateFormat('h:mm a EEE, MMM d, yyyy'),
                    initialValue: defaultDate,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime:
                          TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    onChanged: (date) => dueDate = formatDate(date),
                  ),

                  SizedBox(height: 20.0),

                  TextFormField(
                    initialValue: description,
                    decoration: InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                    maxLines: 5,
                    onChanged: (val) {
                      setState(() {
                        description = val;
                      });
                    },
                  ),

                  SizedBox(height: 20.0),

                  // Login  button
                  ElevatedButton(
                    child: Text("Update",
                        style: TextStyle(
                        color: Colors.white, fontFamily: "Roboto",
                            fontSize: 22)
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AnnouncementDB(user: user).updateAnnouncements(title, description, widget.announcement.classroom.className, dateTime, dueDate);

                        if(widget.announcement.type == 'Assignment') {
                          for (int index = 0; index <
                              submissionList.length; index++) {
                            if (submissionList[index].assignment ==
                                    widget.announcement) {
                              await SubmissionDB().updateSubmissions(
                                  widget.announcement.classroom.students[index].uid,
                                  widget.announcement.classroom.className,
                                  widget.announcement.classroom.className+"__"+title);
                            }
                          }
                        }
                        await updateAllData();
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: widget.announcement.classroom.uiColor,
                      minimumSize: Size(150, 50),
                    ),
                  )
                ],
              ))],
        ));
  }
}