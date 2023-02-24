import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChange,
    required this.value,
    this.label = 'Select:',
  });

  final dynamic value;
  final List<DropdownMenuItem> items;
  final ValueSetter onChange;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select dice:'),
            SizedBox(
              width: 5,
            ),
            DropdownButton(
              focusNode: FocusNode(canRequestFocus: false),
              value: value,
              items: items,
              onChanged: onChange,
            ),
          ],
        ),
      ),
    );
  }
}
