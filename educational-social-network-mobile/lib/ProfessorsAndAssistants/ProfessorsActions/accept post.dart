import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum IndicatorType { overscroll, refresh }

class acceptandrejectpost extends StatefulWidget {
  @override
  _acceptandrejectpostState createState() => _acceptandrejectpostState();
}

class _acceptandrejectpostState extends State<acceptandrejectpost> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String url = 'http://uni-social.tk/api/v1/post';
  List data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata;
    });
  }

  deleteRejected(int i) async {
    print(i);
    String url = 'http://uni-social.tk/api/v1/post/delete/$i';
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    _refreshIndicatorKey.currentState.show();
  }

  acceptPost(int i, int user_id, String content) async {
    print(i);
    String url = 'http://uni-social.tk/api/v1/post/update/$i';
    var response = await http.post(Uri.encodeFull(url), body: {
      "user_id": user_id.toString(),
      "content": content,
      "status": "1",
    }, headers: {
      "Accept": "application/json"
    });
    _refreshIndicatorKey.currentState.show();
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/Staff");
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "posts",
          style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: makeRequest,
        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (BuildContext context, i) {
            return data[i]["status"] == 1
                ? Text("")
                : Card(
                    margin: EdgeInsets.only(bottom: 17.0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          //------------------------- top design -------------------------

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 45.0,
                                width: 45.0,
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 10.0, right: 20.0),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("images/avatar.jpg"),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(i % 2 == 0 ? "ON" : "Ya",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(top: 2.0),
                                      child: Text("Fourth Year CS : Section 2",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.pinkAccent.shade100,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          //--------------------- content post ---------------------

                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    data[i]["content"],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87),
                                  ),
                                ),
                                new Image(
                                  image: AssetImage("images/sec.jpg"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RaisedButton(
                                  color: Colors.green,
                                  child: Text("Accept"),
                                  onPressed: () => acceptPost(data[i]['id'],
                                      data[i]['user_id'], data[i]['content']),
                                ),
                                RaisedButton(
                                  color: Colors.red,
                                  child: Text("Reject"),
                                  onPressed: () =>
                                      deleteRejected(data[i]['id']),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
          },
        ),
      ),
    );
  }
}
