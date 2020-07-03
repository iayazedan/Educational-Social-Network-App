import 'package:flutter/material.dart';
import '../ThreeMainScreen/ScreenshowPostHelper/YearPostDesign.dart' as post;
import 'ScreenshowPostHelper/DropDown.dart';
import './../../ClassUsedInProject/SaveDropDownSelection/Globalstate.dart';
import '../../ClassUsedInProject/YearAndSectionId/YearAndSectionId.dart';


class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {

  GlobalState _store = GlobalState.instance;
  String mySelectedYear;
  Container myContainer = new Container();


  @override
  initState(){
    setYear();
    super.initState();
  }

  setYear(){
    if(_store.get('year')!=null){
      setState(() {
        mySelectedYear=_store.get('year');

        myContainer = Container(
          padding: EdgeInsets.only(left: 2.0, right: 2.0),
          color: Colors.white,
          child: post.year(getYearId().toString())
        );
      });
    }
  }

  int getYearId(){
    if(mySelectedYear == null) return yearsId[0];
    else if(mySelectedYear == "First Year") return yearsId[0];
    else if(mySelectedYear == "Second Year") return yearsId[1];
    else if(mySelectedYear == "Third Year") return yearsId[2];
    else if(mySelectedYear == "Forth Year") return yearsId[3];
    else return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[

          new MainDropDown(
            keyValue: "year",
            mDropValue1: "First Year",
            mDropValue2: "Second Year",
            mDropValue3: "Third Year",
            mDropValue4: "Forth Year",
            myFunction:(){
              setYear();
              Navigator.pushNamed(context, '/adminyears').whenComplete(setYear());
            },
          ),

          mySelectedYear==null?Center(child: Text("please select year"),):
          Expanded(
            child: myContainer,
          ),
        ],
      ),
    );
  }
}
