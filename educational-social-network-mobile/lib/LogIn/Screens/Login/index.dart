import 'package:flutter/material.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../Components/Form.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../Components/Form.dart'as userinput;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;
  String uYG;
  String userId;
  String yearId;
  String groupId;
  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 5000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData;
    String url = 'http://uni-social.tk/api/v1/users/login';
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<
        ScaffoldState>();
    //shared perefrance save data with login

    //snackpar for api
    void showInSnackBar(String value) {
      FocusScope.of(context).requestFocus(new FocusNode());
      _scaffoldKey.currentState?.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: "WorkSansSemiBold"),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      ));
    }
    //shared perefrance save data with login
    savedata(String value) async {
      final savelogin = await SharedPreferences.getInstance();
      savelogin.setString("all", value);
      debugPrint("value login saved : "+value);
    }

    Future recordData({String userId ,String yearId,groupId})async{
      String allData = "$userId" + "." + "$yearId" + "." + "$groupId";
      await savedata(allData);
    }
    //api
    login() async {

        final response = await http.post(url, body: {
          "identification": userinput.username.text,
          "password": userinput.password.text,
        });

          if(response.statusCode == 200) {
              debugPrint("all data "+response.body.toString());

              userData = jsonDecode(response.body);
              recordData(
                userId: userData["id"].toString(),
                groupId: userData["group_id"].toString(),
                yearId: userData["yearandsection_id"].toString(),
              );
              setState(() {
                userId = userData["id"].toString();
                groupId = userData["group_id"].toString();
                yearId = userData["yearandsection_id"].toString();

                animationStatus = 1;

              });
              print("Logged in ");
              _playAnimation();

            }else{
            showInSnackBar("Check your data");
          }
      }

      //=============================================
      timeDilation = 0.4;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      return (new Scaffold(
        body: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/login_background.png'),
                //fit: BoxFit.none,
              ),
            ),
            child: new Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      colors: <Color>[
                        const Color.fromRGBO(162, 146, 199, 0.8),
                        const Color.fromRGBO(51, 51, 63, 0.9),
                      ],
                      stops: [0.2, 1.0],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 1.0),
                    )),
                child: new ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: <Widget>[
                    new Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[


                        new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Container(
                              width: 250.0,
                              height: 250.0,
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new ExactAssetImage('images/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            new FormContainer(),
                          Container(
                              padding: EdgeInsets.only(bottom: 190),)
                          ],
                        ),
                        animationStatus == 0
                            ? new Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: new InkWell(
                              onTap: () {
                                setState(() {
                                  login();

                                });
                                },
                              child: new Container(
                                width: 320.0,
                                height: 60.0,
                                alignment: FractionalOffset.center,
                                decoration: new BoxDecoration(
                                  color: const Color.fromRGBO(
                                      247, 64, 106, 1.0),
                                  borderRadius: new BorderRadius.all(
                                      const Radius.circular(30.0)),
                                ),
                                child: new Text(
                                  "Sign In",
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              )),
                        )
                            : new StaggerAnimation(
                            buttonController:
                            _loginButtonController.view,
                            group_id: groupId),
                      ],
                    ),
                  ],
                ))),
      ));
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
