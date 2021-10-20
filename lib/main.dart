import 'package:flutter/material.dart';
import 'package:online_classroom/screens/student_homepage.dart';

// ignore_for_file: prefer_const_constructors

import 'package:online_classroom/models/custom_user.dart';
import 'package:online_classroom/screens/wrapper.dart';
import 'package:online_classroom/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  // initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // running home Widget
  return runApp(Home());
}

// it just returns basic settings for MaterialApp
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Stream provider for constantly getting the user data
    return StreamProvider<CustomUser?>.value(

      // value is the stream method declared in "services.auth.dart"
        value: AuthService().streamUser,
        initialData: null,

        // MaterialApp
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Wrapper()));
  }
}

// void main() => runApp(OnlineClassroomApp());
//
// class OnlineClassroomApp extends StatefulWidget {
//   @override
//   _OnlineClassroomAppState createState() => _OnlineClassroomAppState();
// }
//
// class _OnlineClassroomAppState extends State<OnlineClassroomApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Classroom App",
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
