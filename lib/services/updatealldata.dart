


import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/announcements.dart';
import 'package:online_classroom/data/attachments.dart';
import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/data/submissions.dart';

Future<bool> updateAllData() async
{
  print("\t\t\t\t\tupdate Started");
  
  await getListAccount();
  await getStudentAndClasses();
  await getListClasses();
  await getAttachmentList();
  await getAttachAnnounceList();
  await getAnnouncementList();
  await getAttachmentStudentsList();
  await getsubmissionList();


  print("\t\t\t\t\tUpdate Finished");
  return true;

}


// Create a new attachment
// await AttachmentsDB().createAttachmentsDB(String name, String url, String type);

// Connect attachment and announcement
// await AttachmentsDB().createAttachAnnounceDB(String title, String url);

// create a new announcement
// await AnnouncementDB(user: user).addAnnouncements(String title, String type, String description, String className);

// create a new submission
// await SubmissionDB().addSubmissions(String uid, String classroom, String assignment);

// Connect attachments - students - announcement
// await AttachmentsDB().createAttachmentStudentsDB(String uid, String url, String announcement);


// Create a new account
// AccountsDB(user: user).updateAccounts(String fname, String lname, String type)

// Creates a new classroom
// ClassesDB(user: user).updateClasses(String className, String description)


// Adds student to a class
// ClassesDB(user: user).updateStudentClasses(String className)