import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../ClassUsedInProject/shaw_post_class/other_functions.dart';

class AnswerQuestion extends StatefulWidget {

  String postId;
  List answer;
  AnswerQuestion({this.postId, this.answer});
  @override
  _AnswerQuestionState createState() => _AnswerQuestionState(postId: postId,answer: answer);
}

class _AnswerQuestionState extends State<AnswerQuestion> {

  String postId;
  List answer;
  _AnswerQuestionState({this.postId, this.answer});

  String url = 'http://www.uni-social.tk/api/v1/ask/addcommant';
  TextEditingController answerInput = new TextEditingController();

  @override
  initstate(){
    super.initState();
    readData();
  }
  //api
  _addAnswer() async {
    readData();
    if (answerInput.text.isNotEmpty) {
      await http.post(url, body: {
        "user_id": userId,
        "ask_id": postId,
        "comment": answerInput.text,
      });
    }
  }
  //write comment
  Widget writeAnswer() {
    return Flexible(
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  Icons.question_answer, size: 40,color: Colors.blue,),
                onTap: (){
                  _addAnswer();
                  answerInput.text = "";
                }
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: answerInput,
                  decoration: InputDecoration(
                    hasFloatingPlaceholder: true,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                  ),
                  focusNode: FocusNode(),
                  scrollPadding: EdgeInsets.all(10),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //============================================
//comment design
  Widget answerDesign(BuildContext context, i) {
    return Container(
      padding: EdgeInsets.only(bottom: 4),
      color: Colors.grey.shade100,
      width: MediaQuery.of(context).size.width - 10,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                padding: const EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(bottom: 15),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/avatar.jpg"),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Card(
                  margin: EdgeInsets.only(top: 2, bottom: 2, left: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 4, left: 5, right: 5),
                            child: Text(
                              "Student Name",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "${answer[i]['comment']}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget myContainer() {
    return Container(
      height: MediaQuery.of(context).size.height - 90,
      child: ListView.builder(
        itemCount: answer.length == null ? 0 : answer.length,
        itemBuilder: answerDesign,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Container(
              padding:EdgeInsets.only(top: 20),
              child: myContainer()
            ),
            Container(
              child: writeAnswer()
            ),
          ],
        ));
  }
}
