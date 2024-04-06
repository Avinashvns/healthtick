import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:healthtick/Sqflite/db_handler.dart';
import 'package:healthtick/model/user_model.dart';
import 'package:healthtick/secondscreen.dart';
import 'package:healthtick/utilities/custom.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$name',style: TextStyle(color: Colors.white),),
            CircleAvatar(
              radius: 50,
              backgroundColor: data,
            ),
            ElevatedButton(child: Text("Insert"),
            onPressed: ()async{
              // await DbHandler().insertData(3, "Shesha", 22);
              await DbHandler().insertData(UserModel(
                  id: 5,
                  name: "Radhe",
                  age: 23
              )
              );
              print("Inserted");

            },),
            ElevatedButton(child: Text("Read/Fetch"),
              onPressed: ()async{
                final data=await DbHandler().readData();
                print("Fetch");
                print(data);
                print(data[0].id);

              },),
            ElevatedButton(child: Text("Delete"),
              onPressed: ()async{
                final data=await DbHandler().deleteData(4);
                print("Delete");
              },),
            ElevatedButton(child: Text("Update"),
              onPressed: ()async{
                final data=await DbHandler().updateData(3, {
                  'id' : 3,
                  'name' : "Anuradha",
                  'age': 46
                });
                print("Updated");
              },),

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
                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}
