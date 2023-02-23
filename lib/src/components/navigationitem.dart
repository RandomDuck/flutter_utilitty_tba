import 'package:flutter/material.dart';

class NavigationBarItem {
  NavigationBarItem(this.page, this.icon, this.label);
  Widget page;
  IconData icon;
  String label;
}
