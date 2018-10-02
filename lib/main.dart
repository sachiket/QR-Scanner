import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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




void history()
{

  List<String> his= new  List(10);
  his.add(result);
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => new screen3(val:his)),
);}
  picker() {

      ImagePicker.pickImage(source: ImageSource.gallery);
    }


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(icon:new Icon(Icons.photo_album), onPressed: picker),
          new IconButton(icon:new Icon(Icons.history), onPressed: history)
        ],
        title: new Text("QR scanner"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        //brightness: Brightness.dark,

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
class screen3 extends StatelessWidget {

  List<String> val=new List(10);
  screen3({this.val});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("history"),
         // Removing the drop shadow cast by the app bar.
      ),
      body: new ListView.builder(
        itemCount: val.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(val[index]);
        }

      ),
    );
  }
}
