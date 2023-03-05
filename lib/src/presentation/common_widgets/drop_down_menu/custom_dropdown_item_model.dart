import 'package:flutter/cupertino.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/custom_dropdown_action_model.dart';

class CustomDropDownItemModel {
  final String title;
  final IconData icon;
  final List<CustomDropdownActionModel> actions;
  int active;
  CustomDropDownItemModel({
    required this.title,
    required this.icon,
    required this.actions,
    this.active = 0,
  });
}