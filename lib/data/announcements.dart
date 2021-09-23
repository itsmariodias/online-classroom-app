import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/attachments.dart';

class Announcement {
  Account user;
  String dateTime;
  String title;
  String type;
  String description;
  ClassRooms classroom;
  bool active = true;
  List<Attachment> attachments;

  Announcement({required this.user, required this.dateTime, required this.type, required this.title, required this.description, required this.classroom, required this.attachments});
}


List<Announcement> announcementList = [
  Announcement(
      user: classRoomList[0].creator,
      dateTime: "Aug 28, 9:00 PM",
      type: "Notice",
      title: "Please submit Assignment 2",
      description: "",
      classroom: classRoomList[0],
      attachments: []
  ),
  Announcement(
      user: classRoomList[1].creator,
      dateTime: "Aug 27, 9:00 PM",
      type: "Notice",
      title: "Not taking lecture today.",
      description: "",
      classroom: classRoomList[1],
      attachments: []
  ),
  Announcement(
      user: classRoomList[2].creator,
      dateTime: "Aug 27, 9:00 PM",
      type: "Notice",
      title: "Mini project submission extended till 31st August",
      description: "",
      classroom: classRoomList[2],
      attachments: []
  ),
  Announcement(
      user: classRoomList[3].creator,
      dateTime: "Aug 28, 9:00 PM",
      type: "Notice",
      title: "UT 1 Marks",
      description: "",
      classroom: classRoomList[3],
      attachments: [sampleAttachment]
  ),
  Announcement(
      user: classRoomList[0].creator,
      dateTime: "Aug 15, 9:00 PM",
      type: "Notice",
      title: "Practical lab link",
      description: "",
      classroom: classRoomList[0],
      attachments: []
  ),
  Announcement(
      user: classRoomList[1].creator,
      dateTime: "Aug 11, 9:00 PM",
      type: "Notice",
      title: "UT 1 Question Bank",
      description: "",
      classroom: classRoomList[1],
      attachments: [sampleAttachment, sampleAttachment]
  ),
  Announcement(
      user: classRoomList[2].creator,
      dateTime: "Aug 28, 9:00 PM",
      type: "Notice",
      title: "Meeting Link for batch A",
      description: "",
      classroom: classRoomList[2],
      attachments: []
  ),
  Announcement(
      user: classRoomList[3].creator,
      dateTime: "Aug 27, 9:00 PM",
      type: "Notice",
      title: "Lecture Recordings",
      description: "",
      classroom: classRoomList[3],
      attachments: []
  ),
  Announcement(
      user: classRoomList[0].creator,
      title: "Assignment 1",
      type: "Assignment",
      dateTime: "Aug 25, 9:00 PM",
      description: "",
      classroom: classRoomList[0],
      attachments: [sampleAttachment]
  ),
  Announcement(
      user: classRoomList[1].creator,
      title: "Practical 3",
      type: "Assignment",
      dateTime: "Aug 31, 9:30 PM",
      description: "Submit along with rubric sheet",
      classroom: classRoomList[1],
      attachments: [sampleAttachment]
  ),
  Announcement(
      user: classRoomList[3].creator,
      title: "Assignment 3",
      type: "Assignment",
      dateTime: "Aug 19, 9:30 PM",
      description: "",
      classroom: classRoomList[3],
      attachments: [sampleAttachment]
  ),
  Announcement(
      user: classRoomList[3].creator,
      title: "Practical 2",
      type: "Assignment",
      dateTime: "Aug 25, 9:00 PM",
      description: "",
      classroom: classRoomList[3],
      attachments: [sampleAttachment]
  ),
  Announcement(
      user: classRoomList[2].creator,
      title: "Practical 1",
      type: "Assignment",
      dateTime: "Aug 31, 9:30 PM",
      description: "",
      classroom: classRoomList[2],
      attachments: [sampleAttachment]
  ),
  Announcement(
      user: classRoomList[0].creator,
      title: "Mini Project Submission",
      type: "Assignment",
      dateTime: "Aug 19, 9:30 PM",
      description: "",
      classroom: classRoomList[0],
      attachments: [sampleAttachment]
  )
];

List<Announcement> notificationList = List.from(announcementList);
