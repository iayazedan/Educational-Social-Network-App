import 'package:flutter/material.dart';
import './passwordSetting.dart' as password;
import './profieSetting.dart' as profile;

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}
class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {Navigator.pop(context);},
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            title: Text(
              "Setting",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            bottom: TabBar(indicatorColor: Colors.blueAccent, tabs: [
              Tab(
                child: Text(
                  "Profile Picture",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Password",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              profile.profileSetting(),
              password.passwordSetting(),
            ],
          ),
      ),
    );
  }
}
