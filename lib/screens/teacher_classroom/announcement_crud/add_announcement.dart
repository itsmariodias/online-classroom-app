import 'package:flutter/material.dart';
import 'package:online_classroom/data/announcements.dart';
import 'package:online_classroom/data/custom_user.dart';
import 'package:online_classroom/data/submissions.dart';
import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/attachments.dart';
import 'package:online_classroom/services/announcements_db.dart';
import 'package:online_classroom/services/submissions_db.dart';
import 'package:online_classroom/services/updatealldata.dart';
import 'package:online_classroom/utils/datetime.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAnnouncement extends StatefulWidget {
  ClassRooms classRoom;

  AddAnnouncement({required this.classRoom});

  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {

  String title = '';
  String description = '';
  String type = 'Notice';
  String dateTime = todayDate();
  String dueDate = todayDate();
  List attachments = [];

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // build func
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);


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
                    onPressed: () async {
                      if (_formKey.currentState!.validate())  {

                        await AnnouncementDB(user: user).addAnnouncements(title, type, description, widget.classRoom.className, dateTime, dueDate);

                        if(type == 'Assignment') {
                          for (int index = 0; index < widget.classRoom.students.length; index++) {
                            await SubmissionDB().addSubmissions(widget.classRoom.students[index].uid, widget.classRoom.className, widget.classRoom.className+"__"+title);
                          }
                        }
                        await updateAllData();

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