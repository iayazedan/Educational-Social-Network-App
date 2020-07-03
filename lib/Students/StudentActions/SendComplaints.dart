import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../student.dart';

class SendComplaints extends StatefulWidget {
  @override
  _SendComplaintsState createState() => _SendComplaintsState();
}

class _SendComplaintsState extends State<SendComplaints> {

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
                  Flexible(child: Text("your Complaint Send Successfully"
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

  bool professorsCheck = false;
  bool secretaryCheck = false;

  TextEditingController sendComplaintController = new TextEditingController();
  String url = "http://uni-social.tk/api/v1/complaints/add";

  Future<void> _sendComplaint() async {
    if (sendComplaintController.text.isNotEmpty&&(professorsCheck||secretaryCheck)){
      await http.post(url, body: {
        "content": sendComplaintController.text,
        "user_id": userId,
      });

    }
    showSuccessDialog();

  }
  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Send Complaint",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                new ExpansionTile(
                  title: new Text("Choose Who Receive Your Complaint",
                    style: TextStyle(fontSize:14 ),),
                  children: <Widget>[
                    new CheckboxListTile(
                        value: professorsCheck,
                        onChanged: (bool value) {
                          setState(() {
                            professorsCheck = value;
                            secretaryCheck = false;
                          });
                        },
                      title: new Text("Professors / assistants"),
                        ),
                    new CheckboxListTile(
                      value: secretaryCheck,
                      onChanged: (bool value) {
                        setState(() {
                          secretaryCheck = value;
                          professorsCheck = false;
                        });
                      },
                      title: new Text("Secretary"),
                    )
                  ],
                ),
                TextFormField(
                  controller: sendComplaintController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: "Write your complain ",
                      labelText: "Type Here"),
                  textCapitalization: TextCapitalization.words,
                  maxLines: 8,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  child: RaisedButton.icon(
                    icon: Icon(Icons.send,color: Colors.blue,),
                    color: Colors.white70,
                    label:Text(
                      "Send",
                      style: TextStyle(),
                    ),
                    onPressed:_sendComplaint,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
