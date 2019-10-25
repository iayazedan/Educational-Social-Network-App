import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/the_Reacts_in_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart';
import 'package:unisocial/LogIn/Components/Form.dart';

class getNotifications extends StatefulWidget {
  String posid;
  getNotifications(this.posid);
  @override
  _getNotificationsState createState() => _getNotificationsState(this.posid);
}

class _getNotificationsState extends State<getNotifications> {
 final String postid;
  _getNotificationsState(this.postid);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  var dataFromApi;

  @override
  void initState() {
    readData();
    this.makeRequest();
    super.initState();
  }

  Future makeRequest() async {
    print("Hello World");
    try {
      Response response = await http
          .get('http://uni-social.tk/api/v1/post/getById/25', headers: {"Accept": "application/json"});
      setState(() {
        dataFromApi = json.decode(response.body);

      });
      print(dataFromApi);
    } catch (e) {
      print("error!!");
    }
  }

  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: new TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: makeRequest,
        child: dataFromApi == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Image(image: AssetImage("images/placeholder2.gif")),
            //Text("Loading...",),
            ],):ListView(
                padding: const EdgeInsets.all(5.0),
                children: <Widget>[
                  Card(
                      margin: EdgeInsets.only(bottom: 7.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            //------------------------- top design -------------------------

                            new PublisherInfo(
                              yearAndSection: dataFromApi['yearandsection']
                              ['name'],
                              studentName: dataFromApi["user"]["name"],
                              studentImagePath:
                              dataFromApi["user"]["image"] == null
                                  ? ""
                                  : dataFromApi["user"]["image"],
                              postId: dataFromApi["id"].toString(),
                              writePostUserId:
                              dataFromApi["user_id"].toString(),
                              userId: userId,
                            ),

                            //--------------------- content post ---------------------

                            new ContentPost(
                              postContent: dataFromApi["content"],
                              stringAdditionsNames: dataFromApi['image'] == null
                                  ? "[]"
                                  : dataFromApi['image'],
                            ),

                            //--------------------- reacts post ---------------------

                            new Reacts(
                              userId: userId,
                              postId: dataFromApi['id'].toString(),
                              listLikes: dataFromApi['like'],
                              listComments: dataFromApi["postcomment"],
                              timeOfPost:
                              getTimePost(dataFromApi['created_at']),
                            ),
                          ],
                        ),
                      ))
                ],

              ),
      ),
    );
  }
}
