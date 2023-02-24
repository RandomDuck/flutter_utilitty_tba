import 'package:flutter/material.dart';
import '../components/punchcardinput.dart';

class PunchcClock extends StatefulWidget {
  @override
  State<PunchcClock> createState() => _PunchcClockState();
}

class _PunchcClockState extends State<PunchcClock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        PunchCardInput(
          onPressed: () {},
          icon: Icons.add_box,
        ),
        Expanded(
          child: Wrap(
            children: [],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Done'),
        ),
        SizedBox(
          height: 120,
        ),
      ],
    );
  }
}
