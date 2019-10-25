import 'package:flutter/material.dart';
import './AnswerQuestionsPage.dart';
class Draw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          new DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  )),
              child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(right: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed('/Profile'),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 85.0,
                          height: 85.0,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("images/avatar.jpg"))),
                        ),
                      ),
                      new Text("Admin",
                          style: TextStyle(fontSize: 16.0, letterSpacing: 1.0)),
                      new Text(
                        "Admin@gmail.com",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ))),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Setting');
            },
            leading: new Icon(Icons.settings),
            title: Text("Settings", style: TextStyle(fontSize: 15.0)),
            subtitle: Text("Change Some Info",style: TextStyle(
              fontSize: 12.0,
            )),
          ),
          ListTile(
              onTap: () {},
              leading: new Icon(Icons.help),
              title: Text("help", style: TextStyle(fontSize: 15.0)),
              subtitle: Text("How App Work And Best Usage",style: TextStyle(
                fontSize: 12.0,
              ))),
          ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/complaints');
              },
              leading: new Icon(Icons.error),
              title: Text("Show Complaints", style: TextStyle(fontSize: 15.0)),
              subtitle: Text("Show Complaints Comes From Students",style: TextStyle(
                fontSize: 12.0,
              ))),
          ListTile(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AnswerQuestions()),
                );              },
              leading: new Icon(Icons.question_answer),
              title: Text("Answer Questions", style: TextStyle(fontSize: 15.0)),
              subtitle: Text("Answer Your Questions That Target You",style: TextStyle(
                fontSize: 12.0,
              ),)),
          ListTile(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/Login', (Route<dynamic> route) => false);
              },
              leading: new Icon(Icons.exit_to_app),
              title: Text("Sign Out", style: TextStyle(fontSize: 15.0)),
              subtitle: Text("Log Out From App",style: TextStyle(
                fontSize: 12.0,
              ))),
        ],
      ),
    );
  }
}
