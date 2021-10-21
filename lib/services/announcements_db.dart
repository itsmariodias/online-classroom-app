
import 'package:classroom/data/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementDB {

  CollectionReference announcementReference = FirebaseFirestore.instance.collection("Announcements");

  // uid used to reference the teacher/creator
  CustomUser? user;

  AnnouncementDB({this.user});


  // function to update in class in database
  Future<void> addAnnouncements(String title, String type, String description, String className ) async {
    return await announcementReference.doc(className+"__"+title).set({
      'title': title,
      'description' : description,
      'type' : type,
      'dateTime': DateTime.now().toString(),
      'className': className,      
      'uid': user!.uid,
    });
  }


  // function to make list of announcements from DB
  Future<List?> createAnnouncementListDB() async {
    return await announcementReference.get().then(  (ss) => ss.docs.toList()  );
  }



}