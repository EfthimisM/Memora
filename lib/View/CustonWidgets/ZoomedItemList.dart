import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Item.dart';
import '../Palettes/Palette1.dart';
import '../TextTemplates/AppText.dart';
import '../TextTemplates/AppUnderlinedText.dart';

class ZoomedItemList extends StatefulWidget {
  final double width;
  final List<Item> items;
  final String title;
  final int id;
  final ValueNotifier<int> itemsSelected;
  final Palette1 palette;
  final bool isTablet;

  const ZoomedItemList({
    super.key,
    required this.width,
    required this.items,
    required this.title,
    required this.id,
    required this.itemsSelected,
    required this.palette,
    required this.isTablet,
  });

  @override
  State<ZoomedItemList> createState() => _ZoomedItemListState();
}

class _ZoomedItemListState extends State<ZoomedItemList> {
  late List<int> selectedIndices;

  @override
  void initState() {
    super.initState();
    selectedIndices = [];
    // Initialize order for all items to 0
    for (var item in widget.items) {
      item.order = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: widget.width),
        decoration: BoxDecoration(
          color: widget.palette.Dark,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
            vertical: widget.isTablet ? 50 : 25,
            horizontal: widget.isTablet ? 20 : 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppUnderlinedText(
              text: widget.title,
              size: widget.isTablet ? 40 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              underlineColor: Colors.white,
            ),
            SizedBox(height: widget.isTablet ? 30 : 15),
            _buildItemList(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      separatorBuilder: (_, __) => SizedBox(height: widget.isTablet ? 15 : 10),
      itemBuilder: (context, index) => _buildListItem(index),
    );
  }

  Widget _buildListItem(int index) {
    final isSelected = widget.items[index].selected;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => _toggleSelection(index),
          child: AppText(
            text: widget.items[index].toString(),
            size: widget.isTablet ? 25 : 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.yellow : Colors.white,
          ),
        ),
        SizedBox(width: widget.isTablet ? 20 : 10),
        GestureDetector(
          onTap: () => _toggleSelection(index),
          child: Transform.scale(
            scale: widget.isTablet ? 2 : 1.5,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 2,
                  color: isSelected ? Colors.yellow : Colors.white,
                ),
                color: Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                child: Text(
                  '${widget.items[index].order}',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  void _toggleSelection(int index) {
    setState(() {
      final item = widget.items[index];
      item.selected = !item.selected;

      if (item.selected) {
        selectedIndices.add(index);
      } else {
        selectedIndices.remove(index);
        item.order = 0;
      }

      for (int i = 0; i < selectedIndices.length; i++) {
        widget.items[selectedIndices[i]].order = i + 1;
      }

      widget.itemsSelected.value = selectedIndices.length;
    });
  }
}