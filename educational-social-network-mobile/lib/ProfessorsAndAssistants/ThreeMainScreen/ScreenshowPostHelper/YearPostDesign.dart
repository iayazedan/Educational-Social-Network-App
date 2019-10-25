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

class year extends StatefulWidget {
  String selectedYearId;
  year(this.selectedYearId);
  @override
  _yearState createState() => _yearState(this.selectedYearId);
}
class _yearState extends State<year> {

  _yearState(this.selectedYearId);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  String url;
  List dataFromApi;
  String selectedYearId;



  Future makeRequest() async {
    if(selectedYearId!=null){
      setState(() {
        url = 'http://uni-social.tk/api/v1/post?'
            'status=1&&yearandsection_id=$selectedYearId';
      });
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
      child: dataFromApi == null?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Image(image: AssetImage("images/placeholder2.gif")),
          //Text("Loading...",),
        ],
      ):dataFromApi.length==0?Center(child: Text("No Data Found"),):
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
