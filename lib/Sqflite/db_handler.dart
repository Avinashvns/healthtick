import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHandler {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

//     Create Database file in your mobile
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mydatabase.db");

//   open & create table in database file
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE DatabaseTable(
      id INTEGER PRIMARY KEY,
      name TEXT,
      age INTEGER
      )
      ''');
    });
    return _database!;
  }

//   Insert Data in Database Table (Static)
//   insertData() async {
//     Database? db = await database;
//     await db!.insert("DatabaseTable", {'id': 2, "name": "Abhishek", "age": 24});
//   }
//   Insert Data in Database Table (Dynamic)
  insertData(int id, String name, int age) async {
    Database? db = await database;
    Map<String,Object?>map={
      'id' : id,
      'name' : name,
      'age' : age
    };
    await db!.insert("DatabaseTable", map);
  }

// Fetch/ Read Data in Database Table
  readData()async{
    Database? db=await database;
    final data=await db!.query("DatabaseTable");
    return data;
  }

//   Delete Data in Database Table
deleteData(int id)async{
    Database? db=await database;
    await db!.delete('DatabaseTable' , where: 'id=?',whereArgs: [id]);
}
}
