import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/bigcard.dart';
import '../components/punchcarditem.dart';
import '../components/punchcardinput.dart';
import '../components/state.dart';

class PunchcClock extends StatefulWidget {
  @override
  State<PunchcClock> createState() => _PunchcClockState();
}

class _PunchcClockState extends State<PunchcClock> {
  List<PunchCardItem> cards = [];
  String label = "";

  String getTime(Duration x) {
    return '${x.inHours}:${x.inMinutes}:${x.inSeconds}';
  }

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    setState(() {
      cards = appState.punchCards;
    });
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        PunchCardInput(
          onChanged: (change) {
            setState(() {
              label = change;
            });
          },
          onPressed: () {
            setState(() {
              cards.add(
                PunchCardItem(
                  pair: label,
                  index: cards.length,
                  callback: (target) {
                    appState.setPunch(target);
                  },
                ),
              );
            });
            appState.updatePunchCards(cards);
          },
          icon: Icons.add_box,
        ),
        SizedBox(
          height: 30,
        ),
        BigCard(
            pair: appState.selectedPunch < 0
                ? '00:00:00'
                : getTime(appState.punchDates[appState.selectedPunch].elapsed)),
        SizedBox(
          height: 30,
        ),
        Expanded(
          flex: 2,
          child: Wrap(
            children: [
              for (PunchCardItem element in cards)
                Padding(
                  padding: EdgeInsets.all(7),
                  child: element,
                ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: (appState.selectedPunch < 0)
                ? theme.colorScheme.primary
                : theme.colorScheme.background,
            foregroundColor: (appState.selectedPunch < 0)
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onBackground,
          ),
          onPressed: () {
            appState.setPunch(-1);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Done'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text('Current times:'),
        SizedBox(
          height: 10,
        ),
        Wrap(
          children: [
            for (int i = 0; i < appState.punchCards.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((appState.punchCards[i].pair == ''
                            ? 'blank$i'
                            : appState.punchCards[i].pair) +
                        ' : ' +
                        getTime(appState.punchDates[i].elapsed)),
                  ),
                ),
              )
          ],
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
