import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
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
