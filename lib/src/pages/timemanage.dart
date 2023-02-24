import 'package:flutter/material.dart';
import '../components/punchcardinput.dart';

class PunchcClock extends StatefulWidget {
  @override
  State<PunchcClock> createState() => _PunchcClockState();
}

class _PunchcClockState extends State<PunchcClock> {
  bool active = false;
  
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
          flex: 2,
          child: Wrap(
            children: [
              for(element in punchCardList)
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: !active
                ? theme.colorScheme.primary
                : theme.colorScheme.background,
            foregroundColor: !active
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onBackground,
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Done'),
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
