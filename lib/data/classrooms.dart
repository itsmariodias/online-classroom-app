import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_classroom/data/accounts.dart';

class ClassRooms {
  String className;
  String description;
  Account creator;
  Color uiColor;
  List<Account> students = [];

  ClassRooms(
      {required this.className,
      required this.description,
      required this.creator,
      required this.uiColor,
      required this.students});
}

List<ClassRooms> classRoomList = [
  ClassRooms(
      className: "MCC",
      description: "BE Computers",
      creator: accountList[3],
      uiColor: Colors.red,
      students: <Account>[accountList[0], accountList[1], accountList[2]]
  ),
  ClassRooms(
      className: "DSIP",
      description: "BE Computers",
      creator: accountList[5],
      uiColor: Colors.blue,
      students: <Account>[accountList[0], accountList[1], accountList[2]]
  ),
  ClassRooms(
      className: "AI&SC",
      description: "BE Computers",
      creator: accountList[4],
      uiColor: Colors.green,
      students: <Account>[accountList[0], accountList[1], accountList[2]]
  ),
  ClassRooms(
      className: "BDA",
      description: "BE Computers",
      creator: accountList[6],
      uiColor: Colors.purple,
      students: <Account>[accountList[0], accountList[1], accountList[2]]
  )
];
