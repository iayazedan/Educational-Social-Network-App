
class PostInfo{

  //-------user info -------
  String yearAndSectionName;
  String userNameOfPost;
  String userImageOfPost;
//---------post info --------
  String postId;
  String content;
  String createdAt;
  String userId;
  String yearAndSectionId;
  List<dynamic> postLike;
  List<dynamic> postComment;
  String imagesName;

  PostInfo({this.postId,this.userId,this.content,this.userNameOfPost,this.userImageOfPost,
    this.createdAt,this.yearAndSectionId, this.yearAndSectionName,this.postComment,
    this.postLike,this.imagesName});
}