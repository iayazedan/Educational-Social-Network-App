import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../other_functions.dart';
import 'dart:async';
import 'dart:convert';


String _userId;
String _postId;
String likeId;


class LikeClass{

  String userId;
  String postId;


  LikeClass({this.userId,this.postId}){
    _postId=postId;
    _userId=userId;
  }

}


void makeRequestLike() async {
  var response = await http.post("http://uni-social.tk/api/v1/like/add", body: {
    "user_id":_userId,
    "post_id":_postId,
  });
  debugPrint("add like id:"+json.decode(response.body)["id"].toString());

}
void makeRequestRemoveLike() async {
  await http.get(Uri.encodeFull("http://uni-social.tk/api/v1/like/delete/$likeId"),
      headers: {"Accept": "application/json"});

  debugPrint("remove like id: "+likeId);
}



