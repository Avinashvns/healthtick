import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:healthtick/Sqflite/db_handler.dart';
import 'package:healthtick/Sqflite/db_handler_vendordj.dart';
import 'package:healthtick/api/apicaller.dart';
import 'package:healthtick/model/book_model.dart';
import 'package:healthtick/model/user_model.dart';
import 'package:healthtick/model/vendor_dj_model.dart';
import 'package:healthtick/secondscreen.dart';
import 'package:healthtick/user_home_menu.dart';
import 'package:healthtick/user_screen.dart';
import 'package:healthtick/utilities/custom.dart';

import 'package:healthtick/model/vendor_dj_model.dart' as vendor_dj_model;
import 'package:healthtick/model/book_model.dart' as book_model;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // use Animated Splash Screen
    home: AnimatedSplashScreen(
      splash: Text("Health Tick"),
      nextScreen: MainScreen(),
      backgroundColor: bgcolor,
      splashTransition: SplashTransition.rotationTransition,
    ),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String name='hi';
  Color data=Colors.red;
  TextEditingController nameController= TextEditingController();
  TextEditingController ageController= TextEditingController();

  @override
  void initState(){
    super.initState();
    print("Avi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HEALTH TICK",
          style: TextStyle(
              fontSize: 30,
              color: Colors.white38,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: bgcolor,
        centerTitle: true,
      ),
      backgroundColor: bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$name',style: TextStyle(color: Colors.white),),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter your name",
                  labelText: "Name"
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your age",
                    labelText: "Age"
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: data,
              ),
              ElevatedButton(child: Text("Insert"),
              onPressed: ()async{
                String sitename="surevih.in";
                String path = "/api/vendor";
                // String sitename="gist.githubusercontent.com";
                // String path="/Avinashvns/749bdbee6d1d5b4f7e53d3544b63f50c/raw/5566355bd4211b0fcbc29f9f3546f60a3ac7f89b/sqlitebook.json";
                Map<String,String> map=Map();
                final res= await ApiCaller.getApi(sitename, path, map);
                print("Res ${res['result']}");

                List<dynamic> results = res['result'] as List<dynamic>;

                // BookModel bookModel = BookModel.fromJson({
                //   "result": results,
                //   "status": "ok",
                // });
                VendorDjModel  vendorDjModel= VendorDjModel.fromJson({
                  "result": results,
                  "status": "ok"
                });

// Iterate over the result list and insert each book into the database
//                 for (Result result in bookModel.result) {
                for (vendor_dj_model.Result result in vendorDjModel.result) {
                  // await DbHandler().insertBook(result);
                  // List<Result> existingRecords = await DbHandler().readBook();
                  // bool recordExists = existingRecords.any((element) => element.id == result.id);
                  List<vendor_dj_model.Result> existingRecords = await DbHandler().readVendorDj();
                  bool recordExists = existingRecords.any((element) => element.id == result.id);

                  if (recordExists) {
                    // Update the existing record
                    // await DbHandler().updateBook(result);
                    await DbHandler().updateVendorDj(result);
                    print("Record with ID ${result.id} updated");
                  } else {
                    // Insert the new record
                    // await DbHandler().insertBook(result);
                    await DbHandler().insertVendorDj(result);
                    print("Record with ID ${result.id} inserted");
                  }
                }
                print("Inserted");
                print(nameController.text + ageController.text);

              },),
              ElevatedButton(child: Text("Read/Fetch"),
                onPressed: ()async{
                  // final data=await DbHandler().readData();
                  final data=await DbHandler().readBook();
                  print("Fetch");
                  print(data);

                },),
              ElevatedButton(child: Text("Delete"),
                onPressed: ()async{
                  final data=await DbHandler().deleteData(4);
                  print("Delete");
                },),
              // ElevatedButton(child: Text("Update"),
              //   onPressed: ()async{
              //     final data=await DbHandler().updateData(
              //       //   {
              //       // 'id' : 3,
              //       // 'name' : "Anuradha",
              //       // 'age': 46
              //       //   }
              //       UserModel(
              //           name: nameController.text,
              //           age: int.parse(ageController.text),
              //       )
              //     );
              //     print("Updated");
              //   },),
          
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: btcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10),
                  child: Text(
                    "WELCOME",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    print("Clicked");
                    setState(() {
                      name="Avinash";
                      data=Colors.yellow;
                    });
                    print(name);
                    print(data);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const SecondScreen()));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHomeMenu()));
                  },
                ),
          
              ),
            ],
          ),
        ),
      ),
    );
  }
}
