import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new LoginPage(),
      theme: new ThemeData(
          primarySwatch: Colors.blue,
      ),
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  State createState() => new loginPageState();
}
class loginPageState extends State<LoginPage>{
 

  String result = "Hey there !";
  String val = "defult";

  Future _scanQR() async {

    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;



      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";

        });
      } else {
        setState(() {
          result = "Unknown Error $ex";

        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });


    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new SecondScreen( val: result)),
    );
  }



  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("QR scanner"),
        backgroundColor: Colors.black38,
        centerTitle: true,
        brightness: Brightness.dark,

      ),

      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/demo1.jpeg"),
            fit: BoxFit.cover,
            color: Colors.white30,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/icon.jpg"),
                height:200.10,
                width: 200.10,

              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );

  }



}
class SecondScreen extends StatelessWidget {
  String val;
  SecondScreen({this.val});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Center(
        child: new Text(val),

      ),
    );
  }
}