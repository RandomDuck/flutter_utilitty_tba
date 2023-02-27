import 'package:flutter/material.dart';
import 'pages/favtab.dart';
import 'pages/namegenerator.dart';
import 'pages/diceroller.dart';
import 'pages/timemanage.dart';
import 'components/navigationitem.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<NavigationBarItem> list = [
      NavigationBarItem(
        GeneratorPage(),
        Icons.account_circle_rounded,
        'Name generator',
      ),
      NavigationBarItem(
        FavoritesTab(),
        Icons.favorite,
        'Favorites list',
      ),
      NavigationBarItem(
        DiceRoller(),
        Icons.replay_circle_filled_rounded,
        'Dice roller',
      ),
      NavigationBarItem(
        PunchcClock(),
        Icons.punch_clock_rounded,
        'Time manager',
      ),
    ];

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 800,
                destinations: [
                  for (var item in list)
                    NavigationRailDestination(
                      icon: Icon(item.icon),
                      label: Text(item.label),
                    ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: list[selectedIndex].page,
              ),
            ),
          ],
        );
      }),
    );
  }
}
