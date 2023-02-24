import 'package:flutter/material.dart';

class PunchCardInput extends StatelessWidget {
  const PunchCardInput({
    super.key,
    required this.onPressed,
    this.label = 'New punchcard:',
    this.icon = Icons.add,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Spacer(),
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(label),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(),
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(icon),
                  ),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
