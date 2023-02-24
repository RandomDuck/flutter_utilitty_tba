import 'package:flutter/material.dart';

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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Text('New punchcard:'),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 2,
              child: TextField(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
