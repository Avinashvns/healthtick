import 'package:flutter/material.dart';
import 'package:healthtick/timerscreen/timer_screen1.dart';
import 'package:healthtick/timerscreen/timer_screen2.dart';
import 'package:healthtick/timerscreen/timer_screen3.dart';
import 'package:healthtick/utilities/custom.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Container(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              TimerScreen1(),
              TimerScreen2(),
              TimerScreen3(),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.purple,
                  ),
                  onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                  ),
                ),
              ),
            ),
    );
  }
}
