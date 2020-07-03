import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';


class ContentPost extends StatefulWidget {

  String postContent;
  String stringAdditionsNames;
  ContentPost({this.postContent,this.stringAdditionsNames});

  @override
  _ContentPostState createState() => _ContentPostState(this.postContent,
      this.stringAdditionsNames);
}

class _ContentPostState extends State<ContentPost> {
  String postContent;
  String stringFilesNames;
  _ContentPostState(this.postContent,this.stringFilesNames);

  List imagesName;
  String videoName;
  List filesName;
  List originalFilesName;

  String urlImages = "http://uni-social.tk/files/posts/i-s";
  String urlVideo = "http://uni-social.tk/files/videos";
  String urlFile = "http://uni-social.tk/files/files";

  VideoPlayerController _playerController;

  @override
  void initState() {

    imagesName = [];
    videoName = "";
    filesName = [];
    originalFilesName = [];
    List temp = [];
    if(stringFilesNames.length>15){
      temp = jsonDecode(stringFilesNames);
      for (int i=0;i<temp.length;i++){
        if(temp[i]["fileType"].toString() == "1"){
          imagesName.add(temp[i]["fileName"].toString());
        }else if(temp[i]["fileType"].toString() == "2"){
          videoName = temp[i]["fileName"].toString();
        }else if(temp[i]["fileType"].toString() == "3"){
          filesName.add(temp[i]["fileName"].toString());
          originalFilesName.add(temp[i]["fileBName"].toString());
        }
      }
    }
    if(videoName.length>5){
      String urlTemp = urlVideo+"/"+videoName;
      String urlMyVideo = urlTemp.replaceAll(" ", "");
      _playerController = VideoPlayerController.network(urlMyVideo);
    }
    super.initState();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  List<NetworkImage> getImages(){
    if(imagesName.length>0){
      List<NetworkImage> myImages =[];
      for(String imageName in imagesName){
        String urlTemp = urlImages+"/"+imageName;
        myImages.add(NetworkImage(urlTemp.replaceAll(" ", ""),scale: 1.0));
        //debugPrint(urlTemp.replaceAll(" ", ""));
      }
      return myImages;
    }
    return null;
  }
  Widget showImage(BuildContext context, i) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.pink[300],
      ),
      child: new Carousel(
        autoplay: false,
        autoplayDuration: Duration(seconds: 3),
        images: getImages(),
        dotSize: 5.0,
        dotSpacing: 10.0,
        dotColor: Colors.white70,
        indicatorBgPadding: 9.0,
        dotBgColor: Colors.grey.withOpacity(0.5),
        borderRadius: true,
      ),
    );
  }


  ChewieController getVideo(){
    return ChewieController(
      videoPlayerController: _playerController,
      aspectRatio: 4 / 3,
      autoPlay: false,
      looping: false,
      autoInitialize: false,
      showControls: true,
    );
  }

  Widget getFile(){
    List<String> myFiles =[];
    for(String file in filesName){
      String urlTemp = urlFile+"/"+file;
      myFiles.add(urlTemp.replaceAll(" ", ""));
    }
    List<Card> myCardList = [];
    for(int i=0;i<originalFilesName.length;i++){
      myCardList.add(
        Card(
          child: new Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 8,right: 16),
                child: IconButton(
                    icon: Icon(Icons.cloud_download,size: 35,color:Colors.lightBlue),
                    onPressed: (){
                      print(myFiles[i]);
                      _launchURL(myFiles[i]);
                    },
                ),
              ),
              Expanded(child: Text(originalFilesName[i])),
              Icon(Icons.description,size: 35,color: Colors.grey.shade700,)
            ],
          ),
        )
      );
    }
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: myCardList,
      ),
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(16),
            child: Text(postContent, textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
            ),
          ),
          //>>>>>>>>>>>>>>>< get files <<<<<<<<<<<<<<<<<<<<<
          filesName.length>0?getFile():Container(height: 1,width: 1,),

          //>>>>>>>>>>>>>>>< get video <<<<<<<<<<<<<<<<<<<<<
          videoName.length>5?Chewie(controller: getVideo(),):
          Container(height:1,width:1,),

          //>>>>>>>>>>>>>>>< get images <<<<<<<<<<<<<<<<<<<<<
          imagesName.length>0? Center(
            child: new SizedBox(
                height: 250.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesName.length,
                  itemBuilder: showImage,
                ))):Container(height: 1,width: 1,),

        ],
      ),
    );
  }
}
