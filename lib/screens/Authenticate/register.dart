// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:classroom/services/auth.dart';
import 'package:flutter/material.dart';

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
  String name = "";

  // for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appbar part
        appBar: AppBar(
          title: Text("Register"),
          backgroundColor: Colors.deepOrange[400],
          actions: [
            // login button on the top right corner of appbar
            TextButton.icon(
              onPressed: () {
                widget.toggle_reg_log();
              },
              icon: Icon(Icons.person),
              label: Text('Login'),
              style: TextButton.styleFrom(primary: Colors.white),
            )
          ],
        ),

        // body part
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

          // form widget
          child: Form(

              // form key for validation( check above)
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0),

                  // textbox for name
                  TextFormField(
                    decoration: InputDecoration(hintText: "Name"),
                    validator: (val) => val!.isEmpty ? 'Enter an Name' : null,
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),

                  SizedBox(height: 20.0),

                  // textbox for email
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
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
                    decoration: InputDecoration(hintText: "Password"),
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
                    child: Text("Register"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Registering new student
                        var result =
                            await _auth.registerStudent(email, password, name);
                        if (result == null) {
                          setState(() {
                            error =
                                'Some error in Registering! Please check again';
                          });
                        } else
                          print("\t\t\tNew User Registered");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange[400],
                    ),
                  ),

                  SizedBox(height: 12.0),

                  // Prints error if any while registering
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              )),
        ));
  }
}
