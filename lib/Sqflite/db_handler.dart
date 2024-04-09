import 'dart:convert';
import 'dart:io';


import 'package:healthtick/model/user_model.dart';
import 'package:healthtick/model/vendor_dj_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:healthtick/model/vendor_dj_model.dart' as vendor_dj_model;
import 'package:healthtick/model/book_model.dart' as book_model;

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
      db.execute('''
      CREATE TABLE Bt(
      id INTEGER PRIMARY KEY,
      book TEXT,
      price INTEGER
      )
      ''');
      db.execute('''
      CREATE TABLE vendor_dj (
        id INTEGER PRIMARY KEY,
        site_user_id INTERGER,
        profile_id INTEGER,
        dj_name TEXT,
        vendor_name TEXT,
        package INTEGER,
        locality TEXT,
        city TEXT,
        state TEXT,
        pincode TEXT,
        rating INTEGER,
        experience TEXT,
        cover_image TEXT,
        images TEXT,
        status TEXT,
        remark TEXT,
        updated_date TEXT,
        creation_date TEXT
      )
    ''');
    });
    return _database!;
  }

//   Insert Data with help User Model Class
  insertData(UserModel userModel) async {
    Database? db = await database;
    await db!.insert('DatabaseTable', userModel.toJson());
  }
// Fetch/ Read Data in Database Table
  Future<List<UserModel>>readData() async {
    Database? db = await database;
    final data = await db!.query("DatabaseTable");
    // return data;
    //   With model
    return data.map((map) => UserModel.fromMap(map)).toList();
  }
//   Delete Data in Database Table
deleteData(int id)async{
    Database? db=await database;
    await db!.delete('DatabaseTable' , where: 'id=?',whereArgs: [id]);
}

//   Update Data in Database Table
  updateData(UserModel userModel) async {
    Database? db = await database;
    await db!.update(
        'DatabaseTable',
        where: 'id=?',
        whereArgs: [userModel.id],
        userModel.toJson());
  }

  // Future<void> insertBook(Result result) async {
  //
  //   Database? db = await database;
  //   await db!.insert(
  //       "Bt",
  //       result.toJson()
  //   );
  // }
  // Future<void> insertBook2(Result result2) async {
  //   Database? db = await database;
  //   await db!.insert(
  //       "Bt2",
  //       result2.toJson()
  //   );
  // }
  insertBook(book_model.Result book) async {
    Database? db = await database;
    return await db!.insert('Bt', book.toJson());
  }

  Future<List<book_model.Result>> readBook() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db!.query("Bt");
    return List.generate(maps.length, (i) {
      // return
      //     book_model.Result(
      //       id: maps[i]['id'],
      //       book: maps[i]['book'],
      //       price: maps[i]['price'],
      // );
      return book_model.Result.fromJson(maps[i]);
    });
  }
  Future<void> updateBook(book_model.Result result) async {
    Database? db = await database;
    await db!.update(
      'Bt',
      result.toJson(),
      where: 'id = ?',
      whereArgs: [result.id],
    );
  }

//  Vendor dj Model

  insertVendorDj(vendor_dj_model.Result vendorDj) async {
    Database? db = await database;
    return await db!.insert('vendor_dj', vendorDj.toJson());
  }

  Future<List<vendor_dj_model.Result>> readVendorDj() async{
    Database? db= await database;
    List<Map<String,dynamic>> maps= await db!.query("vendor_dj");
    return List.generate(maps.length, (i){
      return vendor_dj_model.Result.fromJson(maps[i]);
    });
  }
  Future<void> updateVendorDj(vendor_dj_model.Result result) async {
    Database? db = await database;
    await db!.update(
      'Bt',
      result.toJson(),
      where: 'id = ?',
      whereArgs: [result.id],
    );
  }

}
