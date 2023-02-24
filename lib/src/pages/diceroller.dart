import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_utilitty_tba/src/components/bigcard.dart';
import '../components/customdropdownbutton.dart';

class DiceRoller extends StatefulWidget {
  @override
  State<DiceRoller> createState() => _DiceRoller();
}

enum DiceTypes {
  d2,
  d4,
  d6,
  d8,
  d10,
  d12,
  d20,
  d100,
}

class _DiceRoller extends State<DiceRoller> {
  List<DiceRoll> rollHistory = [];
  int result = 0;
  DiceTypes selected = DiceTypes.d4;

  final _key = GlobalKey();

  void handleRoll() {
    int rollTarget = 4;
    switch (selected) {
      case DiceTypes.d4:
        rollTarget = 4;
        break;
      case DiceTypes.d6:
        rollTarget = 6;
        break;
      case DiceTypes.d8:
        rollTarget = 8;
        break;
      case DiceTypes.d10:
        rollTarget = 10;
        break;
      case DiceTypes.d12:
        rollTarget = 12;
        break;
      case DiceTypes.d20:
        rollTarget = 20;
        break;
      case DiceTypes.d100:
        rollTarget = 100;
        break;
      default:
        rollTarget = 2;
        break;
    }
    int roll = Random().nextInt(rollTarget) + 1;
    setState(() {
      if (result != 0) {
        var list = _key.currentState as AnimatedListState;
        list.insertItem(0);
        rollHistory.insert(0, DiceRoll(result, selected.name));
      }
      result = roll;
    });
  }

  void handleClear() {
    setState(() {
      result = 0;
      var list = _key.currentState as AnimatedListState;
      for (var i = 0; i < rollHistory.length; i++) {
        list.removeItem(
            (0),
            (context, animation) => FadeTransition(
                  opacity: animation,
                ));
      }
      rollHistory.clear();
    });
  }

  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ShaderMask(
              shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
              // This blend mode takes the opacity of the shader (i.e. our gradient)
              // and applies it to the destination (i.e. our animated list).
              blendMode: BlendMode.dstIn,
              child: AnimatedList(
                  key: _key,
                  shrinkWrap: false,
                  reverse: true,
                  itemBuilder: (context, index, animation) {
                    DiceRoll pair = rollHistory[index];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: Center(
                        child: Text(
                          '${pair.type.toUpperCase()}: ${pair.value}',
                          semanticsLabel:
                              '${pair.type.toUpperCase()}: ${pair.value}',
                        ),
                      ),
                    );
                  }),
            ),
          ),
          BigCard(
            pair: 'Result: $result',
          ),
          SizedBox(
            height: 20,
          ),
          CustomDropDown(
            items: DiceTypes.values
                .map(
                  (dice) => DropdownMenuItem(
                    value: dice,
                    child: Text(dice.name.replaceFirst('d', 'Dice ')),
                  ),
                )
                .toList(),
            onChange: (type) {
              setState(() {
                if (type != null) {
                  selected = type;
                }
              });
            },
            value: selected,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: handleRoll,
                icon: Icon(Icons.change_history_sharp),
                label: Text('Roll'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: handleClear,
                child: Text('Clear'),
              ),
            ],
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class DiceRoll {
  DiceRoll(this.value, this.type);
  int value;
  String type;
}
