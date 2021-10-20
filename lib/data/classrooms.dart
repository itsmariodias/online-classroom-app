

import 'package:classroom/data/accounts_data.dart';
import 'package:classroom/services/classes_db.dart';
import 'package:flutter/material.dart';

class ClassRooms {
  String className;
  String description;
  Accounts creator;
  Color uiColor;
  List students;

  ClassRooms(
      {required this.className,
      required this.description,
      required this.creator,
      required this.uiColor,
      required this.students});

}

class ClassStudent{
  String uid;
  String className;

  ClassStudent({required this.uid , required this.className});

}


List<ClassRooms> classRoomList = [];
List<ClassStudent> studentsList = [];



// updates the classRoomList with DB values
Future<bool> getListClasses() async {
  classRoomList = [];

  // TODO
  List? jsonList = await ClassesDB().createClassesDataList();
  if (jsonList == null) {
    return false;
  }

  jsonList.forEach((element) {
    
    var data = element.data();
    classRoomList.add(
      ClassRooms(
        className: data["className"],
        description: data["description"],
        creator: getAccount(data["creator"])!,
        uiColor: Colors.red,
        students: makeStudentsAccountList(data["className"]),
        )
    );
  });

  print("\t\t\t\tGot Classes list");
  print(classRoomList[0].students[1].uid);
  return true;
  
}


// updates the StudentsList with DB values
Future<bool> getStudentAndClasses() async {
  studentsList = [];

  // TODO
  List? jsonList = await ClassesDB().makeStudentsAccountList();
  if (jsonList == null) {
    return false;
  }

  jsonList.forEach((element) {
    
    var data = element.data();
    studentsList.add(
      ClassStudent(className: data["className"], uid: data["uid"])
    );
  });

  print("\t\t\t\tGot Class -- Student list");
  return true;
  
}

List makeStudentsAccountList(var cname) {
  List studentsInClass = studentsList.where((element) => element.className == cname).toList();
  List required = [];
  studentsInClass.forEach((element) {
    required.add(getAccount(element.uid));
  });
  return required;

}




// var a = ClassRooms(
//       className: "MCC",
//       description: "BE Computers",
//       creator: accountList[3],
//       uiColor: Colors.red,
//       students: <Accounts>[accountList[0], accountList[1], accountList[2]]
//   )