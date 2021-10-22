
import 'package:online_classroom/services/attachments_db.dart';
import 'package:flutter/material.dart';


class Attachment {
  String name;
  String url;
  String type;

  Attachment({required this.name, required this.url, required this.type});
}


class AttachmentAnnouncement{
  String title;
  String url;

  AttachmentAnnouncement({required this.title , required this.url});
}

class AttachmentStudents{
  String uid;
  String url;
  String submission;

  AttachmentStudents({required this.uid , required this.submission , required this.url});
}

List attachmentList = [];
List attachAnnounceList = [];
List attachmentStudentsList = [];


// updates the attachmentList with DB values
Future<bool> getAttachmentList() async {
  attachmentList = [];

  // TODO
  List? jsonList = await AttachmentsDB().createAttachmentsDataList();
  if (jsonList == null) return false;

  jsonList.forEach((element) {
    
    var data = element.data();
    attachmentList.add(
      Attachment(
        name: data["name"],
        url: data["url"],
        type: data["type"],
      )
    );
  });

  print("\t\t\t\tGot Attachments list");
  // print(attachmentList);
  return true;
  
}

// updates the attach - accounce with DB values
Future<bool> getAttachAnnounceList() async {
  attachAnnounceList = [];

  List? jsonList = await AttachmentsDB().createAttachAnnounceList();
  if (jsonList == null) return false;

  jsonList.forEach((element) {
    
    var data = element.data();
    attachAnnounceList.add(
      AttachmentAnnouncement(title: data["title"], url: data["url"],)
    );
  });

  print("\t\t\t\tGot Attachments -- Announce list");
  // print(attachAnnounceList);
  return true;
}


// updates the attach - student with DB values
Future<bool> getAttachmentStudentsList() async {
  attachmentStudentsList = [];

  List? jsonList = await AttachmentsDB().createAttachmentStudentsList();
  if (jsonList == null) return false;

  jsonList.forEach((element) {
    var data = element.data();
    attachmentStudentsList.add(
      AttachmentStudents(uid: data["uid"], url: data["url"], submission: data["submission"],)
    );
  });

  print("\t\t\t\tGot Attachments -- student list");
  // print(attachmentStudentsList);
  return true;
}


// finding a Attachment using url
Attachment? getAttachment(url) {
  var data = attachmentList.firstWhere((element) => element.url == url, orElse: () => null);

  return data;
}

// makes list of Attachment only for a specific Announcement
List getAttachmentListForAnnouncement(title) {
  List list1 = attachAnnounceList.where((element) => element.title == title).toList();
  List required = [];
  list1.forEach((element) {
    required.add(getAttachment(element.url)!);
  });
  return required;
}


// makes list of Attachment only for a specific Student
List getAttachmentListForStudent(uid, classname, submission) {
  List list1 = attachmentStudentsList.where((element) => element.uid == uid && element.submission == classname+"__"+submission).toList();
  List required = [];
  list1.forEach((element) {
    required.add(getAttachment(element.url)!);
  });
  return required;
}

// Attachment sampleAttachment = Attachment(
//     name: "sample.pdf",
//     url:"http://www.pdf995.com/samples/pdf.pdf",
//     type: "application/pdf",
//     icon: Icons.picture_as_pdf,
//     color: Colors.red
// );