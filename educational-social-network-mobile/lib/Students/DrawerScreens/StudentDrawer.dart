import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:untitled1/Students/StudentActions/SendComplaints.dart' as sendcomplaints;
//import '../../main.dart';
import './Ask.dart';
import './Posters.dart';

class drawerstudent extends StatefulWidget {
  @override
  _drawerstudentState createState() => _drawerstudentState();
}

class _drawerstudentState extends State<drawerstudent> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new DrawerHeader(
            //box images
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0))),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 85.0,
                      height: 85.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/avatar.jpg"),
                        ),
                      ),
                    ),
                    onTap: () =>
                        Navigator.of(context).pushNamed('/Profile'),
                  ),
                  new Text("Esn",
                      style: TextStyle(fontSize: 16.0, letterSpacing: 1.0)),
                  new Text(
                    "Esn@gmail.com",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
          ),

          //serveces of drawer
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Setting');
            },
            leading: new Icon(Icons.settings),
            title: Text("Settings", style: TextStyle(fontSize: 13.0)),
            subtitle: Text("informatoin about the title",
                style: TextStyle(fontSize: 11.0)),
          ),

          ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/sendcomplaints');
              },
              leading: new Icon(Icons.bookmark),
              title: Text("Send Complaint", style: TextStyle(fontSize: 13.0)),
              subtitle: Text("informatoin about the title",
                  style: TextStyle(fontSize: 11.0))),

          ListTile(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AskQuestion()),
                );
              },
              leading: new Icon(Icons.bookmark),
              title: Text("Ask Question", style: TextStyle(fontSize: 13.0)),
              subtitle: Text("informatoin about the title",
                  style: TextStyle(fontSize: 11.0))),

          ListTile(
              onTap: () {},
              leading: new Icon(Icons.help),
              title: Text("help", style: TextStyle(fontSize: 13.0)),
              subtitle: Text("informatoin about the title",
                  style: TextStyle(fontSize: 11.0))),

          ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/designsavepost');
              },
              leading: new Icon(Icons.bookmark),
              title: Text("Bookmark", style: TextStyle(fontSize: 13.0)),
              subtitle: Text("informatoin about the title",
                  style: TextStyle(fontSize: 11.0))),
          ListTile(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudentsPosters()),
                );
              },
              leading: new Icon(Icons.bookmark),
              title: Text("Posters Notifications", style: TextStyle(fontSize: 13.0)),
              subtitle: Text("informatoin about the title",
                  style: TextStyle(fontSize: 11.0))),

          ListTile(
            onTap: () {
              clearData();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/Login', (Route<dynamic> route) => false);
            },
            leading: new Icon(Icons.exit_to_app),
            title: Text("Sign Out", style: TextStyle(fontSize: 13.0)),
            subtitle: Text("informatoin about the title",
                style: TextStyle(fontSize: 11.0)),
          ),
        ],
      ),
    );
  }

  clearData() async {
    final savelogin = await SharedPreferences.getInstance();
    savelogin.setString("all", null);
  }
}
