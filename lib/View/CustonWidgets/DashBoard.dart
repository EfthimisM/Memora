
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Palettes/Palette1.dart';
import '../ProgressBars/CircleProgressPainter.dart';
import '../ProgressBars/LineProgressPainter.dart';

class DashBoard extends StatelessWidget {
  final double progress;
  final double borderWidth;
  final double circleSizeOuter;
  final double circleSizeInner;
  final String timeString;
  final int currentInstruction;
  final int totalInstructions;
  final double instructionCounter;
  final int diffLevel;
  final VoidCallback onPausePressed;
  final Palette1 palette;
  final bool tablet;

  const DashBoard({
    super.key,
    required this.progress,
    required this.borderWidth,
    required this.circleSizeOuter,
    required this.circleSizeInner,
    required this.timeString,
    required this.currentInstruction,
    required this.totalInstructions,
    required this.instructionCounter,
    required this.diffLevel,
    required this.onPausePressed,
    required this.palette,
    required this.tablet
  });

  // general Text widget
  Widget AppText(String text, double size, FontWeight fontWeight, Color color, bool tablet){
    return Text(
      text,
      style: TextStyle(
          fontSize: tablet ? size: size* 0.66666,
          color: color,
          fontWeight: fontWeight,
          fontFamily: "Inter"
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Background container
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: palette.Light,
            height: tablet? 150 :  125,
          ),
        ),

        // Outer circle background
        Positioned(
          top: tablet? 50 : 25,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: circleSizeOuter,
              height: circleSizeOuter,
              decoration: BoxDecoration(
                color: palette.Light,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        // Progress circle with score
        Positioned(
          top: tablet? 50 + (150 - circleSizeInner - borderWidth * 2) / 2:
          25 + (150 - circleSizeInner - borderWidth * 2) / 2,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: circleSizeInner + borderWidth * 2,
              height: circleSizeInner + borderWidth * 2,
              child: CustomPaint(
                painter: CircleProgressPainter(
                  progress: progress,
                  borderWidth: borderWidth,
                ),
                child: Center(
                  child: Container(
                    width: circleSizeInner,
                    height: circleSizeInner,
                    decoration: BoxDecoration(
                      color: palette.Light,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: circleSizeInner / 8),
                        Center(
                          child: AppText(
                            "SCORE",
                            tablet? 15 : 25,
                            FontWeight.normal,
                            Colors.white,
                            tablet
                          ),
                        ),
                        Center(
                          child: AppText(
                            (progress * 30).toStringAsFixed(1).replaceAll(RegExp(r"\.?0+$"), ""),
                            25,
                            FontWeight.bold,
                            Colors.white,
                            tablet
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Left side controls (Time and Instructions)
        Positioned(
          top:tablet? 150 - circleSizeInner * 0.5 - 25 : 150 - circleSizeInner * 0.5 - 30,
          left: tablet? screenWidth / 10 : 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText("ΧΡΟΝΟΣ", 15, FontWeight.normal, Colors.white, tablet),
                  AppText(timeString, 20, FontWeight.bold, Colors.white, tablet),
                  const SizedBox(height: 5),
                ],
              ),
              SizedBox(width: tablet? screenWidth / 10: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText("ΟΔΗΓΕΙΑ", 15, FontWeight.normal, Colors.white, tablet),
                  AppText(
                    "$currentInstruction/$totalInstructions",
                    20,
                    FontWeight.bold,
                    Colors.white,
                    tablet
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: tablet?75 : 50,
                    child: CustomPaint(
                      painter: LineProgressPainter(
                        progress: instructionCounter,
                        borderWidth: 5,
                        lineLength: tablet?75 : 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right side controls (Difficulty and Pause)
        Positioned(
          top: tablet? 150 - circleSizeInner * 0.5 - 25 : 150 - circleSizeInner * 0.5 - 30,
          right: tablet?screenWidth / 10 : 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText("ΕΠΙΠΕΔΟ", 15, FontWeight.normal, Colors.white, tablet),
                  AppText(
                    diffLevel.toString(),
                    20,
                    FontWeight.bold,
                    Colors.white,
                    tablet
                  ),
                  const SizedBox(height: 5),
                ],
              ),
              SizedBox(width: tablet? screenWidth / 10: 20),
              IconButton(
                onPressed: onPausePressed,
                icon: Icon(
                  CupertinoIcons.pause_circle,
                  color: Colors.white,
                  size: tablet?50 : 30,
                ),

              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

}