import 'package:flutter/material.dart';
import 'package:online_classroom/data/announcements.dart';
import 'package:online_classroom/data/submissions.dart';
import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/attachments.dart';
import 'package:online_classroom/utils/datetime.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddAnnouncement extends StatefulWidget {
  ClassRooms classRoom;

  AddAnnouncement({required this.classRoom});

  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  Account user = accountList[3];
  String title = '';
  String description = '';
  String type = 'Notice';
  String dateTime = todayDate();
  String dueDate = todayDate();
  List<Attachment> attachments = [];

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // build func
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar part
        appBar: AppBar(
          backgroundColor: widget.classRoom.uiColor,
          elevation: 0.5,
          title: Text(
            "Add Announcement",
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
                    decoration: InputDecoration(labelText: "Title", border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? 'Enter a title' : null,
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),

                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Type", border: OutlineInputBorder()),
                    value: type,
                    onChanged: (newValue) {
                      setState(() {
                        type = newValue as String;
                      });
                    },
                    items: ['Notice', 'Assignment'].map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),

                  if(type == 'Assignment') SizedBox(height: 20.0),

                  if(type == 'Assignment') DateTimeField(
                    decoration: InputDecoration(labelText: "Due Date", border: OutlineInputBorder()),
                    format: DateFormat('h:mm a EEE, MMM d, yyyy'),
                    initialValue: DateTime.now(),
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
                    child: Text("Add",
                        style: TextStyle(
                        color: Colors.white, fontFamily: "Roboto",
                            fontSize: 22)
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Announcement newAnnouncement = Announcement(
                            user: user,
                            dateTime: dateTime,
                            dueDate: dueDate,
                            type: type,
                            title: title,
                            description: description,
                            classroom: widget.classRoom,
                            attachments: attachments
                        );

                        announcementList.insert(0, newAnnouncement);
                        notificationList.insert(0, newAnnouncement);

                        if(type == 'Assignment') {
                          for (int index = 0; index < widget.classRoom.students.length; index++) {
                            submissionList.add(new Submission(
                                  user: widget.classRoom.students[index],
                                  classroom: widget.classRoom,
                                  assignment: newAnnouncement));
                          }
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: widget.classRoom.uiColor,
                      minimumSize: Size(150, 50),
                    ),
                  )
                ],
              ))],
        ));
  }
}