
import 'package:classroom/data/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassesDB {

  CollectionReference classReference = FirebaseFirestore.instance.collection("Classes");
  CollectionReference studentReference = FirebaseFirestore.instance.collection("Students");

  // uid used to reference the teacher/creator
  CustomUser? user;

  ClassesDB({this.user});


  // function to update in class in database
  Future<void> updateClasses(String className, String description) async {
    return await classReference.doc(className).set({
      'className': className,
      'description': description,
      'creator': user!.uid,
    });
  }

  // function to add student to class
  Future<void> updateStudentClasses(String className) async {
    return await studentReference.doc().set({
      'className' : className,
      'uid' : user!.uid
    });
  }

  // function to make list of accounts from DB
  Future<List?> createClassesDataList() async {
    return await classReference.get().then(  (ss) => ss.docs.toList()  );
  }

  // function to get list of students from DB
  Future<List?> makeStudentsAccountList() async {
    return await studentReference.get().then(  (ss) => ss.docs.toList()  );
  }


}