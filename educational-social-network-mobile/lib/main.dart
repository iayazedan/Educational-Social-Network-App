import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unisocial/Students/student.dart' as student;
import 'package:unisocial/Students/StudentActions/writepost.dart' as writePost;
import 'package:unisocial/Students/StudentActions/SendComplaints.dart' as SendComplaints;
import 'package:splashscreen/splashscreen.dart';
import './ProfessorsAndassistants/ProfessorsAndAssistants.dart' as staff;
import 'package:unisocial/ProfessorsAndAssistants/ProfessorsActions/writePost.dart' as wp;
import 'package:unisocial/ProfessorsAndAssistants/ProfessorsActions/accept post.dart'as acceptPost;
import 'package:unisocial/ProfessorsAndAssistants/DrawerScreens/ShowComplaints.dart' as Complaints;
import './LogIn/Screens/Login/index.dart';
import './Secretary/Secretary.dart' as secretary;
import './ClassUsedInProject/savepostdesign/savepost.dart'as designsavepost;
import './ClassUsedInProject/drawerScreen/seting/setting.dart'as Setting;
import './ClassUsedInProject/drawerScreen/profile/profile_page.dart'as Profile;
import './ProfessorsAndAssistants/ProfessorsAndAssistants.dart' as adminYears;
import 'package:firebase_messaging/firebase_messaging.dart';


//shared perefrance save data with login
String uYG;
String userId;
String yearId;
String groupId;
main() {
  runApp(MaterialApp(
      title: "UniSocial",
      home: MyApp(),
      routes: <String, WidgetBuilder>{
        '/Login': (context) => LoginScreen(),
        '/Student': (context) => student.Student(),
        '/writepost': (context) => writePost.writepost(),
        '/sendcomplaints': (context) => SendComplaints.SendComplaints(),
        '/Staff': (context) => staff.Admin(),
        '/writePost_Staff': (context) => wp.MyApp(),
        '/acceptpost': (context) => acceptPost.acceptandrejectpost(),
        '/complaints': (context) => Complaints.ShowComplaints(),
        '/Profile': (context) => Profile.profile_page(),
        '/secretary': (context) => secretary.Secretary(),
        '/designsavepost': (context) => designsavepost.BookMark(),
        '/Setting': (context) => Setting.Setting(),
        '/adminyears': (context) => adminYears.Admin(),
      }));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    readdata();
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic> message){
        print("onMessage: "+message.toString());
      },
      onResume: (Map<String,dynamic> message){
        print("onResume: "+message.toString());
      },
      onLaunch: (Map<String,dynamic> message){
        print("onLaunch: "+message.toString());
      },
    );
    _firebaseMessaging.getToken().then((token){
      print("TOKEN: "+token);
    });
    super.initState();
  }

  showTost(){
    debugPrint(groupId);
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: userId == null ? LoginScreen()
            :groupId == "1" ? staff.Admin()
            :groupId == "2" ? student.Student()
            :groupId == "3" ? secretary.Secretary()
            :showTost,
        title: new Text(
          'Welcome To UniSoscial',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.asset('images/login_logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Hello"),
        loaderColor: Colors.red)
    ;
  }
  //shared perefrance save data with login
  readdata() async {
    final savelogin = await SharedPreferences.getInstance();
    setState(() {
      uYG = savelogin.getString("all");

      if (uYG != null) {
        userId = uYG.split(".")[0];
        yearId = uYG.split(".")[1];
        groupId = uYG.split(".")[2];
      }
    });
  }
}
