import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/state.dart';

class PunchCardItem extends StatelessWidget {
  const PunchCardItem({
    super.key,
    required this.pair,
    required this.index,
    required this.callback,
  });

  final int index;
  final dynamic pair;
  final ValueSetter callback;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    int selectedValue = appState.selectedPunch;
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: selectedValue == index
          ? theme.colorScheme.onPrimary
          : theme.colorScheme.onBackground,
    );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedValue == index
            ? theme.colorScheme.primary
            : theme.colorScheme.background,
      ),
      onPressed: () {
        callback(index);
      },
      child: Text(
        pair.toString(),
        semanticsLabel: pair.toString(),
        style: style,
      ),
    );
  }
}
