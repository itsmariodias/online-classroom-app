// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:classroom/services/auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function toggle_reg_log;
  Login({required this.toggle_reg_log});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Authservice object for logging in
  // More details inside "services/auth.dart" file
  final AuthService _auth = AuthService();

  // email and password strings
  String email = '';
  String password = '';
  String error = '';

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // build func
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appbar part
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.deepOrange[400],
          actions: [
            TextButton.icon(
              onPressed: () {
                widget.toggle_reg_log();
              },
              icon: Icon(Icons.person),
              label: Text('Register'),
              style: TextButton.styleFrom(primary: Colors.white),
            )
          ],
        ),

        // body part
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
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

                  // Login  button
                  ElevatedButton(
                    child: Text("Login"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Logging into the account
                        var result = await _auth.loginStudent(email, password);
                        if (result == null) {
                          setState(() {
                            error =
                                'Some error in logging in! Please check again';
                          });
                        } else
                          print("\t\t\tUser Logged in Successfully");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange[400],
                    ),
                  ),

                  SizedBox(height: 12.0),

                  // Prints error if any while logging in
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              )),
        ));
  }
}
