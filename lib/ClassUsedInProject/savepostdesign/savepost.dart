import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart' as prefix0;
import 'dart:convert';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/the_Reacts_in_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/apisavepost/savepost.dart'as classSaveAndDelet;
import '../../ClassUsedInProject/SaveDropDownSelection/Globalstate.dart';
class BookMark extends StatefulWidget {
  @override
  _BookMarkState createState() => _BookMarkState();
}
class _BookMarkState extends State<BookMark> {
  GlobalState _store = GlobalState.instance;
  Color savecolor;
  Color savedcolor=Colors.black;
  @override
  void initState() {
    readData();
    this._getSavedPosts();
    super.initState();
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  String url = 'http://uni-social.tk/api/v1/seved?user_id=$userId';
  List dataFromApi;

  Future _getSavedPosts() async {
    var response = await http.get(url);
    setState(() {
      dataFromApi = json.decode(response.body);
    });
  }
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Save",style: TextStyle(fontSize: 16,color: Colors.black),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _getSavedPosts,
          child: dataFromApi == null ? Center(child: Text("Loading..."),) :
          ListView.builder(
            itemCount: dataFromApi.length,
            padding: const EdgeInsets.all(5.0),
            itemBuilder: (BuildContext context, i) {
              return Card(
                margin: EdgeInsets.only(bottom: 7.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      //------------------------- top design -------------------------
                      new PublisherInfo(
                        studentImagePath: "images/avatar.jpg",
                        studentName: "Khaled Sayed",
                        yearAndSection: "first year : Section 2",
                        postId:dataFromApi[i]["post"]['id'].toString(),
                        writePostUserId:dataFromApi[i]["post"]['user_id'].toString(),
                        userId: userId,
                      ),
                      //--------------------- content post ---------------------
                      new ContentPost(
                        postContent: dataFromApi[i]["post"]["content"],
                        stringAdditionsNames: dataFromApi[i]["post"]['image']==null?"[]":
                        dataFromApi[i]["post"]['image'],
                      ),
                      //--------------------- reacts post ---------------------
                      new Reacts(
                        userId: userId,
                        postId: dataFromApi[i]["post"]['id'].toString(),
                        listLikes: dataFromApi[i]["post"]['like'],
                         listComments: dataFromApi[i]["post"]["postcomment"],
                        timeOfPost: getTimePost(dataFromApi[i]["post"]['created_at']),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}