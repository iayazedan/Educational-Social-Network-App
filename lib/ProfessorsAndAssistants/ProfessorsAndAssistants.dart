import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:unisocial/ProfessorsAndAssistants/DrawerScreens/drawer.dart' as D;
import 'package:unisocial/ProfessorsAndAssistants/ThreeMainScreen/ProfessorsShowYear.dart';
import 'package:unisocial/ProfessorsAndAssistants/ThreeMainScreen/ProfessorsShowSection.dart';
import 'package:unisocial/ClassUsedInProject/NotificationDesign/NotificationsDesign.dart';
import 'package:http/http.dart' as http;

enum IndicatorType { overscroll, refresh }

class Admin extends StatefulWidget {
  int index;
  Admin({this.index});
  @override
  _AdminState createState() => _AdminState(index:this.index);
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {

  _AdminState({this.index});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int index;

  var tabController;
  bool isPending = false;



  @override
  void initState() {
    if(index!=null){
      tabController = TabController(length: 3, vsync: this,initialIndex: index);
    }else
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
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: 25.0,
          ),
          onTap: () => _scaffoldKey.currentState.openDrawer(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Admin Feeds",
          style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
      ),

      drawer: D.Draw(),

      //------------------------ body ------------------------
      body: Container(
        child: TabBarView(
          //physics: new NeverScrollableScrollPhysics(),
          controller: tabController,
          children: <Widget>[

            Year(),

            Section(),

            NotificationsPage(),

          ],
        ),
      ),

      //------------------------ floatingActionButton ------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/writePost_Staff");
        },
        child: Icon(
          Icons.create,
          size: 30.0,
        ),
        backgroundColor: Colors.black12,
      ),
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
              Icons.person,
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
