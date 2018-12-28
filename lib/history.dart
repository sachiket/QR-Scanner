import 'package:flutter/material.dart';
  import 'main.dart';
  import 'dart:async';
  import 'package:qr_scanner/Database/DBHelper.dart';
  import 'package:qr_scanner/Model/Contact.dart';


  Future<List<Contact>> getContactsFromDB() async{
    var dbHelper = DBHelper();
    Future<List<Contact>> contacts = dbHelper.getResult();
    return contacts;

  }

  final controller_result = new TextEditingController();

  class screen3 extends StatefulWidget {
    @override
    State createState() => new state();
  }


  class state extends State<screen3>{



    @override


    Widget build(BuildContext context) {
      return WillPopScope(onWillPop: (){

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>   LoginPage()));

      } , child: Scaffold(
        appBar: AppBar(
          title: Text("history"),
          actions: <Widget>[

          ],
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<Contact>>(
              future: getContactsFromDB(),
              builder: (context,snapshot){
                if(snapshot.data !=null){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data.length ,
                        itemBuilder: (context,index){
                          return new Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom:16.0),
                                    child: Text(
                                      snapshot.data[index].result,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],),
                              ),

                            ],
                          );

                    });
                  }


                }
                return new Container(
                  alignment: AlignmentDirectional.center,
                  child: new CircularProgressIndicator(),
                );
              }



          ),
        )


      )

        , );



    }

    @override
    void initState() {
      super.initState();
    }


  }
