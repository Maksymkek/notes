
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/src/presentation/app_colors.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/drop_down_items.dart';

// raw functionality, only ui part work as planned

class DropDownMenuWidget extends StatelessWidget {
  const DropDownMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
            alignedDropdown: true,
          child: DropdownButton<String>(
            isExpanded: true,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            dropdownColor: Colors.white.withOpacity(0.5),
            style: GoogleFonts.roboto(color: AppColors.darkBrown),
            icon: const Icon(
              Icons.more_horiz,
              color: AppColors.darkBrown,
            ),
            elevation: 0,
            iconSize: 36,
            items: <String>[
              DropDownItems.sortBy.name,
              DropDownItems.sortOrder.name,
              DropDownItems.theme.name
            ].map((String title) {
              return DropdownMenuItem<String>(
                value: title,
                child: _buildItem(title),
              );
            }).toList(),
            onChanged: (_) {},
          ),
        ),
      ),
    );
  }

  Widget _buildItem(String title) {
    if (title == DropDownItems.sortBy.name) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: _DropDownItemWidget(
          title: 'Sort by ',
          items: const ['date', 'name'],
          onTap: [() {}, () {}],
          valueId: 0,
        ),
      );
    } else if (title == DropDownItems.sortOrder.name) {
      return _DropDownItemWidget(
        title: 'Sort order ',
        items: const ['ascending', 'descending'],
        onTap: [() {}, () {}],
        valueId: 1,
      );
    } else if (title == DropDownItems.theme.name) {
      return _DropDownItemWidget(
        title: 'Change theme',
        items: const ['light', 'dark'],
        onTap: [() {}, () {}],
        valueId: 0,
        icon: Icons.light_mode,
      );
    }
    return const Text('Error');
  }
}

class _DropDownItemWidget extends StatelessWidget {
  const _DropDownItemWidget({
    super.key,
    required this.title,
    required this.items,
    required this.valueId,
    this.icon,
    required this.onTap,
  });

  final List<String> items;
  final List<void Function()> onTap;
  final IconData? icon;
  final String title;
  final int valueId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
            child: Text(title)),
        SizedBox(
          width: 110,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                isExpanded: true,
                elevation: 0,
                icon: const Icon(Icons.abc),
                value: items[valueId],
                style: GoogleFonts.roboto(color: AppColors.darkBrown),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                dropdownColor: Colors.white,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    onTap: onTap[items.indexOf(value)],
                    child: Text(value,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
