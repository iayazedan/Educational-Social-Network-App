import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/shaw_post_class/PostInfo/PostInfo.dart';

class PostersNotifications extends StatefulWidget {
  @override
  _PostersNotificationsState createState() => _PostersNotificationsState();
}

class _PostersNotificationsState extends State<PostersNotifications> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url = 'http://www.uni-social.tk/api/v1/posters';
  List dataFromApi;

  Future<List<PostInfo>> _getPosts() async {

    try{
      var response = await http.get(url);
      dataFromApi = json.decode(response.body);

    }catch(e){debugPrint(e.toString());}

    List<PostInfo> postInfo= [];

    for(var item in dataFromApi){
      PostInfo _postInfo = new PostInfo(
        imagesName: item["image"]==null?"[]":item['image'],
        postId: item["id"].toString(),
        content: item["content"].toString(),
        createdAt: item["created_at"].toString()==null?"":
        item["created_at"].toString(),
        yearAndSectionId: item["yearandsection_id"].toString(),
        yearAndSectionName: item["yearandsection"]["name"].toString()
      );
      postInfo.add(_postInfo);
    }
    print(postInfo.length);
    return postInfo;
  }

  @override
  void initState() {
    super.initState();
  }
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getPosts,
      key: _refreshIndicatorKey,
      child: Container(
        child: FutureBuilder(
          future: _getPosts(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  CircularProgressIndicator(),
                  Text("Loading...",style: TextStyle(height: 2),),
                ],
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int i){
                  return Card(
                      margin: EdgeInsets.only(bottom: 7.0),
                      child: Container(
                          color: Colors.white,
                          child: Column(
                              children: <Widget>[

                                Container(

                                  child: Row(
                                    children: <Widget>[

                                      Flexible(
                                        child: new PublisherInfo(
                                          yearAndSection:
                                          "Secretary",
                                          studentName: "Khaled Sayed",
                                          studentImagePath: "images/avatar.jpg",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                new ContentPost(
                                  postContent: snapshot.data[i].content,
                                  stringAdditionsNames: snapshot.data[i].imagesName,
                                ),

                                Container(
                                  padding: EdgeInsets.only(top: 16,bottom: 16,right: 32),
                                  alignment: Alignment.bottomRight,
                                  child: new Text(
                                    getTimePost(snapshot.data[i].createdAt),
                                    style: TextStyle(fontSize: 16,color: Colors.grey),
                                  ),
                                ),

                              ]
                          )
                      )
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}