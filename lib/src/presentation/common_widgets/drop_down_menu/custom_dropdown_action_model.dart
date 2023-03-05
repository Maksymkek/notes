import 'package:flutter/cupertino.dart';

class CustomDropdownActionModel {
  final String title;
  final IconData icon;
  bool isSelected;
  final Function() onTap;

  CustomDropdownActionModel({
    required this.title,
    required this.onTap,
    required this.icon,
    this.isSelected = false,
  });
}
