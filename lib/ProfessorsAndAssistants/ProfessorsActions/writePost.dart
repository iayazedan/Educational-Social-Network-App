import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/services.dart';
import '../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/FunctionHelper/FunctionHelper.dart';
import '../../ClassUsedInProject/upload Images/Uploading images.dart';
import '../ProfessorsAndAssistants.dart';
import 'dart:async';
import 'package:custom_multi_image_picker/asset.dart';
import 'package:custom_multi_image_picker/custom_multi_image_picker.dart';
import '../../ClassUsedInProject/ClassShowImage/asset_view.dart';
import '../../ClassUsedInProject/YearAndSectionId/YearAndSectionId.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  List<Asset> images = List<Asset>();
  List imageNameInServer;

  String _error;
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
      numberOfLines = 3;
      images = resultList;
      // print(images[0].getPath) ;
      if (error == null) _error = 'No Error Dectected';
    });
  }



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _postcontroller = new TextEditingController();
  int numberOfLines = 7;

  bool F1 = false;
  bool S2 = false;
  bool T3 = false;
  bool F4 = false;

  bool TCS = false;
  bool TIS = false;
  bool FCS = false;
  bool FIS = false;

  List F1Y = [false, false, false, false];
  List S2Y = [false, false, false, false];
  List T3Y = [false, false, false, false, false, false, false, false];
  List F4Y = [false, false, false, false, false, false, false, false];
  List publicYears = [false, false, false, false];

  List getSelectedYearsAndSectionsId(){


    List<List> yearAndSectionsId = [firstYearSectionsId,secondYearSectionsId,
    thirdYearSectionsId,forthYearSectionsId,yearsId];

    List<List> tempList = [F1Y,S2Y,T3Y,F4Y,publicYears];
    List mySelectedYearSAndSectionsId = [];

    for(int i=0;i<tempList.length;i++){
      for(int j=0;j<tempList[i].length;j++){
        if(tempList[i][j]){
          mySelectedYearSAndSectionsId.add(yearAndSectionsId[i][j]);
        }
      }
    }
    debugPrint(mySelectedYearSAndSectionsId.toString());

    return mySelectedYearSAndSectionsId;
  }

  String addPoserUrl = "http://uni-social.tk/api/v1/post/addmult";

  @override
  void initState() {
    imageNameInServer = [];
    readData();
    super.initState();
  }

  @override
  void dispose() {
    _postcontroller.dispose();
    super.dispose();
  }

  Container _setContainer() {
    return new Container(
      child: Expanded(
        child: Container(
          color: Colors.grey.shade200,
          child: ListView(
            children: <Widget>[

              ExpansionTile(
                leading: Checkbox(value: F1,
                    onChanged:  (v){setState(() {
                      F1=v;
                      F1Y[0]=v;F1Y[1]=v;F1Y[2]=v;F1Y[3]=v;
                    });},
                ),
                title: new Text(
                  "First year",
                  style: TextStyle(fontSize: 18),
                ),
                children: <Widget>[
                  CheckboxListTile(
                    value: publicYears[0],
                    onChanged: (v){setState(() {
                      publicYears[0]=v;
                    });},
                    title: new Text(

                      "Public First Year",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: F1Y[0],
                    onChanged: (v){setState(() {
                      F1Y[0]=v;
                      if(F1Y[0]==F1Y[1]&&F1Y[1]==F1Y[2]&&F1Y[2]==F1Y[3]){
                        F1=v;}else if(v==false) F1=v;
                    });},
                    title: new Text(
                      "Section 1",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: F1Y[1],
                    onChanged: (v){setState(() {
                      F1Y[1]=v;
                      if(F1Y[0]==F1Y[1]&&F1Y[1]==F1Y[2]&&F1Y[2]==F1Y[3]){
                        F1=v;}else if(v==false) F1=v;
                    });},
                    title: new Text(
                      "Section 2",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: F1Y[2],
                    onChanged: (bool v) {setState(() {
                      F1Y[2]=v;
                      if(F1Y[0]==F1Y[1]&&F1Y[1]==F1Y[2]&&F1Y[2]==F1Y[3]){
                        F1=v;}else if(v==false) F1=v;
                    });},
                    title: new Text(
                      "Section 3",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: F1Y[3],
                    onChanged: (bool v) {setState(() {
                      F1Y[3]=v;
                      if(F1Y[0]==F1Y[1]&&F1Y[1]==F1Y[2]&&F1Y[2]==F1Y[3]&&F1Y[3]){
                        F1=v;}else if(v==false) F1=v;
                    });},
                    title: new Text(
                      "Section 4",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),





              ExpansionTile(
                leading: Checkbox(value: S2,
                    onChanged:(v){setState(() {
                      S2=v;
                      S2Y[0]=v;S2Y[1]=v;S2Y[2]=v;S2Y[3]=v;
                    });},
                ),
                title: new Text(
                  "Second year",
                  style: TextStyle(fontSize: 18),
                ),
                children: <Widget>[
                  CheckboxListTile(
                    value: publicYears[1],
                    onChanged: (v){setState(() {
                      publicYears[1]=v;
                    });},
                    title: new Text(
                      "Public Second Year",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: S2Y[0],
                    onChanged:(bool v) {setState(() {
                      S2Y[0]=v;
                      if(S2Y[0]==S2Y[1]&&S2Y[1]==S2Y[2]&&S2Y[2]==S2Y[3]){
                        S2=v;}else if(v==false) S2=v;
                    });},
                    title: new Text(
                      "Section 1",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: S2Y[1],
                    onChanged:(bool v) {setState(() {
                      S2Y[1]=v;
                      if(S2Y[0]==S2Y[1]&&S2Y[1]==S2Y[2]&&S2Y[2]==S2Y[3]){
                        S2=v;}else if(v==false) S2=v;
                    });},
                    title: new Text(
                      "Section 2",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: S2Y[2],
                    onChanged:(bool v) {setState(() {
                      S2Y[2]=v;
                      if(S2Y[0]==S2Y[1]&&S2Y[1]==S2Y[2]&&S2Y[2]==S2Y[3]){
                        S2=v;}else if(v==false) S2=v;
                    });},
                    title: new Text(
                      "Section 3",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    value: S2Y[3],
                    onChanged:(bool v) {setState(() {
                      S2Y[3]=v;
                      if(S2Y[0]==S2Y[1]&&S2Y[1]==S2Y[2]&&S2Y[2]==S2Y[3]){
                        S2=v;}else if(v==false) S2=v;
                    });},
                    title: new Text(
                      "Section 4",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),






              ExpansionTile(
                leading: Checkbox(value: T3,
                    onChanged: (v){setState(() {
                      T3=v;
                      TCS=v;TIS=v;T3Y[0]=v;T3Y[1]=v;T3Y[2]=v;T3Y[3]=v;
                      T3Y[4]=v;T3Y[5]=v;T3Y[6]=v;T3Y[7]=v;
                    });},
                ),
                title: new Text(
                  "Third year",
                  style: TextStyle(fontSize: 18),
                ),
                children: <Widget>[
                  CheckboxListTile(
                    value: publicYears[2],
                    onChanged: (v){setState(() {
                      publicYears[2]=v;
                    });},
                    title: new Text(
                      "Public Third Year",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  ExpansionTile(
                    leading: Checkbox(value: TCS,
                        onChanged: (v){setState(() {
                          TCS=v;
                          T3Y[0]=v;T3Y[1]=v;T3Y[2]=v;T3Y[3]=v;
                          if(TCS==TIS&&TCS==true){
                            T3=true;
                          }else T3=false;
                        });},
                    ),
                    title: new Text(
                      "CS",
                      style: TextStyle(fontSize: 18),
                    ),
                    children: <Widget>[
                      CheckboxListTile(
                        value: T3Y[0],
                        onChanged: (bool v) {setState(() {
                          T3Y[0]=v;
                          if(T3Y[0]==T3Y[1]&&T3Y[1]==T3Y[2]&&T3Y[2]==T3Y[3]){
                            TCS=v;}else if(v==false) TCS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 1",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: T3Y[1],
                        onChanged: (bool v) {setState(() {
                          T3Y[1]=v;
                          if(T3Y[0]==T3Y[1]&&T3Y[1]==T3Y[2]&&T3Y[2]==T3Y[3]){
                            TCS=v;}else if(v==false) TCS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 2",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: T3Y[2],
                        onChanged: (bool v) {setState(() {
                          T3Y[2]=v;
                          if(T3Y[0]==T3Y[1]&&T3Y[1]==T3Y[2]&&T3Y[2]==T3Y[3]){
                            TCS=v;}else if(v==false) TCS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 3",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: T3Y[3],
                        onChanged:(bool v) {setState(() {
                          T3Y[3]=v;
                          if(T3Y[0]==T3Y[1]&&T3Y[1]==T3Y[2]&&T3Y[2]==T3Y[3]){
                            TCS=v;}else if(v==false) TCS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 4",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading: Checkbox(value: TIS,
                        onChanged: (v){setState(() {
                          TIS=v;
                          T3Y[4]=v;T3Y[5]=v;T3Y[6]=v;T3Y[7]=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                    ),
                    title: new Text(
                      "IS",
                      style: TextStyle(fontSize: 18),
                    ),
                    children: <Widget>[
                      CheckboxListTile(
                        value: T3Y[4],
                        onChanged:(bool v) {setState(() {
                          T3Y[4]=v;
                          if(T3Y[4]==T3Y[5]&&T3Y[5]==T3Y[6]&&T3Y[6]==T3Y[7]){
                            TIS=v;}else if(v==false) TIS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 1",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: T3Y[5],
                        onChanged:(bool v) {setState(() {
                          T3Y[5]=v;
                          if(T3Y[4]==T3Y[5]&&T3Y[5]==T3Y[6]&&T3Y[6]==T3Y[7]){
                            TIS=v;}else if(v==false) TIS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 2",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: T3Y[6],
                        onChanged:(bool v) {setState(() {
                          T3Y[6]=v;
                          if(T3Y[4]==T3Y[5]&&T3Y[5]==T3Y[6]&&T3Y[6]==T3Y[7]){
                            TIS=v;}else if(v==false) TIS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 3",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: T3Y[7],
                        onChanged:(bool v) {setState(() {
                          T3Y[7]=v;
                          if(T3Y[4]==T3Y[5]&&T3Y[5]==T3Y[6]&&T3Y[6]==T3Y[7]){
                            TIS=v;}else if(v==false) TIS=v;
                          if(TCS==TIS) T3=TCS;
                          else T3=false;
                        });},
                        title: new Text(
                          "Section 4",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                ],
              ),






              ExpansionTile(
                leading: Checkbox(value: F4,
                  onChanged: (v){setState(() {
                    F4=v;
                    FCS=v;FIS=v;F4Y[0]=v;F4Y[1]=v;F4Y[2]=v;F4Y[3]=v;
                    F4Y[4]=v;F4Y[5]=v;F4Y[6]=v;F4Y[7]=v;
                  });},
                ),
                title: new Text(
                  "Forth year",
                  style: TextStyle(fontSize: 18),
                ),
                children: <Widget>[
                  CheckboxListTile(
                    value: publicYears[3],
                    onChanged: (v){setState(() {
                      publicYears[3]=v;
                    });},
                    title: new Text(
                      "Public Fourth Year",
                      style: TextStyle(fontSize: 16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  ExpansionTile(
                    leading: Checkbox(value: FCS,
                      onChanged: (v){setState(() {
                        FCS=v;
                        F4Y[0]=v;F4Y[1]=v;F4Y[2]=v;F4Y[3]=v;
                        if(FCS==FIS&&FCS==true){
                          F4=true;
                        }else F4=false;
                      });},
                    ),
                    title: new Text(
                      "CS",
                      style: TextStyle(fontSize: 18),
                    ),
                    children: <Widget>[
                      CheckboxListTile(
                        value: F4Y[0],
                        onChanged: (bool v) {setState(() {
                          F4Y[0]=v;
                          if(F4Y[0]==F4Y[1]&&F4Y[1]==F4Y[2]&&F4Y[2]==F4Y[3]){
                            FCS=v;}else if(v==false) FCS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 1",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: F4Y[1],
                        onChanged:(bool v) {setState(() {
                          F4Y[1]=v;
                          if(F4Y[0]==F4Y[1]&&F4Y[1]==F4Y[2]&&F4Y[2]==F4Y[3]){
                            FCS=v;}else if(v==false) FCS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 2",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: F4Y[2],
                        onChanged: (bool v) {setState(() {
                          F4Y[2]=v;
                          if(F4Y[0]==F4Y[1]&&F4Y[1]==F4Y[2]&&F4Y[2]==F4Y[3]){
                            FCS=v;}else if(v==false) FCS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 3",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: F4Y[3],
                        onChanged:(bool v) {setState(() {
                          F4Y[3]=v;
                          if(F4Y[0]==F4Y[1]&&F4Y[1]==F4Y[2]&&F4Y[2]==F4Y[3]){
                            FCS=v;}else if(v==false) FCS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 4",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading: Checkbox(value: FIS,
                      onChanged:  (v){setState(() {
                        FIS=v;
                        F4Y[4]=v;F4Y[5]=v;F4Y[6]=v;F4Y[7]=v;
                        if(FCS==FIS&&FCS==true){
                          F4=true;
                        }else F4=false;
                      });},

                    ),
                    title: new Text(
                      "IS",
                      style: TextStyle(fontSize: 18),
                    ),
                    children: <Widget>[
                      CheckboxListTile(
                        value: F4Y[4],
                        onChanged: (bool v) {setState(() {
                          F4Y[4]=v;
                          if(F4Y[4]==F4Y[5]&&F4Y[5]==F4Y[6]&&F4Y[6]==F4Y[7]){
                            FIS=v;}else if(v==false) FIS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 1",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: F4Y[5],
                        onChanged: (bool v) {setState(() {
                          F4Y[5]=v;
                          if(F4Y[4]==F4Y[5]&&F4Y[5]==F4Y[6]&&F4Y[6]==F4Y[7]){
                            FIS=v;}else if(v==false) FIS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 2",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: F4Y[6],
                        onChanged: (bool v) {setState(() {
                          F4Y[6]=v;
                          if(F4Y[4]==F4Y[5]&&F4Y[5]==F4Y[6]&&F4Y[6]==F4Y[7]){
                            FIS=v;}else if(v==false) FIS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 3",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: F4Y[7],
                        onChanged:(bool v) {setState(() {
                          F4Y[7]=v;
                          if(F4Y[4]==F4Y[5]&&F4Y[5]==F4Y[6]&&F4Y[6]==F4Y[7]){
                            FIS=v;}else if(v==false) FIS=v;
                          if(FCS==FIS) F4=FCS;
                          else F4=false;
                        });},
                        title: new Text(
                          "Section 4",
                          style: TextStyle(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future publishPost()async{

    if((_postcontroller.text.isNotEmpty || images.length != 0) &&
        (F1Y[0] || F1Y[1] || F1Y[2] || F1Y[3] || S2Y[0] || S2Y[1] || S2Y[2]
            || S2Y[3] || T3Y[0] || T3Y[1] || T3Y[2] || T3Y[3] || T3Y[4] || T3Y[5]
            || T3Y[6] || T3Y[7] || F4Y[0]|| F4Y[1]|| F4Y[2]|| F4Y[3]|| F4Y[4]||
            F4Y[5]|| F4Y[6]|| F4Y[7] || publicYears[0] || publicYears[1] ||
            publicYears[2] || publicYears[3])){
      if (images.length != 0) {
        showInSnackBar(context, "uploading image ...", scaffoldKey: _scaffoldKey);
        imageNameInServer = await uploadingImages(images);
        //debugPrint(json.encode(imageNameInServer));
      }
      var response =await http.post(addPoserUrl,body:{
        "content": _postcontroller.text,
        "user_id":userId,
        "status":"1",
        "image": imageNameInServer.length>0?json.encode(imageNameInServer):"[]",
        "yearandsection_id":json.encode(getSelectedYearsAndSectionsId()),//json.encode(getYearAndSectionIdSelected),
      });
      if (response.statusCode == 200)
        showSuccessDialog(context, () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Admin()));
        }, "Post is puplished");
    }else {
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
                onTap: (){
                  Navigator.of(context).pushNamed("/Staff");

                },
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: new Text("Publish Post",style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: new IconButton(
                      onPressed: publishPost,
                      icon: Icon(
                        Icons.share,

                      )),
                )
              ],
            ),

            // ---------------------------- start body ---------------

            body: new Container(
              child: new Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.cyan,
                  ),
                  child: new Container(
                      child: new Column(
                    children: <Widget>[
                      new Container(
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
                                        padding: EdgeInsets.only(top:4,left:4,bottom:4),
                                        child: new CircleAvatar(
                                          minRadius: 20,
                                        )),
                                    Text(
                                      " Admin ",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.only(right: 10),
                                child:InkWell(
                                  onTap: loadAssets,
                                  child: Icon(
                                    Icons.photo_size_select_actual,
                                    color: Colors.blue, size: 30,),
                                )
                            )
                          ],
                        ),
                      ),

                      //------------------------------------------- write post here

                      Expanded(
                        child: new Container(
                          color: Colors.white10,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _postcontroller,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      filled: true,
                                      hintText: "Write your Post",
                                      labelText: "Type Here"),
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: numberOfLines,
                                  keyboardType: TextInputType.text,
                                  style:
                                      TextStyle(fontSize: 18, color: Colors.black),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      //show image
                      Container(
                        child: images.length==0?null :
                        Container(
                          height: 150,
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
                      //--------------------------------- select where to share post
                      _setContainer(),
                    ],
                  ))),
            ))
    );
  }
}
