import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class profile_page extends StatefulWidget {
  @override
  _profile_pageState createState() => _profile_pageState();
}

// ignore: camel_case_types
class _profile_pageState extends State<profile_page> {
  // ignore: non_constant_identifier_names
  Widget profile_pagedesign(BuildContext context, i) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black12)),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            //------------------------- top Design -------------------------

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(left: 10, top: 10, right: 20),
                  child: CircleAvatar(
                    child: Text("E"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Name",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text("Year : Section",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12,
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
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "Hello Students , there is an important ads !",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //color: Colors.white10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new IconButton(
                          onPressed: () {},
                          icon: new ImageIcon(
                              AssetImage("assets/images/like.png")),
                          color: Colors.green,
                          iconSize: 23.0,
                        ),
                        new Text(
                          "10K",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new IconButton(
                          onPressed: () {},
                          icon: new ImageIcon(
                              AssetImage("assets/images/comment.png")),
                          color: Colors.cyanAccent.shade400,
                          iconSize: 23,
                        ),
                        new Text(
                          "575",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: new Text(
                            "Just Now",
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            //---------------------Cover Image--------------
            Container(
              child: Image.asset(
                "images/background.jpg",
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            //--------------------User Data-----------------
            Container(
              width: MediaQuery.of(context).size.width,
              //---------------------User Picture----------------
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: CircleAvatar(
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 50),
                  ),
                  radius: 70,
                ),
              ),
            ),
            //---------------------User Name----------------
            Container(
              child: Text('Ahmed Saad'),
              padding: EdgeInsets.only(top: 200),
              alignment: Alignment.topCenter,
            ),
            //------------------User Year : Section-----------
            Padding(
              child: Text(
                'Fourth year , Section 1',
                style: TextStyle(color: Colors.white),
              ),
              padding: EdgeInsets.only(top: 230, left: 70),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Container(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: profile_pagedesign,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
