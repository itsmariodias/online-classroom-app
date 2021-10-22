
import 'package:online_classroom/data/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_classroom/utils/datetime.dart';

class SubmissionDB {

  CollectionReference submissionReference = FirebaseFirestore.instance.collection("Submissions");

  // uid used to reference the student
  CustomUser? user;

  SubmissionDB({this.user});


  // function to update in class in database
  Future<void> addSubmissions(String uid, String classroom, String assignment) async {
    return await submissionReference.doc(uid+"_"+classroom+"_"+assignment).set({
      'uid': uid,
      'classroom' : classroom,
      'assignment' : assignment,
      'dateTime': todayDate(),
      'submitted': false,     
    });
  }

  Future<void> updateSubmissions(String uid, String classroom, String assignment, bool submission) async {
    return await submissionReference.doc(uid+"_"+classroom+"_"+assignment).update({
      'uid': uid,
      'classroom' : classroom,
      'assignment' : assignment,
      'dateTime': todayDate(),
      'submitted': submission,
    });
  }

  Future<void> deleteSubmissions(String uid, String classroom, String assignment) async {
    return await submissionReference.doc(uid+"_"+classroom+"_"+assignment).delete();
  }


  // function to make list of announcements from DB
  Future<List?> createSubmissionListDB() async {
    return await submissionReference.get().then(  (ss) => ss.docs.toList()  );
  }



}