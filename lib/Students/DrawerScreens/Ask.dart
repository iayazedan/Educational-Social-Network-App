import 'package:flutter/material.dart';
import '../student.dart';
import 'package:http/http.dart'as http;
import '../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../student.dart';

class AskQuestion extends StatefulWidget {
  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _postcontroller = new TextEditingController();

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
    ));
  }

  void showSuccessDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Operations Success"),
          content: new Container(
            child: Row(
              children: <Widget>[
                new Icon(Icons.check,size: 60,color: Colors.blue,),
                Flexible(child: Text("your Question Send Successfully"
                  ,style: TextStyle(fontSize: 18),))
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton.icon(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Student()));
                },
                icon: new Icon(Icons.close),
                label: Text("close")
            )
          ],
        );
    }
    );
  }

  Future<void> _addAsk()async{
    if(_postcontroller.text.isEmpty) {
      showInSnackBar("Please Write Your ask");
      return;
    }
    else {
      var sendAsk = await http.post("http://www.uni-social.tk/api/v1/ask/add",body:{
        "content": _postcontroller.text,
        "user_id":userId,
      });
      debugPrint("ask work very well"+sendAsk.body);
      showSuccessDialog();
    }
  }


  int nOfLines = 12;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          key: _scaffoldKey,

          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            leading: InkWell(
              child: Icon(Icons.arrow_back),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => Student()),
                );
              },
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: new Text("Ask Question",style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),),
          ),

          // ---------------------------- start body ---------------
          // ---------------------------- start body ---------------
          // ---------------------------- start body ---------------

          body: new Container(
            child: new Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.cyan,
                ),
                child: new Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.only(left: 20, top: 3, bottom: 3),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top:5,bottom: 5,right: 10),
                                          child: new CircleAvatar(
                                            minRadius: 20,
                                          )),
                                      Text(
                                        " Student Name ",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //------------------------------------------- write post here
                        //------------------------------------------- write post here
                        //------------------------------------------- write post here
                        //------------------------------------------- write post here

                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: (MediaQuery.of(context).size.height/5)*1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),

                                  border:Border.all(color: Colors.grey.shade300,width: 1.5),

                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: _postcontroller,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide:
                                                BorderSide(color: Colors.black)),
                                            filled: true,
                                            hintText: "Write your Ask",
                                            labelText: "Type Here"),
                                        textCapitalization: TextCapitalization.words,
                                        maxLines: nOfLines,
                                        keyboardType: TextInputType.text,
                                        style:
                                        TextStyle(fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 75,
                          padding: EdgeInsets.all(16),
                          child: new RaisedButton.icon(
                            onPressed: _addAsk,
                            icon: new Icon(Icons.send,color: Colors.blue,),
                            label: Text("Send Your Question !"),
                          ),
                        ),
                      ],
                    ))),
          ),
        )
    );
  }
}
