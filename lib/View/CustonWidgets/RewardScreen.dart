import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memora/View/TextTemplates/AppText.dart';
import 'AudioService.dart';

class RewardScreen extends StatefulWidget {
  final double score; // Out of 3 (e.g., 2.5)
  final String time;
  final String message;
  final double heigh;
  final double screenHeigh;
  final Widget nextScreen;
  final Widget thisScreen;

  const RewardScreen({
    super.key,
    required this.score,
    required this.message,
    required this.time,
    required this.heigh,
    required this.screenHeigh,
    required this.nextScreen,
    required this.thisScreen,
  });

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final AudioService _audioService = AudioService();
  final List<dynamic> starStates = [false, false, false];
  bool end = false;
  bool play = false;

  @override
  void initState() {
    super.initState();
    _animateStars();
  }

  void _animateStars() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Handle zero score case immediately
    if (widget.score <= 0) {
      if (mounted) {
        setState(() {
          end = true;
          play = true; // Allow immediate continuation
        });
      }
      return;
    }

    int fullStars = widget.score.floor();
    bool hasHalf = widget.score - fullStars >= 0.5;
    int totalStars = fullStars + (hasHalf ? 1 : 0);
    // If somehow we get here with zero stars, return
    if (totalStars <= 0) return;

    for (int i = 0; i < totalStars; i++) {
      Future.delayed(Duration(milliseconds: 1000 * i), () async {
        if (!mounted) return;

        setState(() {
          starStates[i] = i < fullStars ? true : null;
        });

        await _audioService.playDing();

        if (i == totalStars - 1) {
          end = true;
          await Future.delayed(const Duration(milliseconds: 500));
          if (mounted) {
            setState(() {
              play = true;
            });
          }
        }
      });
    }
  }

  Widget _buildStar(int index) {
    final state = starStates[index];
    if (state == true) {
      return Icon(CupertinoIcons.star_fill, size: 80, color: Colors.amber);
    } else if (state == null) {
      return Icon(CupertinoIcons.star_lefthalf_fill, size: 80, color: Colors.amber);
    } else {
      return Icon(CupertinoIcons.star, size: 80, color: Colors.grey.shade700);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.heigh,
      left: 20,
      right: 20,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => widget.nextScreen),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  text: widget.message,
                  size: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 30),

                // Stars with animation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1000),
                      child: _buildStar(index),
                    );
                  }),
                ),

                const SizedBox(height: 30),

                // Time
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: end ? 1 : 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.clock, size: 35, color: Colors.black),
                      const SizedBox(width: 10),
                      AppText(
                        text: widget.time,
                        size: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: widget.screenHeigh / 8),

                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: play ? 1 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => widget.nextScreen),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                            child: const Icon(CupertinoIcons.play, size: 80, color: Colors.black),
                          ),
                        ),
                        if(widget.score < 3)
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => widget.thisScreen),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                              child: const Icon(CupertinoIcons.restart, size: 80, color: Colors.black),
                            ),
                          ),
                      ]

                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
