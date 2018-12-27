import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'history.dart';
import 'result.dart';
import 'package:qr_scanner/Model/Contact.dart';
import 'package:qr_scanner/Database/DBHelper.dart';

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new LoginPage(),
      theme: new ThemeData(
        primarySwatch: Colors.blue ,
      ),
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  State createState() => new loginPageState();
}

class loginPageState extends State<LoginPage>{
  Contact contact = new Contact();
  String ans ;
  String result = "Hey there !";
  String val = "defult";
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final key = new GlobalKey();

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
    this.ans=result;
    submitcontact();
    Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => new SecondScreen(val: result)
      ),
    ).then((bool value){
        if(value){
           screen3();//storage: null , val: result );
        }

    });
  }

  void submitcontact(){
    var contact = Contact();
    contact.result=ans;
    var dbHelper = DBHelper();
    dbHelper.addNewContact(contact);


    return;

  }

  @override

  Widget build(BuildContext context) {

    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blueAccent
              ),
            ),
            ListTile(
              title: Text('History'),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screen3()
                  ),
                );
              },

            ),
          ],
        ),
      ),
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
        key: key,
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );

  }



}
