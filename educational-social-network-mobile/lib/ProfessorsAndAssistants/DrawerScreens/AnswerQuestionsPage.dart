import 'package:flutter/material.dart';
import '../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import '../../ClassUsedInProject/shaw_post_class/comment/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import './AddAnswer.dart';

class AnswerQuestions extends StatefulWidget {
  @override
  _AnswerQuestionsState createState() => _AnswerQuestionsState();
}

class _AnswerQuestionsState extends State<AnswerQuestions> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url = 'http://www.uni-social.tk/api/v1/ask';

  Future<List<QuestionsInfo>> _getQuestions() async {

    var response = await http.get(url);
    List dataFromApi = json.decode(response.body);

    List<QuestionsInfo> questionInfo= [];

    for(var item in dataFromApi){

      QuestionsInfo _questionInfo = new QuestionsInfo(
        userName: item["user"]["name"].toString(),
        userImage:item["user"]["image"]==null?"":item["user"]["image"],
        //yearAndSection: ,
        content: item["content"].toString(),
        userId: item["user_id"].toString(),
        answers: item["askcomment"],
        createdAt: item["created_at"].toString(),
        questionId: item["id"].toString(),
      );
      questionInfo.add(_questionInfo);
    }
    return questionInfo;
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
      appBar: new AppBar(title: Text("Answer Questions"),),
      body: RefreshIndicator(
        onRefresh: _getQuestions,
        key: _refreshIndicatorKey,
        child: Container(
          child: FutureBuilder(
            future: _getQuestions(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        CircularProgressIndicator(),
                        Text("Loading...",style: TextStyle(height: 2),),
                      ],
                    ),
                  ),
                );
              }else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context,int i){
                    return Card(
                        margin: EdgeInsets.all(8),
                        child: Container(
                            color: Colors.white,
                            child: Column(
                                children: <Widget>[

                                  new PublisherInfo(
                                    yearAndSection: "First Year : Section 1",
                                    studentName: snapshot.data[i].userName,
                                    studentImagePath: snapshot.data[i].userImage,
                                  ),

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      snapshot.data[i].content,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87),
                                    ),
                                  ),

                                  new Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 75,
                                    padding: EdgeInsets.only(left: 8,right: 8,top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new RaisedButton(
                                                color: Colors.blueGrey.shade100,
                                                onPressed:(){
                                                  Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context){
                                                        return AnswerQuestion(
                                                          postId: snapshot.data[i].questionId,
                                                          answer: snapshot.data[i].answers,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child:new Text(
                                                  "Add Answer (${getNumberOfComments(
                                                      snapshot.data[i].answers)})",
                                                  style: TextStyle(fontSize: 14.0,
                                                      color: Colors.blue.shade900),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: 5.0),
                                                child: new Text(
                                                  getTimePost(snapshot.data[i].createdAt),
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey.shade700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
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

class QuestionsInfo{

  String userName;
  String yearAndSection;
  String userImage;
  String questionId;
  String content;
  String userId;
  List answers;
  String createdAt;

  QuestionsInfo({this.content,this.userId,this.answers,this.createdAt,
    this.questionId,this.userName,this.userImage,this.yearAndSection});
}