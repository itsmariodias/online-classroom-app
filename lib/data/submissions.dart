import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/attachments.dart';
import 'package:online_classroom/data/announcements.dart';

class Submission {
  Account user;
  String dateTime;
  ClassRooms classroom;
  Announcement assignment;
  bool submitted = false;
  List<Attachment> attachments;

  Submission({required this.user, this.dateTime = "", required this.classroom, required this.assignment, required this.attachments, this.submitted = false});
}

List<Submission> submissionList = [
  Submission(
    user: accountList[0],
    dateTime: 'Aug 25, 8:40 PM',
    classroom: classRoomList[0],
    assignment: announcementList[8],
    attachments: [sampleAttachment],
    submitted: true
  ),
  Submission(
      user: accountList[1],
      classroom: classRoomList[0],
      assignment: announcementList[8],
      attachments: [sampleAttachment],
  ),
];