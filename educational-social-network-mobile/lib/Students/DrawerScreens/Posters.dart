import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/PostInfo/PostInfo.dart';
import 'package:unisocial/ClassUsedInProject/YearAndSectionId/YearAndSectionId.dart';

class StudentsPosters extends StatefulWidget {
  @override
  _StudentsPostersState createState() => _StudentsPostersState();
}

class _StudentsPostersState extends State<StudentsPosters> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url;
  List dataFromApi;
  List<PostInfo> postInfo;

  Future makeRequest()async{
    try{
      if(yearId != null){
        url = "http://www.uni-social.tk/api/v1/posters?"
            "yearandsection_id=${getIdByYearAndSectionId(int.parse(yearId))}";
        var response = await http.get(url);
        dataFromApi = json.decode(response.body);
      }else{
        makeRequest();
      }
    }catch(e){debugPrint(e.toString());}
  }

  Future<List<PostInfo>> _getPosts() async {

    if(dataFromApi==null){
      await makeRequest();
    }
    postInfo= [];

    for(var item in dataFromApi){
      PostInfo _postInfo = new PostInfo(
          imagesName: item["image"]==null?"[]":item['image'],
          postId: item["id"].toString(),
          content: item["content"].toString(),
          createdAt: item["created_at"].toString(),
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
    readData();
    super.initState();
  }
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posters"),),
      body: RefreshIndicator(
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
                    Image(image: AssetImage("images/placeholder2.gif")),
                  ],
                );
              }else if(postInfo.length == 0){
                return Center(child: Text("No Data Found"),);
              }
              else{
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
      ),
    );
  }
}