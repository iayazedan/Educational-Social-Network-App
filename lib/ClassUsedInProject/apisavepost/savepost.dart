import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'dart:async';

var myresponse;
  Future savePost(String postid, String userid) async {
    final response = await http.post(
        "http://uni-social.tk/esn/apiMob/save", body: {
      "post_id": postid,
      "user_id": userid,
    });
    myresponse=response.body;
    print(myresponse);
//    if(response.body=="1"){
//
//    }
  }
Future delitepost(String postid) async {
  await http.get(Uri.encodeFull("http://uni-social.tk/api/v1/post/delete/$postid"),
      headers: {"Accept": "application/json"});

}
