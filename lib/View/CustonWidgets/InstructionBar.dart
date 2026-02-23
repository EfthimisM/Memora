import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memora/View/Instructions/Instruction1.dart';
import 'package:memora/View/Palettes/Palette1.dart';

class InstructionBar extends StatelessWidget{
  final Palette1 palette1;
  final String instruction;
  final int InstructionIndex;
  final bool isTablet;

  const InstructionBar({
    super.key,
    required this.palette1,
    required this.instruction,
    required this.InstructionIndex,
    required this.isTablet
  });

  Widget InstructionText(String text, double size, FontWeight fontWeight, Color color){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          fontFamily: "Inter"
      ),
    );
  }

  @override
  Widget build(BuildContext context){

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                  color: palette1.Light
              ),
              padding: EdgeInsets.symmetric(vertical: isTablet? 20 :10, horizontal: isTablet? 20 :10),
              child: Center(
                  child: InstructionText(instruction,isTablet? 25: 15, FontWeight.bold, Colors.white),
              ),
            )
        ),
      ],
    );
  }
}