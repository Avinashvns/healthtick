import 'package:flutter/material.dart';
import 'package:healthtick/myviewtesting.dart';
import 'package:healthtick/utilities/custom.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final controller = PageController();
  bool myswitch = true;
  bool newwidget= false;
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        3,
        (index) => Container(
              child: Column(
                children: [
                  Text(
                    "Time to eat mindfully",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                        child: Text(
                          "It`s simple : at slowly for ten minutes, rest for five, then finish your meal ",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white38,
                              fontWeight: FontWeight.w600),
                        ),
                    ),
                ],
              ),
            )
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mindful Meal Timer",
          style: TextStyle(
              fontSize: 30, color: Colors.white38, fontWeight: FontWeight.w600),
        ),
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: bgcolor,
      ),
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: const WormEffect(
                dotHeight: 16,
                dotWidth: 16,
                type: WormType.thinUnderground,
              ),
            ),
            SizedBox(
                height: 100,
                child: PageView.builder(
                    controller: controller,
                    itemBuilder: (_ , index) {
                      return pages[index % pages.length];
                    })),

            // Image
            Container(
              child: Image(
                image: AssetImage("assets/watch.png"),
              ),
              alignment: Alignment.center,
            ),

            // Switch
            Switch(
                value: myswitch,
                activeColor: Colors.green,
                onChanged: (bool value){
                  setState(() {
                    myswitch=value;
                  });
                }),
            Text(
              "Sound On",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            // Button
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
                  "START",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  print("Start");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyPageView()));
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
