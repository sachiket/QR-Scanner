import 'package:flutter/material.dart';
import 'main.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:qr_scanner/Database/DBHelper.dart';





//class TextStorage {
  //Future<String> get _localPath async {
    //final directory = await getApplicationDocumentsDirectory();
    //return directory.path;
  //}

  //Future<File> get _localFile async {
    //final path = await _localPath;
    //return File('$path/demo.txt');
  //}

  //Future<String> readFile() async {
   // try {

     // final file = await _localFile;

      //String content = await file.readAsString();
     // return content;
    //} catch (e) {
    //  return '';
   // }
//  }

 // Future<File> writeFile(String text) async {
    //final file = await _localFile;
   // return file.writeAsString('$text\r\n', mode: FileMode.append);
 // }

  //Future<File> cleanFile() async {
    //final file = await _localFile;
    //return file.writeAsString('');
  //}
//}


class screen3 extends StatefulWidget {
  String val;
  //final TextStorage storage;

  //screen3({Key key, @required this.storage , this.val}) : super(key: key);
  @override
  State createState() => new state();
}


class state extends State<screen3>{
  List<Widget> list = new List<Widget>();
  List<Widget> list2 = new List<Widget>();




  Future<List<Widget>> getContactsFromDB() async{
    //List<Contact> contacts2 = new List();
    var dbHelper = DBHelper();
    Future<List<Widget>> contacts = dbHelper.getResult();
    list = await contacts;
    return list;

  }

  //TextEditingController _textField = new TextEditingController();
  String _content = '';


  @override
  void initState()async{

    list = await getContactsFromDB();
    //list.add(new  ListTile(
      //title: Text(widget.val,
        //  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
      //leading: Icon(
        //Icons.theaters,
        //color: Colors.blue[500],
      //),
    //),);



    //widget.storage.readFile().then((String val) {
      //setState(() {
        //_content = val;
      //});
    //});
    //_writeStringToTextFile(widget.val);
   // super.initState();
  }

 //Future<File> _writeStringToTextFile(String text) async {
    //setState(() {
      //_content += text + '\r\n';
    //});

    //return widget.storage.writeFile(_content);
  //}
  //Future<File> _clearContentsInTextFile() async {
   // setState(() {
     // _content = '';
    //});

    //return widget.storage.cleanFile();
  //}


  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   LoginPage()));

    } , child: Scaffold(
      appBar: AppBar(
        title: Text("history"),
        // Removing the drop shadow cast by the app bar.
      ),
      body: Center(
            child:new  ListView(
              children: list,

        ),
      )


    )

      , );

  }

}