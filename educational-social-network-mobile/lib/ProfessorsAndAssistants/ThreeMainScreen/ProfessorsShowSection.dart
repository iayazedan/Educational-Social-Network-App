import 'package:flutter/material.dart';
import 'package:unisocial/ProfessorsAndAssistants/ThreeMainScreen/ScreenshowPostHelper/SectionPostDesign.dart' as post;
import './../../ClassUsedInProject/SaveDropDownSelection/Globalstate.dart';
import 'ScreenshowPostHelper/DropDown.dart';
import '../../ClassUsedInProject/YearAndSectionId/YearAndSectionId.dart';
import '../ProfessorsAndAssistants.dart';
class Section extends StatefulWidget {
  @override
  _SectionState createState() => _SectionState();
}
class _SectionState extends State<Section> {

  GlobalState _store = GlobalState.instance;
  String mySelectedSection;
  String mySelectedYear;
  Container myContainer = new Container();

  @override
  initState(){
    mySelectedYear = _store.get('year');
    setSection();
    super.initState();
  }

  setSection(){
    if(_store.get('year')!=null){
      if(_store.get('section')!=null){
        setState(() {
          mySelectedSection=_store.get('section');

          myContainer = Container(
            color: Colors.white,
            child: post.section(getSectionsId()),
          );
        });
      }
    }else {
      setState(() {
        mySelectedSection= null;
      });
    }
  }

  List<int> getSectionsId(){

    if(mySelectedYear == null) return [0];
    else if(mySelectedYear == "First Year"){
      if(mySelectedSection == "Section 1") return [firstYearSectionsId[0]];
      else if(mySelectedSection == "Section 2") return [firstYearSectionsId[1]];
      else if(mySelectedSection == "Section 3") return [firstYearSectionsId[2]];
      else if(mySelectedSection == "Section 4") return [firstYearSectionsId[3]];
      else return [0];
    }
    else if(mySelectedYear == "Second Year"){
      if(mySelectedSection == "Section 1") return [secondYearSectionsId[0]];
      else if(mySelectedSection == "Section 2") return [secondYearSectionsId[1]];
      else if(mySelectedSection == "Section 3") return [secondYearSectionsId[2]];
      else if(mySelectedSection == "Section 4") return [secondYearSectionsId[3]];
      else return [0];
    }
    else if(mySelectedYear == "Third Year"){
      if(mySelectedSection == "Section 1") return
        [thirdYearSectionsId[0],thirdYearSectionsId[4]];
      else if(mySelectedSection == "Section 2") return
        [thirdYearSectionsId[1],thirdYearSectionsId[5]];
      else if(mySelectedSection == "Section 3") return
        [thirdYearSectionsId[2],thirdYearSectionsId[6]];
      else if(mySelectedSection == "Section 4") return
        [thirdYearSectionsId[3],thirdYearSectionsId[7]];
      else return [0];
    }
    else if(mySelectedYear == "Forth Year"){
      if(mySelectedSection == "Section 1") return
        [forthYearSectionsId[0],forthYearSectionsId[4]];
      else if(mySelectedSection == "Section 2") return
        [forthYearSectionsId[1],forthYearSectionsId[5]];
      else if(mySelectedSection == "Section 3") return
        [forthYearSectionsId[2],forthYearSectionsId[6]];
      else if(mySelectedSection == "Section 4") return
        [forthYearSectionsId[3],forthYearSectionsId[7]];
      else return [0];
    }
    else return [0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[

          new MainDropDown(
            keyValue: "section",
            mDropValue1: "Section 1",
            mDropValue2: "Section 2",
            mDropValue3: "Section 3",
            mDropValue4: "Section 4",
            myFunction: (){
              setSection();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Admin(index: 1)),
              ).whenComplete(setSection());
            },
          ),
          mySelectedYear==null?Center(child: Text("please select year first"),):
              mySelectedSection == null?Center(child: Text("please select a section"),):
          Expanded(
            child: myContainer,
          ),
        ],
      ),
    );
  }
}
