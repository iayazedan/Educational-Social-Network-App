import 'package:flutter/material.dart';
import 'package:unisocial/Secretary/Drawer/SecretaryDrawer.dart';
import 'package:unisocial/Secretary/Actions/AddPoster.dart';
import 'MainScreens/PostersNotifications.dart';
import 'MainScreens/ShowAndAnswerQuestions.dart';
import '../ClassUsedInProject/NotificationDesign/NotificationsDesign.dart';

class Secretary extends StatefulWidget {
  @override
  _SecretaryState createState() => _SecretaryState();
}

class _SecretaryState extends State<Secretary>with SingleTickerProviderStateMixin{

  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
        ],
        title: new Text(
          "Secretary",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: 25.0,
          ),
          onTap: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      //Drawer
      drawer: SecretaryDrawer(),
      //write post
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black12,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>AddPoster()),
          );
        },
        child: Icon(Icons.create),
      ),
      //body
      body: Container(
        child: TabBarView(
          controller: tabController,
          children: <Widget>[

            PostersNotifications(),

            AnswerQuestions(),

            NotificationsPage(),
          ],
        ),
      ),
      //bottomNavigationBar for year&&section&&Notifications
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.lightBlueAccent,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 0.0000000001,
          labelColor: Colors.lightBlue,
          tabs: <Widget>[
            Icon(
              Icons.home,
              size: 26.0,
            ),
            Icon(
              Icons.low_priority,
              size: 26.0,
            ),
            Icon(
              Icons.notifications,
              size: 26.0,
            ),
          ],
        ),
      ),
    );
  }
}
