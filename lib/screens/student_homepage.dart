import 'package:flutter/material.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/screens/student_classroom/add_class.dart';
import 'package:online_classroom/screens/student_classroom/wall_tab.dart';
import 'package:online_classroom/screens/student_classroom/classes_tab.dart';
import 'package:online_classroom/screens/student_classroom/timeline_tab.dart';
import 'package:online_classroom/services/auth.dart';
import 'package:online_classroom/data/custom_user.dart';
import 'package:online_classroom/services/classes_db.dart';
import 'package:online_classroom/services/updatealldata.dart';
import 'package:provider/provider.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    final tabs = [
      WallTab(),
      TimelineTab(),
      ClassesTab()
    ];

    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            "Online Classroom",
            style: TextStyle(
                color: Colors.black, fontFamily: "Roboto", fontSize: 22),
          ),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("Welcome, " + (account!.firstName as String),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black87,
                size: 30,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'ClassWork',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Classes",
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddClass(),
              )).then((_) => setState(() {}));
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
