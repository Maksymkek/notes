import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/cubit/dropdown_item_state.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/custom_dropdown_action_model.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/custom_dropdown_item_model.dart';

class DropDownItemCubit extends Cubit<DropDownState> {
  DropDownItemCubit(List<CustomDropDownItemModel> items)
      : super(
          DropDownState(items: items, isClose: 1),
        );
  void _switchSelectedAction(CustomDropDownItemModel item, CustomDropdownActionModel selectedAction)
  {
    for (var action in item.actions) {
      if(action.isSelected){
        action.isSelected = false;
      }
      if(action==selectedAction){
        action.isSelected = true;
      }
    }
  }
  void onActionSelected(CustomDropdownActionModel selectedAction)
  {
    var newItems= state.items;
    for (var item in newItems)
    {
      int actionId = item.actions.indexOf(selectedAction);
      if (actionId != -1){
        _switchSelectedAction(item, selectedAction);
        emit(DropDownState(items: newItems, isClose: 2));
        break;
      }
    }
  }
  void onItemClick(CustomDropDownItemModel item){

    int id = state.items.indexOf(item);
    item.active == 0? 1:0;
    final newItems = state.items;
    newItems[id] = item;
    emit(DropDownState(items: newItems, isClose: 1));
  }
  bool checkClose(){
    emit(DropDownState(items: state.items, isClose: state.isClose-1));
    return state.isClose<=0;
  }
}
