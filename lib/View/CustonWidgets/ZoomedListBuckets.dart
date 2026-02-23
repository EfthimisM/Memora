import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Item.dart';
import '../Palettes/Palette1.dart';
import '../TextTemplates/AppText.dart';
import '../TextTemplates/AppUnderlinedText.dart';

class ZoomedListBuckets extends StatefulWidget {
  final double width;
  final List<Item> items;
  final String title;
  final int id;
  final ValueNotifier<int> itemsSelected;
  final Palette1 palette;
  final bool isTablet;
  final List<String> labels;
  final List<Color> colors;
  final bool clickable;

  const ZoomedListBuckets({
    super.key,
    required this.width,
    required this.items,
    required this.title,
    required this.id,
    required this.itemsSelected,
    required this.palette,
    required this.isTablet,
    required this.labels,
    required this.colors,
    this.clickable = true
  });

  @override
  State<ZoomedListBuckets> createState() => _ZoomedItemListState();
}

class _ZoomedItemListState extends State<ZoomedListBuckets> {
  late List<int> selectedIndices;
  late List<bool> isSelected = List.filled(widget.colors.length, false);
  late Palette1 palette1 = Palette1();
  late int currentIndex = widget.colors.length + 1;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          SizedBox(height: widget.isTablet ? 50 : 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.labels.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ChoiceChip(
                  label: Text(widget.labels[index]),
                  selected: isSelected[index],
                  onSelected: (selected){
                    if(widget.clickable){
                      setState(() {
                        isSelected = List.filled(isSelected.length, false);
                        currentIndex = index;
                        isSelected[index] = selected;
                      });

                    }
                  },
                  selectedColor: widget.colors[index],
                  backgroundColor: palette1.Dark,
                  labelStyle: TextStyle(
                    color: !isSelected[index]? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.isTablet ? 25 : 15
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: isSelected[index] ?widget.colors[index] : Colors.grey[300]!,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
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
    final item = widget.items[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => widget.clickable? _toggleSelection(index) : (),
          child: AppText(
            text: widget.items[index].toString(),
            size: widget.isTablet ? 25 : 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? widget.colors[item.type] : Colors.white,
          ),
        ),
        if(widget.clickable)
          SizedBox(width: widget.isTablet ? 20 : 10),
        if(widget.clickable)
          GestureDetector(
            onTap: () =>  _toggleSelection(index),
            child: Transform.scale(
              scale: widget.isTablet ? 2 : 1.5,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 2,
                    color: isSelected ? widget.colors[item.type] : Colors.white,
                  ),
                  color: Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                  child: Text(
                    '${widget.items[index].order}',
                    style: TextStyle(
                      color: widget.colors[item.type],
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
      for(int i = 0; i < widget.labels.length; i++){
        if(isSelected[i]){
          final item = widget.items[index];
          item.selected = !item.selected;

          if (item.selected) {
            selectedIndices.add(index);
            item.type = i;
          } else {
            selectedIndices.remove(index);
            item.order = 0;
            item.type = 999;
          }

        }
      }
      for (int i = 0; i < selectedIndices.length; i++) {
        widget.items[selectedIndices[i]].order = i + 1;
      }
      widget.itemsSelected.value = selectedIndices.length;

    });
  }
}