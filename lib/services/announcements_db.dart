
import 'package:online_classroom/data/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementDB {

  CollectionReference announcementReference = FirebaseFirestore.instance.collection("Announcements");

  // uid used to reference the teacher/creator
  CustomUser? user;

  AnnouncementDB({this.user});


  // function to update in class in database
  Future<void> addAnnouncements(String title, String type, String description, String className, String dateTime, String dueDate) async {
    return await announcementReference.doc(className+"__"+title).set({
      'title': title,
      'description' : description,
      'type' : type,
      'dateTime': dateTime,
      'dueDate': dueDate,
      'className': className,      
      'uid': user!.uid,
    });
  }

  Future<void> updateAnnouncements(String title, String description, String className, String dateTime, String dueDate) async {
    return await announcementReference.doc(className+"__"+title).update({
      'title': title,
      'description' : description,
      'dateTime': dateTime,
      'dueDate': dueDate,
      'className': className,
    });
  }

  Future<void> deleteAnnouncements(String title, String className) async {
    return await announcementReference.doc(className+"__"+title).delete();
  }


  // function to make list of announcements from DB
  Future<List?> createAnnouncementListDB() async {
    return await announcementReference.get().then(  (ss) => ss.docs.toList()  );
  }



}