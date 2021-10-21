


import 'package:classroom/data/accounts_data.dart';
import 'package:classroom/data/announcements.dart';
import 'package:classroom/data/attachments.dart';
import 'package:classroom/data/classrooms.dart';
import 'package:classroom/data/submissions.dart';

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