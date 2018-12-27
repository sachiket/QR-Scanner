import 'package:flutter/material.dart';
import 'main.dart';



class SecondScreen extends StatelessWidget {
  String val;
  SecondScreen({this.val});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){
      Navigator.pop(context,true);
    } ,child:Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Center(
        child: new Text(val),

      ),
    ),);
  }
}
