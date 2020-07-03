import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unisocial/Students/DrawerScreens/StudentDrawer.dart';
import 'package:unisocial/ClassUsedInProject/NotificationDesign/NotificationsDesign.dart';
import 'package:unisocial/Students/ThreeMainScreen/StudentPostYear.dart';
import 'package:unisocial/Students/ThreeMainScreen/StudentPostSection.dart';
import './../ClassUsedInProject/shaw_post_class/other_functions.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}
class _StudentState extends State<Student> with SingleTickerProviderStateMixin {
  TabController tabController;
  String myYear="First Year";




  @override
  void initState() {
    readData();
    tabController = TabController(length: 3, vsync: this);
    Timer(Duration(seconds: 3), setYear);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }
  void setYear(){
    setState(() {
      //myYear=getYear(x);
    });
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
          myYear,
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
      drawer: drawerstudent(),
      //write post
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black12,
        onPressed: () {
          Navigator.of(context).pushNamed('/writepost');
        },
        child: Icon(Icons.create),
      ),
      //body
      body: Container(
        child: TabBarView(
          physics: new NeverScrollableScrollPhysics(),
          controller: tabController,
          children: <Widget>[

            StudentPostYear(),

            StudentPostSection(),

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
