import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

String getTimePost(String datePost) {

  if(datePost == null) return "Time can't Detected";
  if(datePost.length<5) return "Time can't Detected";


  DateTime dateNow = new DateTime.now();

  int yearPOst = int.parse(datePost.toString().substring(0, 4).trim());
  int yearNow = int.parse(dateNow.toString().substring(0, 4).trim());
  int year = yearNow - yearPOst;

  int monthPost = int.parse(datePost.toString().substring(5, 7).trim());
  int monthNow = int.parse(dateNow.toString().substring(5, 7).trim());
  int month = monthNow - monthPost;

  int dayPost = int.parse(datePost.toString().substring(8, 10).trim());
  int dayNow = int.parse(dateNow.toString().substring(8, 10).trim());
  int day = dayNow - dayPost;

  int hourPost = int.parse(datePost.toString().substring(11, 13).trim());
  int hourNow = int.parse(dateNow.toString().substring(11, 13).trim());
  int hour = hourNow - hourPost;
  if(hour<0) {while(hour<0) hour++;}

  if (year != 0) {
    return "since $yearPOst";
  } else{
    if (month != 0) {
      return "since $month month";
    } else{
      if (day != 0) {
        return "since $day day";
      } else{
        if (hour != 0) {
          return "since $hour hour";
        } else{
          return "Just Now";
        }
      }
    }
  }
}


String uYG;
String userId;
String yearId;
String groupId;

Future readData() async {
  final saveLogin = await SharedPreferences.getInstance();
  uYG = saveLogin.getString("all");

  userId = uYG.split(".")[0];
  yearId = uYG.split(".")[1];
  groupId = uYG.split(".")[2];
}

String getLikeId(List<dynamic> likesData,String userId){
  for(int i = 0;i<likesData.length;i++){
    if(likesData[i]["user_id"].toString()==userId){
      return likesData[i]["id"].toString();
    }
  }
  return "0";
}

String getNumberOfLikes(List<dynamic> likesData){
  return "${likesData.length}";
}
String getNumberOfComments(List<dynamic> likesData){
  return "${likesData.length}";
}


Color getPostLikeColor(List likeData){
  readData();
  for(var item in likeData){
    if(item["user_id"].toString()==userId){
      return Colors.green.shade400;
    }
  }
  return Colors.black26;
}
