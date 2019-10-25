import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'dart:convert';
import '../../upload Images/Uploading images.dart';
import '../../shaw_post_class/other_functions.dart';
import 'package:custom_multi_image_picker/asset.dart';
import 'package:custom_multi_image_picker/custom_multi_image_picker.dart';
import '../../ClassShowImage/asset_view.dart';
// ignore: camel_case_types
class profileSetting extends StatefulWidget {
  @override
  _profileSettingState createState() => _profileSettingState();
}

// ignore: camel_case_types
class _profileSettingState extends State<profileSetting> {

  @override
  initState(){
    readData();
    super.initState();
  }

  List imageName;
  String url = "http://uni-social.tk/api/v1/users/updateimage/$userId";
  List<Asset> images = List<Asset>();
  String _error;

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        return AssetView(index, images[index]);
      }),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );

    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      // print(images[0].getPath) ;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future changeProfilePicture() async{

    if (images!=null && images.length==1){

      imageName = await uploadingImages(images);

      String tempImage = imageName.toString().replaceAll("[", "");
      String myImage = tempImage.replaceAll("]", "");

      var response = await http.post(url, body: {

        "image":"testing.png",

      });

      print(">>>>>>>> profile image userID:$userId >>>>>>>>>>:${response.body}");


    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 60),
            child: Card(
              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black12),

              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Picture",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child:Container(
                      alignment: Alignment.centerLeft,
                      width: 85.0,
                      height: 85.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/avatar.jpg"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    width: 200,
                    height: 40,
                    child: RaisedButton(
                      onPressed: () => loadAssets(),
                      disabledColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.file_upload,
                            color: Colors.black,
                          ),
                          Text(
                            "Upload New",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            onPressed: () {
                              changeProfilePicture();
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
