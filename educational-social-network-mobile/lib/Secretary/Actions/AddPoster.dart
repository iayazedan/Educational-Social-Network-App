import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../Secretary.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import '../../ClassUsedInProject/upload Images/Uploading images.dart';
import '../../ClassUsedInProject/FunctionHelper/FunctionHelper.dart';
import '../../ClassUsedInProject/YearAndSectionId/YearAndSectionId.dart';
import 'package:flutter/services.dart';
import '../../ClassUsedInProject/ClassShowImage/asset_view.dart';
import 'package:custom_multi_image_picker/asset.dart';
import 'package:custom_multi_image_picker/custom_multi_image_picker.dart';


class AddPoster extends StatefulWidget {
  @override
  _AddPosterState createState() => _AddPosterState();
}

class _AddPosterState extends State<AddPoster> {
  List<Asset> images = List<Asset>();
  String _error;
  List imageNameInServer = [];


  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      mainAxisSpacing: 3,crossAxisSpacing: 3,
      scrollDirection: Axis.vertical,
      crossAxisCount: 5,
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _postcontroller = new TextEditingController();
  List<bool> selectYear = [false, false, false, false];
  int nOfLines = 10;
  String addPoserUrl = "http://www.uni-social.tk/api/v1/posters/addmult";



  onExpChange(bool state) {
    if (state) {
      setState(() {
        nOfLines = 1;
      });
    } else {
      Future.delayed(const Duration(milliseconds: 150), () {
        setState(() {
          nOfLines = (MediaQuery.of(context).size.height / 65).toInt();
        });
      });
    }
  }

  year1(bool v) => setState(() {
        selectYear[0] = v;
      });
  year2(bool v) => setState(() {
        selectYear[1] = v;
      });
  year3(bool v) => setState(() {
        selectYear[2] = v;
      });
  year4(bool v) => setState(() {
        selectYear[3] = v;
      });

  List getYearsId(){
    List myYearsId = [];
    for(int i=0;i<selectYear.length;i++){
      if(selectYear[i]){
        myYearsId.add(yearsId[i]);
      }
    }
    return myYearsId;
  }

  Future publishPoster() async {
    if ((_postcontroller.text.isNotEmpty || images.length != 0) &&
        (selectYear[0] || selectYear[1] || selectYear[2] || selectYear[3])) {
      if (images.length != 0) {
        if(imageNameInServer.length==0){
          showInSnackBar(context, "uploading image ...", scaffoldKey: _scaffoldKey);
          imageNameInServer = await uploadingImages(images);
        }
      }
      var response = await http.post(addPoserUrl, body: {
        "content": _postcontroller.text == null ? "_"
            : _postcontroller.text == "" ? "_" : _postcontroller.text,
        "yearandsection_id": json.encode(getYearsId()),//updated needed
        "image": imageNameInServer.length>0?json.encode(imageNameInServer):"[]",
      });
      print(response.statusCode);
      if (response.statusCode == 200)
        showSuccessDialog(context, () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Secretary()));
        }, "Poster is puplished");
    } else {
      showInSnackBar(context, "please fill data", scaffoldKey: _scaffoldKey);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Secretary()),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: new Text(
          "Add Poster",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: new IconButton(
                onPressed: publishPoster, //_writePostForAdmin,
                icon: Icon(
                  Icons.share,
                  size: 35,
                )),
          )
        ],
      ),

      // ---------------------------- start body ---------------
      // ---------------------------- start body ---------------
      // ---------------------------- start body ---------------

      body: new Container(
        child: new Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.cyan,
            ),
            child: new Container(
                child: new Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: new Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.only(left: 20, top: 3, bottom: 3),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, right: 10),
                                    child: new CircleAvatar(
                                      minRadius: 20,
                                    )),
                                Text(
                                  " Secretary ",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          padding: EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.photo_size_select_actual,
                              color: Colors.blue,
                              size: 30,
                            ),
                            onPressed: loadAssets,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //------------------------------------------- write post here
                //------------------------------------------- write post here
                //------------------------------------------- write post here
                //------------------------------------------- write post here

                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: (MediaQuery.of(context).size.height / 5) * 1,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: TextFormField(
                                controller: _postcontroller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    filled: true,
                                    hintText: "Write your Post",
                                    labelText: "Type Here"),
                                textCapitalization: TextCapitalization.words,
                                maxLines: nOfLines,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: images.length == 0
                                  ?Text("")
                                  :Container(
                                padding: EdgeInsets.all(4),
                                constraints:
                                    BoxConstraints.loose(Size.square(
                                      MediaQuery.of(context).size.width
                                    )),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child:buildGridView(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //--------------------------------- select where to share post
                //--------------------------------- select where to share post
                //--------------------------------- select where to share post
                //--------------------------------- select where to share post

                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: ExpansionTile(
                    onExpansionChanged: onExpChange,
                    backgroundColor: Colors.teal.shade50,
                    title: Text(
                      "Poster to Year!",
                      style: TextStyle(fontSize: 22),
                    ),
                    children: <Widget>[
                      _checkboxListTile("First Year", selectYear[0], year1),
                      _checkboxListTile("Second Year", selectYear[1], year2),
                      _checkboxListTile("Third Year", selectYear[2], year3),
                      _checkboxListTile("Fourth Year", selectYear[3], year4),
                    ],
                  ),
                )
              ],
            ))),
      ),
    ));
  }

  CheckboxListTile _checkboxListTile(String title, bool value, Function f) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      value: value,
      onChanged: f,
    );
  }
}
