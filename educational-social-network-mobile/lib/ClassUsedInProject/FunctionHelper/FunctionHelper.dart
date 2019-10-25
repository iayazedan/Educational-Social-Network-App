import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext myContext,Function myFunction,String action){
  showDialog(
      context: myContext,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Operations Success"),
          content: new Container(
            child: Row(
              children: <Widget>[
                new Icon(Icons.check,size: 60,color: Colors.blue,),
                Flexible(child: Text(action
                  ,style: TextStyle(fontSize: 18),))
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton.icon(
                onPressed:myFunction,
                icon: new Icon(Icons.close),
                label: Text("close")
            )
          ],
        );
      }
  );
}

showInSnackBar(BuildContext context,String value,{GlobalKey<ScaffoldState> scaffoldKey}) {
  FocusScope.of(context).requestFocus(new FocusNode());
  scaffoldKey.currentState?.removeCurrentSnackBar();
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: "WorkSansSemiBold"),
    ),
    backgroundColor: Colors.black,
    duration: Duration(seconds: 3),
  ));
}