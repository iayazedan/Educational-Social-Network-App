import 'package:flutter/material.dart';
import '../../apisavepost/savepost.dart'as classSaveAndDelete;
import '../../shaw_post_class/other_functions.dart';

class PublisherInfo extends StatelessWidget {

  String studentName;
  String studentImagePath;
  String yearAndSection;
  String writePostUserId;
  String postId;
  String userId;
  PublisherInfo({this.studentName,this.studentImagePath,this.yearAndSection,
    this.writePostUserId,this.postId,this.userId});


  _showalert(BuildContext context, String idpost) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are Your Sure?"),
            content: Text("You want to delet this post"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cansel"),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context, false);
                  Navigator.pop(context, false);
                  classSaveAndDelete.delitepost(idpost);
                },
              ),
            ],
          );
        });
  }

  _showModalBottomSheet(BuildContext context,String saveStatus) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Delete",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              )
                            ],
                          ),
                          onPressed: () {
                            if (userId == writePostUserId || groupId == "1")
                              _showalert(context, postId);
                          }
                          ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              saveStatus,
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          ],
                        ),
                        onPressed: () {
                          classSaveAndDelete.savePost(postId,userId);
                          Navigator.pop(
                            context,
                            false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          height: 45.0,
          width: 45.0,
          margin: EdgeInsets.only(
              left: 10.0, top: 10.0, right: 20.0),
          child: CircleAvatar(
            backgroundImage:
            studentImagePath.length<5?AssetImage("images/avatar.jpg"):
            NetworkImage(studentImagePath),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(studentName,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 2.0),
                  child: Text(yearAndSection,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.pinkAccent.shade100,
                      )),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: InkWell(
            onTap:()=> _showModalBottomSheet(context,"save / unSave"),
            child: Icon(Icons.format_list_bulleted),
          ),
        )
      ],
    );
  }
}
