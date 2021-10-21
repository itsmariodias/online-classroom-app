// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:online_classroom/screens/Authenticate/userform.dart';
import 'package:online_classroom/screens/loading.dart';
import 'package:online_classroom/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:online_classroom/services/updatealldata.dart';

class Register extends StatefulWidget {
  final Function toggle_reg_log;
  Register({required this.toggle_reg_log});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Authservice object for accessing all auth related functions
  // More details inside "services/auth.dart" file
  final AuthService _auth = AuthService();

  // email and password strings
  String email = '';
  String password = '';
  String error = '';

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // for loading screen
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        // appbar part
        appBar: AppBar(
          title: Text("Register",
            style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          actions: [
            // login button on the top right corner of appbar
            TextButton.icon(
              onPressed: () {
                widget.toggle_reg_log();
              },
              icon: Icon(Icons.person),
              label: Text('Login'),
              style: TextButton.styleFrom(primary: Colors.black),
            )
          ],
        ),

        // body part
        body: Container(

          // form widget
          child: Form(

              // form key for validation( check above)
              key: _formKey,
              child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),

                    // textbox for email
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),

                    // textbox for password
                    TextFormField(
                      decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),

                    // register button
                    ElevatedButton(
                      child: Text("Register",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Roboto",
                              fontSize: 22)
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          setState(() => loading = true);

                          // Registering new student
                          var result = await _auth.registerStudent(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Some error in Registering! Please check again';
                            });
                          }

                          else {
                            await updateAllData();

                            setState(() => loading = false);
                            Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => Userform()));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(150, 50),
                      ),
                    ),

                    SizedBox(height: 12.0),

                    // Prints error if any while registering
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ))),
        ));
  }
}
