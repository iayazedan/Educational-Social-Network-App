import 'package:flutter/material.dart';
import './../../../ClassUsedInProject/SaveDropDownSelection/Globalstate.dart';

class ClassSelection {
  const ClassSelection(this.name);
  final String name;
}

class MainDropDown extends StatefulWidget {


  String mDropValue1,mDropValue2,mDropValue3,mDropValue4,keyValue;
  Function myFunction;
  MainDropDown({this.mDropValue1,this.mDropValue2,this.mDropValue3,
    this.mDropValue4,this.keyValue,this.myFunction});

  @override
  _MainDropDownState createState() => _MainDropDownState(
      mDropValue1,mDropValue2,mDropValue3,mDropValue4,keyValue,myFunction);
}

GlobalState _store = GlobalState.instance;

class _MainDropDownState extends State<MainDropDown> {

  String keyValue;
  String dropValue1,dropValue2,dropValue3,dropValue4;
  Function myFunction;
  _MainDropDownState(this.dropValue1,this.dropValue2,this.dropValue3,
      this.dropValue4,this.keyValue,this.myFunction);


  ClassSelection selectedSection;
  List<ClassSelection> sections;
  String mySelectedYear;

  @override
  void initState() {

    sections = <ClassSelection>[
      ClassSelection(dropValue1),
      ClassSelection(dropValue2),
      ClassSelection(dropValue3),
      ClassSelection(dropValue4),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 50,
              child: new DropdownButton<String>(
                isExpanded: true,
                iconSize: 26,
                hint: new Text("Select ${keyValue}"),
                value: _store.get(keyValue),
                onChanged: (String newValue) {
                  setState(() {
                    _store.set(keyValue, newValue);
                  });
                  myFunction();
                },
                items: [
                  DropdownMenuItem(
                      value: dropValue1,
                      child: Center(child: Text(dropValue1, style: TextStyle(
                          fontSize: 15.0, color: Colors.black87),))
                  ),
                  DropdownMenuItem(
                      value: dropValue2,
                      child: Center(child: Text(dropValue2, style: TextStyle(
                          fontSize: 15.0, color: Colors.black87),))
                  ),
                  DropdownMenuItem(
                      value: dropValue3,
                      child: Center(child: Text(dropValue3, style: TextStyle(
                          fontSize: 15.0, color: Colors.black87),))
                  ),
                  DropdownMenuItem(
                      value: dropValue4,
                      child: Center(child: Text(dropValue4, style: TextStyle(
                          fontSize: 15.0, color: Colors.black87),))
                  ),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
