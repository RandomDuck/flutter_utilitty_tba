import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, required this.title});

  final String title;

  @override
  State<TimerPage> createState() => _TimerState();
}

class _TimerState extends State<TimerPage> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(hours: 0, minutes: 0, seconds: 0);
  var hoursController = TextEditingController();
  var minutesController = TextEditingController();
  var secondsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    hoursController.addListener(setTimer);
    minutesController.addListener(setTimer);
    secondsController.addListener(setTimer);
  }

  @override
  void dispose() {
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    super.dispose();
  }

  /// Timer related methods ///
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    if (countdownTimer != null) {
      setState(() => countdownTimer!.cancel());
    }
  }

  void resetTimer() {
    stopTimer();
    setState(
        () => myDuration = const Duration(hours: 0, minutes: 0, seconds: 0));
  }

  void setTimer() {
    stopTimer();
    setState(() => myDuration = Duration(
        hours: int.tryParse(hoursController.text) == null
            ? 0
            : int.parse(hoursController.text),
        minutes: int.tryParse(minutesController.text) == null
            ? 0
            : int.parse(minutesController.text),
        seconds: int.tryParse(secondsController.text) == null
            ? 0
            : int.parse(secondsController.text)));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours);
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    const TextStyle textStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 50);

    const TextStyle textStyleHeader =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 25);

    var timerTextFields = Column(
      children: [
        const Text(
          'Sätt tid',
          style: textStyleHeader,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: 110,
              child: TextField(
                textAlign: TextAlign.center,
                style: textStyle,
                controller: hoursController,
                decoration: const InputDecoration(
                  hintText: 'HH',
                ),
              )),
          SizedBox(
              width: 110,
              child: TextField(
                textAlign: TextAlign.center,
                style: textStyle,
                controller: minutesController,
                decoration: const InputDecoration(
                  hintText: 'MM',
                ),
              )),
          SizedBox(
              width: 110,
              child: TextField(
                textAlign: TextAlign.center,
                style: textStyle,
                controller: secondsController,
                decoration: const InputDecoration(
                  hintText: 'SS',
                ),
              )),
        ]),
      ],
    );

    var timerButtons = Column(
      children: [
        const Text(
          'Kontrollers',
          style: textStyleHeader,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Start',
            onPressed: startTimer,
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            tooltip: 'Stop',
            onPressed: () {
              if (countdownTimer == null || countdownTimer!.isActive) {
                stopTimer();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Reset',
            onPressed: resetTimer,
          ),
        ]),
      ],
    );

    var timeText = Column(
      children: [
        const Text(
          'Timer',
          style: textStyleHeader,
        ),
        Text(
          '$hours:$minutes:$seconds',
          style: textStyle,
        ),
      ],
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(10), child: timeText),
            Padding(
              padding: const EdgeInsets.all(10),
              child: timerButtons,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: timerTextFields,
            ),
          ],
        ),
      ),
    );
  }
}
