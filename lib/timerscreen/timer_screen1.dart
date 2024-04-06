import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthtick/utilities/custom.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerScreen1 extends StatefulWidget {
  TimerScreen1({super.key});

  @override
  State<TimerScreen1> createState() => _TimerScreen1State();
}

class _TimerScreen1State extends State<TimerScreen1> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  bool myswitch = true;

  // Timer
  late Timer _timer;
  int _secondsRemaining = 30;

  // Audio
  final AudioPlayer ap = AudioPlayer();
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    isPlaying == true ? _startTimer() : _pauseTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
          if (_secondsRemaining <= 5 && myswitch) {
            print("5");
            ap.play(AssetSource('countdown_tick.mp3'));
          }
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _pauseTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "Nom nom:)",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "You have 10 minutes to eat before the pause. ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white38,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Focus on eating slowly ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white38,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: 1 - (_secondsRemaining / 30),
                strokeWidth: 10,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Time Remaining: $_secondsRemaining seconds',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),

            // Switch
            Switch(
                value: myswitch,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  setState(() {
                    myswitch = value;
                    print(value);
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
                  child: isPlaying
                      ? Text(
                    "PAUSE",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  )
                      : Text(
                    "RESUME",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    print("Clicked");
                    isPlaying = !isPlaying;
                    setState(() {
                      isPlaying == true ? _startTimer() : _pauseTimer();
                    });
                  }),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: bgcolor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10),
                child: Text(
                  "LET`S STOP I`M FULL NOW",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  print("Stoped");
                  _timer.cancel();
                },
              ),
            ),
          ],
        ),
    );
  }
}
