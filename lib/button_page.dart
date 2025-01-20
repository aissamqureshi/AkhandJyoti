import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

// class _CountdownScreenState extends State<CountdownScreen> {
//   Duration remainingTime = Duration(hours: 24);
//   bool isButtonPressed = false;
//   Timer? timer;
//   int currentImageIndex = 0;
//   bool showDefaultImage = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTimerState();
//   }
//
//   Future<void> _loadTimerState() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedRemainingTime = prefs.getInt('remainingTime') ?? 24 * 60 * 60 * 1000;
//     final timerStarted = prefs.getBool('isTimerRunning') ?? false;
//
//     setState(() {
//       remainingTime = Duration(milliseconds: savedRemainingTime);
//       isButtonPressed = timerStarted;
//       showDefaultImage = !timerStarted;
//     });
//
//     if (timerStarted) {
//       startTimer(resume: true);
//     }
//   }
//
//   Future<void> _saveTimerState() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('remainingTime', remainingTime.inMilliseconds);
//     await prefs.setBool('isTimerRunning', isButtonPressed);
//   }
//
//   void startTimer({bool resume = false}) {
//     if (!resume) {
//       remainingTime = Duration(hours: 24);
//       currentImageIndex = 1;
//       showDefaultImage = false;
//     }
//
//     setState(() {
//       isButtonPressed = true;
//     });
//
//     timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
//       setState(() {
//         if (remainingTime > Duration.zero) {
//           remainingTime -= Duration(milliseconds: 100);
//           updateImageIndex();
//         } else {
//           timer.cancel();
//           isButtonPressed = false;
//         }
//       });
//       await _saveTimerState();
//     });
//   }
//
//   void stopTimer() async {
//     if (timer != null) {
//       timer!.cancel();
//     }
//     setState(() {
//       isButtonPressed = false;
//       showDefaultImage = true;
//       currentImageIndex = 0;
//     });
//     await _saveTimerState();
//   }
//
//   void updateImageIndex() {
//     int hoursElapsed = 24 - remainingTime.inHours;
//     if (hoursElapsed < 6) {
//       currentImageIndex = 1;
//     } else if (hoursElapsed < 12) {
//       currentImageIndex = 2;
//     } else if (hoursElapsed < 18) {
//       currentImageIndex = 3;
//     } else if (hoursElapsed == 18) {
//       currentImageIndex = 4;
//     } else if (hoursElapsed == 19) {
//       currentImageIndex = 5;
//     } else if (hoursElapsed == 20) {
//       currentImageIndex = 6;
//     } else if (hoursElapsed == 21) {
//       currentImageIndex = 7;
//     } else if (hoursElapsed == 22) {
//       currentImageIndex = 8;
//     } else if (hoursElapsed == 23) {
//       currentImageIndex = 9;
//     }
//   }
//
//   String getImageForCurrentIndex() {
//     if (showDefaultImage) {
//       return 'assets/images/Diya.png'; // Replace with actual default image path.
//     }
//     return 'assets/images/diya_animation_$currentImageIndex.gif'; // Replace with actual image paths.
//   }
//
//   String formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String hours = twoDigits(duration.inHours);
//     String minutes = twoDigits(duration.inMinutes.remainder(60));
//     String seconds = twoDigits(duration.inSeconds.remainder(60));
//     String milliseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);
//     return "$hours:$minutes:$seconds.$milliseconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("24-Hour Timer"),
//         backgroundColor: Colors.orange,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (isButtonPressed)
//               Column(
//                 children: [
//                   Image.asset(
//                     getImageForCurrentIndex(),
//                     height: 200,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     formatDuration(remainingTime),
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               )
//             else
//               Image.asset("assets/images/Diya.png", height: 100),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: isButtonPressed
//                   ? null
//                   : () {
//                 startTimer();
//               },
//               child: Text("Start Timer"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: stopTimer,
//               child: Text("Stop Timer"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     if (timer != null) {
//       timer!.cancel();
//     }
//     super.dispose();
//   }
// }

class _CountdownScreenState extends State<CountdownScreen> {
  bool isButtonPressed = false;
  static const Duration totalTime = Duration(seconds: 10); // Total time: 24 hours
  Duration remainingTime = totalTime; // Remaining time: starts at 24 hours
  Timer? timer;

  void startTimer() {
    setState(() {
      isButtonPressed = true; // Set button pressed state
    });

    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (remainingTime > Duration.zero) {
        setState(() {
          remainingTime -= Duration(seconds: 1); // Decrement remaining time
        });
      } else {
        timer.cancel();
        setState(() {
          isButtonPressed = false; // Reset button state when timer ends
        });
      }
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() {
      isButtonPressed = false;
      remainingTime = totalTime; // Reset the timer to the initial value
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = remainingTime.inSeconds / totalTime.inSeconds; // Calculate progress
    Color startColor = Colors.green;
    Color endColor = Colors.red;

    // Interpolate colors based on progress
    Color currentColor = Color.lerp(endColor, startColor, progress)!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Countdown Timer"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Remaining: ${formatDuration(remainingTime)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 380,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white, // Background for progress bar
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 15,
                      valueColor: AlwaysStoppedAnimation<Color>(currentColor),
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 40),
            ElevatedButton(
              onPressed: isButtonPressed ? null : startTimer,
              child: Text("Start Timer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: stopTimer,
              child: Text("Stop Timer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



