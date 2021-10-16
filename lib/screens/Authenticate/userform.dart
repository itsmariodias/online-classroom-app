// ignore_for_file: prefer_const_constructors

import 'package:classroom/data/custom_user.dart';
import 'package:classroom/services/accounts_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Userform extends StatefulWidget {
  const Userform({Key? key}) : super(key: key);

  @override
  _UserformState createState() => _UserformState();
}

class _UserformState extends State<Userform> {
  String firstname = "";
  String lastname = "";
  String type = "";
  String error = "";

  // for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final AccountsDB pointer = AccountsDB(user: user!);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "User Details",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
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

                    // textbox for name
                    TextFormField(
                      decoration: InputDecoration(hintText: "First Name"),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an First Name' : null,
                      onChanged: (val) {
                        setState(() {
                          firstname = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),

                    // textbox for name
                    TextFormField(
                      decoration: InputDecoration(hintText: "Last Name"),
                      onChanged: (val) {
                        setState(() {
                          lastname = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration:
                          InputDecoration(hintText: "student / teacher"),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a valid type' : null,
                      onChanged: (val) {
                        setState(() {
                          type = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),

                    // register button
                    ElevatedButton(
                      child: Text("Update"),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // adding to db
                          await pointer.updateAccounts(
                              firstname, lastname, type);

                          // popping to Wrapper to go to class
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
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
