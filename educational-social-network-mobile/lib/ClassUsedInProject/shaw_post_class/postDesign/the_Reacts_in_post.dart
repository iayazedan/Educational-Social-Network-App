import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../comment/comment.dart';
import '../Like/LikePost.dart';
import '../other_functions.dart';

class Reacts extends StatefulWidget {

  String postId;
  String userId;
  List<dynamic> listLikes;
  List<dynamic> listComments;
  String timeOfPost;

  Reacts({this.timeOfPost,this.postId,this.userId,this.listLikes, this.listComments});

  @override
  _ReactsState createState() => _ReactsState(this.timeOfPost,this.postId,this.userId,
      this.listLikes,this.listComments);
}

class _ReactsState extends State<Reacts> {

  Color colorLike;
  String postId;
  String userId;
  List<dynamic> listLikes;
  List<dynamic> listComments;
  String numberOfLikes;
  String numberOfComments;
  String timeOfPost;

  _ReactsState(this.timeOfPost,this.postId,this.userId,this.listLikes,
      this.listComments){

    colorLike = getPostLikeColor(listLikes);
    numberOfLikes = getNumberOfLikes(listLikes);
    numberOfComments = getNumberOfComments(listComments);

  }

  likeOnPressed(){
    new LikeClass(userId: userId,postId:postId);
    if(colorLike == Colors.black26){
      setState(() {
        makeRequestLike();
        colorLike = Colors.green.shade400;
        numberOfLikes = "${int.parse(numberOfLikes)+1}";
      });
    }else{
      setState(() {
        likeId = getLikeId(listLikes,userId);
        makeRequestRemoveLike();
        colorLike = Colors.black26;
        numberOfLikes = "${int.parse(numberOfLikes)-1}";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                  onPressed: likeOnPressed,
                  icon: new ImageIcon(
                      AssetImage("images/like.png")),
                  color: colorLike,
                  iconSize: 20.0,
                ),
                new Text(
                  numberOfLikes,
                  style: TextStyle(
                    fontSize: 15.0,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => coment(
                          id: postId,
                          comment: listComments,

                        ),
                      ),
                    );
                  },
                  icon: new ImageIcon(
                      AssetImage("images/comment.png")),
                  color: Colors.cyanAccent.shade400,
                  iconSize: 20.0,
                ),
                new Text(
                  numberOfComments,
                  style: TextStyle(
                    fontSize: 15.0,
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
                  margin: EdgeInsets.only(left: 5.0),
                  child: new Text(
                    timeOfPost,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
