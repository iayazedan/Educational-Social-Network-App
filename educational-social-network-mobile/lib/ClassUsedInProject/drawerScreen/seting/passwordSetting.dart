import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'dart:convert';
import '../../shaw_post_class/other_functions.dart';

// ignore: camel_case_types
class passwordSetting extends StatefulWidget {
  @override
  _passwordSettingState createState() => _passwordSettingState();
}
// ignore: camel_case_types
class _passwordSettingState extends State<passwordSetting> {

  @override
  initState(){
    readData();
    super.initState();
  }

  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword1 = TextEditingController();
  TextEditingController newpassword2 = TextEditingController();

  String url = "http://uni-social.tk/api/v1/users/updatepassword/$userId";



  Future changeProfilePassword() async{


    if (oldpassword.text.isNotEmpty){

      if(newpassword1.text == newpassword2.text && newpassword1.text.isNotEmpty){

        var response = await http.post(url, body: {

          "password":oldpassword.text.toString(),
          "newpassword":newpassword1.text.toString(),

        });

        print(">>>>>>>>> passowrd change >>>>>>>>>:${response.body}");
      }



    }
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 60),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Icon(Icons.lock),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 50, bottom: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(color: Colors.black12)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                  hintText: 'Old Password',
                                  hintStyle: TextStyle(fontSize: 16)),
                              style: TextStyle(fontSize: 20),
                              obscureText: true,
                              controller: oldpassword,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(fontSize: 16)),
                              style: TextStyle(fontSize: 20),
                              obscureText: true,
                              controller: newpassword1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                  hintText: 'Re-Enter New Password',
                                  hintStyle: TextStyle(fontSize: 16)),
                              style: TextStyle(fontSize: 20),
                              obscureText: true,
                              controller: newpassword2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.white,
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          onPressed: () {
                            changeProfilePassword();
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.white,
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          onPressed:(){},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
