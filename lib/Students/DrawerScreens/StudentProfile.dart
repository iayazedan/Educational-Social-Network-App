import 'package:flutter/material.dart';
class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 600,
        color: Colors.black54,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: Container(
                alignment: Alignment.centerLeft,
                width: 200,
                height: 200,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/avatar.jpg"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: new Text(
                "Esn",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
              Padding(
              padding: EdgeInsets.all(20),
              child: Text("Third Year",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("CS",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Section 2",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
