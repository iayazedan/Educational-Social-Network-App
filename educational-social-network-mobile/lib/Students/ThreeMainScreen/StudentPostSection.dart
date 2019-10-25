import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/the_Reacts_in_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart';


class StudentPostSection extends StatefulWidget {
  @override
  _StudentPostSectionState createState() => _StudentPostSectionState();
}
class _StudentPostSectionState extends State<StudentPostSection> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url;
  List dataFromApi;

  @override
  void initState() {
    readData();
    this.makeRequest();
    super.initState();
  }

  Future makeRequest() async {
    if(yearId != null){
      try{
        url = 'http://uni-social.tk/api/v1/post?status=1&&yearandsection_id=$yearId';
        var response = await http
            .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
        setState(() {
          dataFromApi = json.decode(response.body);
        });
      }catch(e){}
    }else {
      await readData();
      makeRequest();
    }
  }


  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: makeRequest,
      child: dataFromApi == null ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          CircularProgressIndicator(),
          Text("Loading...",style: TextStyle(height: 2),),
        ],
      ) : dataFromApi.length == 0? Center(child: Text("No Data Found"),):
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
                      yearAndSection: dataFromApi[i]["yearandsection"]["name"],
                      studentName: dataFromApi[i]["user"]["name"],
                      studentImagePath: dataFromApi[i]["user"]["image"]==null?
                      "":dataFromApi[i]["user"]["image"],
                      postId:dataFromApi[i]["id"].toString(),
                      writePostUserId:dataFromApi[i]["user_id"].toString(),
                      userId: userId,
                    ),

                    //--------------------- content post ---------------------

                    new ContentPost(
                      postContent: dataFromApi[i]["content"],
                      stringAdditionsNames: dataFromApi[i]['image']==null?"[]":
                      dataFromApi[i]['image'],
                    ),

                    //--------------------- reacts post ---------------------

                    new Reacts(
                      userId: userId,
                      postId: dataFromApi[i]['id'].toString(),
                      listLikes: dataFromApi[i]['like'],
                      listComments: dataFromApi[i]["postcomment"],
                      timeOfPost: getTimePost(dataFromApi[i]['created_at']),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}