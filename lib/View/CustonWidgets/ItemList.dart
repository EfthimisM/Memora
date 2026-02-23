import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Item.dart';
import '../Palettes/Palette1.dart';
import '../TextTemplates/AppText.dart';
import '../TextTemplates/AppUnderlinedText.dart';

class ItemList extends StatelessWidget {
  final String title;
  final List<Item> items;
  final double width;
  final int id;
  final ValueChanged<bool>? onListTapped;
  final Map<String, bool> flags;
  final bool isTablet;
  final List<Color>? colors;

  const ItemList({
    super.key,
    required this.title,
    required this.items,
    required this.width,
    required this.id,
    required this.flags,
    this.onListTapped,
    this.isTablet = true,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final Palette1 palette = Palette1();
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: palette.Dark,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(height: isTablet? 30 : 15),
            AppUnderlinedText(
              text: title,
              size: isTablet? 30: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              underlineColor: Colors.white,
            ),
            SizedBox(height: isTablet? 30 : 15),
            Wrap(
              direction: Axis.vertical,
              spacing: isTablet?25 : 15,
              children: items.map((item) =>
                  AppText(
                    text: item.toString(),
                    size: isTablet? 15 :10,
                    fontWeight: FontWeight.bold,
                    color: item.selected? colors![item.type]: Colors.white,
                  ),
              ).toList(),
            ),
            SizedBox(height: isTablet? 30 : 15),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    final shouldOpen = flags['listOpened'] != true;

    // Update flags
    flags.updateAll((key, value) => false);
    if (shouldOpen) {
      flags['bakery$id'] = true;
      flags['listOpened'] = true;
    }

    // Print debug info
    flags.forEach((key, value) => print('$key: $value'));

    // Notify parent if needed
    onListTapped?.call(shouldOpen);
  }
}