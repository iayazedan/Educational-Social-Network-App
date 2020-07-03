import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../../ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import '../../../ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import '../../../ClassUsedInProject/shaw_post_class/postDesign/the_Reacts_in_post.dart';
import '../../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../../ClassUsedInProject/SaveDropDownSelection/Globalstate.dart';

enum IndicatorType { overscroll, refresh }

class section extends StatefulWidget {
  List<int> mySectionsId;
  section(this.mySectionsId);
  @override
  _sectionState createState() => _sectionState(this.mySectionsId);
}
class _sectionState extends State<section> {

  _sectionState(this.sectionsId);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String url = 'http://uni-social.tk/api/v1/post?status=$userId';
  List dataFromApi;
  List<int> sectionsId;

  Future makeRequest() async {
    if(sectionsId!=null){
      if(sectionsId.length==1){
        setState(() {
          url = 'http://uni-social.tk/api/v1/post?'
              'status=1&&yearandsection_id=${sectionsId[0]}';
        });
      }else if(sectionsId.length==2){
        setState(() {
          url = 'http://uni-social.tk/api/v1/post?status=1&'
              'more_yearandsection=$sectionsId';
        });
      }
      try{
        var response = await http
            .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
        setState(() {
          dataFromApi = json.decode(response.body);
        });
      }catch(e){debugPrint(e.toString());}
    }else{
      makeRequest();
    }
  }

  @override
  void initState() {
    this.makeRequest();
    super.initState();
  }
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: makeRequest,
      child: dataFromApi == null ?
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
        Image(image: AssetImage("images/placeholder3.gif")),
            //Text("Loading...",),
          ],
        ),
      ) :
      ListView.builder(
        itemCount:dataFromApi.length,
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (BuildContext context, i) {
          return Card(
                  margin: EdgeInsets.only(bottom: 7.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        //--------------------- top design ---------------------

                        new PublisherInfo(
                          yearAndSection: dataFromApi[i]["yearandsection"]["name"],
                          studentName: dataFromApi[i]["user"]["name"],
                          studentImagePath: dataFromApi[i]["user"]["image"]==null?
                          "":dataFromApi[i]["user"]["image"],
                          postId:dataFromApi[i]["id"].toString(),
                          userId: userId,
                        ),

                        //--------------------- content post -------------------

                        new ContentPost(
                          postContent: dataFromApi[i]['content'],
                          stringAdditionsNames: dataFromApi[i]['image']==null?"[]":
                          dataFromApi[i]['image'],
                        ),

                        //--------------------- Reacts post --------------------

                        new Reacts(
                          userId: userId,
                          postId: dataFromApi[i]['id'].toString(),
                          listLikes: dataFromApi[i]['like'],
                          listComments: dataFromApi[i]["postcomment"],
                          timeOfPost: getTimePost(dataFromApi[i]['created_at']),
                        ),
                      ],
                    ),
                  )
          );
        },
      ),
    );
  }
}
