import 'package:notes/src/presentation/common_widgets/drop_down_menu/custom_dropdown_item_model.dart';

class DropDownState{
  final List<CustomDropDownItemModel> items;
  final int isClose;
  DropDownState({required this.items,required this.isClose});
}