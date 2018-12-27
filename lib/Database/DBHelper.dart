import 'dart:async';
import 'package:qr_scanner/Model/Contact.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class DBHelper{


  final String TABLE_NAME = "Contacts ";
  static Database db_instance;


  Future<Database> get db async{
    if(db_instance == null)
      db_instance = await initDB();
    return db_instance;
  }

  initDB() async {

    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,"EDMTDev.db");
    var db = await openDatabase(path,version: 1,onCreate: onCreateFunc);

  }

  void onCreateFunc(Database db,int version)async {
    await db.execute('CREATE TABLE $TABLE_NAME(result TEXT PRIMARY KEY);');


  }

  Future<List<Widget>> getResult() async{
    List<Widget> list2 = new List<Widget>();
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery('SELECT * FROM $TABLE_NAME');
    List<Contact> contacts = new List();

    for(int i=0 ;i<list.length;i++){
      Contact contact = new Contact();
      contact.result = list[i]['result'];
      list2.add(new  ListTile(
        title: Text(contact.result,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
        leading: Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),);
      contacts.add(contact);
    }
    return list2;

  }

  void addNewContact(Contact contact)async {
    var db_connection = await db;
    String query = 'INSERT INTO $TABLE_NAME(result) VALUES(\'${contact.result}\')';
    await db_connection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }


  void updateContact(Contact contact)async{
    var db_connection = await db;
    String query = 'UPDATE $TABLE_NAME SET result=${contact.result}';
    await db_connection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }


  void delectContact(Contact contact)async{
    var db_connection = await db;
    String query = 'DELECT FROM  $TABLE_NAME WHERE result=${contact.result}';
    await db_connection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }

}
