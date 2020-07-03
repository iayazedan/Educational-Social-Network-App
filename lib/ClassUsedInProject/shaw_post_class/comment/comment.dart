import 'package:flutter/material.dart';
import '../../../main.dart' as userid;
import 'package:http/http.dart' as http;
class coment extends StatefulWidget {
  String id;
  List comment;
  coment({this.id, this.comment});
  @override
  _comentState createState() => _comentState(idpost: id, comment: comment);
}
class _comentState extends State<coment> {
  String idpost;
  List comment;
  _comentState({this.idpost, this.comment});
  String url = 'http://www.uni-social.tk/api/v1/post/addcommant';
  TextEditingController commentinput = new TextEditingController();
  //api
  _apiwritcoment() async {
    if (commentinput.text.isNotEmpty) {
      final response = await http.post(url, body: {
        "user_id": userid.userId,
        "post_id": idpost,
        "comment": commentinput.text,
      });
    }
  }
  //write comment
  Widget writecoment() {
    return Expanded(
      child: Container(
        child: Wrap(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: InkWell(
                      child: Icon(
                        Icons.camera_alt,
                        size: 40,
                      ),
                      onTap: () => bottomsheet(context),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      controller: commentinput,
                      decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        isDense: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            _apiwritcoment();
                            commentinput.text = "";
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        filled: true,
                      ),
                      focusNode: FocusNode(),
                      scrollPadding: EdgeInsets.all(10),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //==============================================================
  //ride image from phone
  void bottomsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext i) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: Wrap(
              children: <Widget>[],
            ),
          );
        });
  }

  //============================================
//comment design
  Widget commentdesign(BuildContext context, i) {
    return Container(
      color: Colors.grey.shade100,
      width: MediaQuery.of(context).size.width - 10,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                padding: const EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(bottom: 15),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/avatar.jpg"),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Card(
                  margin: EdgeInsets.only(top: 2, bottom: 2, left: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 4, left: 5, right: 5),
                            child: Text(
                              "Elsayed Mahmoud Abellatif",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, left: 5, right: 5),
                          child: Text(
                            "${comment[i]['comment']}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget mycontainer() {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      child: ListView.builder(
        itemCount: comment.length == null ? 0 : comment.length,
        itemBuilder: commentdesign,
      ),
    );
  }

  Widget newcontainer() {
    return Container(
      height: MediaQuery.of(context).size.height - 400,
      child: ListView.builder(
        itemCount:0,
        itemBuilder: commentdesign,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            mycontainer(),
            writecoment(),
          ],
        ));
  }
}
