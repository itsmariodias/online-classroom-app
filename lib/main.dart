// ignore_for_file: prefer_const_constructors

import 'package:classroom/data/custom_user.dart';
import 'package:classroom/screens/wrapper.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/services/updatealldata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await updateAllData();

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
      child: MaterialApp(home: Wrapper())
    
    
    );
  }
}
