import 'package:flutter/material.dart';

class PunchCardInput extends StatelessWidget {
  const PunchCardInput({
    super.key,
    required this.onPressed,
    required this.onChanged,
    this.label = 'New punchcard:',
    this.icon = Icons.add,
  });

  final VoidCallback onPressed;
  final ValueSetter onChanged;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size.fromWidth(400)),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(label),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            onChanged: onChanged,
                          ),
                        ),
                        IconButton(
                          onPressed: onPressed,
                          icon: Icon(icon),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
