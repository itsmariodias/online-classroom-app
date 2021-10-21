

import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/services/classes_db.dart';
import 'package:flutter/material.dart';

class ClassRooms {
  String className;
  String description;
  Account creator;
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


List classRoomList = [];
List studentsList = [];



// updates the classRoomList with DB values
Future<bool> getListClasses() async {
  classRoomList = [];

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
        uiColor: Color(int.parse(data["uiColor"])),
        students: makeStudentsAccountList(data["className"]),
        )
    );
  });

  print("\t\t\t\tGot Classes list");
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

ClassRooms? getClassroom(cname) {
  var data = classRoomList.firstWhere((element) => element.className == cname, orElse: () => null);
  return data;
}



// var a = ClassRooms(
//       className: "MCC",
//       description: "BE Computers",
//       creator: accountList[3],
//       uiColor: Colors.red,
//       students: <Account>[accountList[0], accountList[1], accountList[2]]
//   )