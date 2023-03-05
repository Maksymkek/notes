import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/src/presentation/app_colors.dart';
import 'package:notes/src/presentation/app_icons.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/cubit/dropdown_item_cubit.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/cubit/dropdown_item_state.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/custom_dropdown_action_model.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/custom_dropdown_item_model.dart';

class CustomDropDownMenuWidget extends StatefulWidget {
  const CustomDropDownMenuWidget({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<CustomDropDownMenuWidget> createState() =>
      _CustomDropDownMenuWidgetState();
}

class _CustomDropDownMenuWidgetState extends State<CustomDropDownMenuWidget> {
  final cubit = DropDownItemCubit([
    CustomDropDownItemModel(
      title: 'Sort by',
      icon: Icons.sort_rounded,
      actions: [
        CustomDropdownActionModel(
          title: 'date',
          onTap: () {},
          isSelected: true,
          icon: Icons.date_range_rounded,
        ),
        CustomDropdownActionModel(
          title: 'name',
          onTap: () {},
          isSelected: false,
          icon: Icons.abc,
        ),
      ],
    ),
    CustomDropDownItemModel(
      title: 'Sort order',
      icon: Icons.swap_vert_rounded,
      actions: [
        CustomDropdownActionModel(
          title: 'descending',
          onTap: () {},
          isSelected: true,
          icon: Icons.arrow_downward_rounded,
        ),
        CustomDropdownActionModel(
          title: 'ascending',
          onTap: () {},
          isSelected: false,
          icon: Icons.arrow_upward_rounded,
        ),
      ],
    ),
    CustomDropDownItemModel(
      title: 'Change theme',
      icon: Icons.brightness_4,
      actions: [
        CustomDropdownActionModel(
          title: 'light',
          onTap: () {},
          isSelected: true,
          icon: Icons.light_mode_rounded,
        ),
        CustomDropdownActionModel(
          title: 'dark',
          onTap: () {},
          isSelected: false,
          icon: Icons.dark_mode_rounded,
        ),
      ],
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropDownItemCubit, DropDownState>(
        bloc: cubit,
        builder: (BuildContext context, state) {
          return GestureDetector(
            onTap: _checkExit,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.topRight,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 80.0, 20.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ListView(
                            children: cubit.state.items
                                .map((item) => DropDownItemWidget(
                                      item: item,
                                      cubit: cubit,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _checkExit() {
    if (cubit.checkClose() == true) {
      widget.onClose();
    }
  }
}

//TODO i need implement a model of widget into parameters instead of many parameters
class DropDownItemWidget extends StatelessWidget {
  const DropDownItemWidget({
    super.key,
    required this.item,
    required this.cubit,
  });

  final CustomDropDownItemModel item;
  final DropDownItemCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){cubit.onItemClick(item);},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    size: 16,
                    color: AppColors.milkWhite,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.title,
                    style: GoogleFonts.roboto(color: AppColors.milkWhite),
                  ),
                  const Expanded(child: SizedBox()),
                  RotatedBox(
                    quarterTurns: item.active,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.milkWhite,
                    ),
                  )
                ],
              ),
            ),
          ),
          cubit.state.items.last == item
              ? Container()
              : Divider(
                  thickness: 0.0,
                  color: Colors.white.withOpacity(0.3),
                )
        ],
      ),
    );
  }
}

class _ActionListWidget extends StatelessWidget {
  const _ActionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.black.withOpacity(0.7),
          ),
          child: Column(
            children: [
              const Expanded(child: Text('Sort by')),
              ListView(
                children: [
                  _ActionWidget(
                    action: CustomDropdownActionModel(
                      title: 'date',
                      onTap: () {},
                      isSelected: true,
                      icon: Icons.date_range_rounded,
                    ),
                  ),
                  _ActionWidget(
                    action: CustomDropdownActionModel(
                      title: 'name',
                      onTap: () {},
                      isSelected: true,
                      icon: Icons.abc,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionWidget extends StatefulWidget {
  const _ActionWidget({super.key, required this.action});

  final CustomDropdownActionModel action;

  @override
  State<_ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<_ActionWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.action.icon),
      tileColor: Colors.black.withOpacity(0.7),
      title: Text(widget.action.title),
      trailing:
          widget.action.isSelected ? const Icon(Icons.done_rounded) : null,
    );
  }
}
