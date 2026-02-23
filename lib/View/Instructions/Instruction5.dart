import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memora/View/Instructions/Instruction4.dart';
import 'package:memora/View/Instructions/Instruction6a.dart';
import 'package:memora/View/Palettes/Palette1.dart';
import 'package:memora/View/TextTemplates/AppText.dart';

import '../CustonWidgets/AppTimer.dart';
import '../CustonWidgets/DashBoard.dart';
import '../CustonWidgets/InstructionBar.dart';
import '../CustonWidgets/RewardScreen.dart';
import '../Item.dart';
import '../TextTemplates/AppUnderlinedText.dart';
import '../TextTemplates/InstructionText.dart';

class Instruction5 extends StatefulWidget {
  final double progress;
  final List<List<Item>> items;

  const Instruction5({
    super.key,
    required this.progress,
    required this.items,
  });

  @override
  State<Instruction5> createState() => Instruction5State();
}


class Instruction5State extends State<Instruction5>{

  String instruction = '5) Οδηγία:\n Θα σου παρουσιάζονται κάποια είδη ένα ένα, κάθε φορά '
      'που θα βλέπεις κάποιο για δεύτερη συνεχόμενη φορά το επιλέγεις και προχωράς';

  List<Item> items = [Item("Τούρτα Παγωτό", 7.50), Item("Ελιόψωμο", 0.6), Item("Ελιόψωμο", 0.6),Item("Μπουγάτσα", 1.50)
    ,Item("Μηλόπιτα", 2.20),Item("Μηλόπιτα", 2.20),Item("Ζυμωτό ψωμί", 1.00)];


  late AppTimer _timer;
  String _timeString = "00:00";
  String instructionLabel = 'ΟΔΗΓΙΑ 5';

  double finalS = 0.0;

  bool showInstructions = true;
  bool showScore = false;
  Palette1 palette1 = Palette1();

  bool changeAnimation = false;

  int _currentIndex = 0;


  void calculateScore(){
    for(int i = 0; i < items.length; i ++ ){
      if(items[i].selected){

        // bakalistiko approach gia na orithetisoume tis sostes apantiseis
        if(i == 2 || i == 5){
          finalS += 1.5;
        }else{
          finalS -= 1;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = AppTimer(
        onTick: (time) => setState(() => _timeString = time)
    );
  }


  @override
  void dispose() {
    _timer.dispose();
    super.dispose();
  }

  bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }

  Widget ItemContainer(Item item, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: changeAnimation ? 0 : 1,
        duration: Duration(milliseconds: 400),
        child: IgnorePointer(
          ignoring: changeAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: palette1.Dark,
              borderRadius: BorderRadius.circular(20),
            ),
            constraints: BoxConstraints(
              maxWidth: isTablet(context) ? 400 : 250,
            ),
            child: IntrinsicWidth(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Flexible text portion
                  Flexible(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: onTap,
                      child: Text(
                        '${item.name} ${item.price}€',
                        style: TextStyle(
                          color: item.selected ? Colors.yellow : Colors.white,
                          decoration: item.selected
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: item.selected ? const Color(0xFFFFCC00) : null,
                          decorationThickness: 2,

                          fontSize: isTablet(context)? 30 : 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter"
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet(context) ? 30 : 20),
                  GestureDetector(
                    onTap: () => onTap?.call(),
                    child: Transform.scale(
                      scale: isTablet(context) ? 2 : 1.5,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 2,
                            color: item.select ? Colors.yellow : Colors.white,
                          ),
                          color: Colors.transparent,
                        ),
                        child: item.select
                            ? Center(
                          child: Icon(CupertinoIcons.xmark, size: 15, color:Color(0xFFFFCC00),)
                        )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet(context) ? 15 : 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          if(showInstructions) ...[
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 12, vertical: screenHeight / 8),
                child: Column(
                    children: [
                      SizedBox(height: screenHeight / 8),
                      AppUnderlinedText(
                        text: instructionLabel,
                        size:  isTablet(context) ? 35 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        underlineColor: Colors.black,
                      ),
                      SizedBox(height: screenHeight / 8),
                      InstructionText(
                        text: instruction,
                        size:  isTablet(context) ? 30 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height:screenHeight / 8 ),
                      IconButton(onPressed: () {
                        setState(() {
                          showInstructions = false;
                          _timer.start();
                        });
                      },
                          icon: Icon(CupertinoIcons.play, size: isTablet(context)? 100 : 50, color: Colors.black,)
                      ),
                    ]
                ),
              ),
            )
          ],

          if (!showInstructions) ...[
            Center(
              child: Opacity(
                opacity: showScore ? 0.05 : 1 ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_currentIndex + 1}/${items.length}',
                      style: TextStyle(color: Colors.black,
                        fontSize: isTablet(context)? 20 : 15,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    SizedBox(height: isTablet(context)? 20 : 10),
                    // Current item display
                    ItemContainer(
                      items[_currentIndex],
                      onTap: () {
                        setState(() {
                          items[_currentIndex].selected = !items[_currentIndex].selected;
                        });

                        for(Item item in items){
                          if(item.select){
                            print(item.name + " selected ");
                          }else{
                            print(item.name + " not selected ");
                          }
                        }
                      },
                    ),
                    SizedBox(height: isTablet(context)? 40 : 20),
                    GestureDetector(

                      onTap: _currentIndex < items.length - 1
                          ? () async {

                        changeAnimation = true;
                        await Future.delayed(const Duration(milliseconds: 1000));
                        _currentIndex ++;
                        changeAnimation = false;

                      }
                          : (){

                        showScore = true;
                        _timer.pause();

                      },

                      child: AnimatedOpacity(
                        opacity: changeAnimation ? 0 : 1,
                        duration: Duration( milliseconds: 400),
                        child: IgnorePointer(
                          ignoring: changeAnimation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: changeAnimation? Colors.green: Colors.white,
                              border: Border.all(color: palette1.Dark, width: 3.0),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: isTablet(context) ? 400 : 250,
                            ),
                            child: AppText(text: _currentIndex < items.length - 1 ?'ΕΠΟΜΕΝΟ' : 'ΤΕΛΟΣ', size: isTablet(context)? 25 : 15,
                             fontWeight: FontWeight.bold, color: palette1.Dark,),
                          ),
                        ),
                      ),
                    ),
                    // Progress indicator

                  ],
                ),
              ),
            ),
          ],

          Opacity(
            opacity: showScore ? 0.05 : 1,
            child: InstructionBar(
              palette1: palette1,
              instruction: instruction,
              InstructionIndex: 1,
              isTablet: isTablet(context),
            ),
          ),

          DashBoard(
            progress: widget.progress,
            borderWidth: 8.0,
            circleSizeOuter: 150.0,
            circleSizeInner: 150 * 0.66666 - 12,
            timeString: _timeString,
            currentInstruction: 5,
            totalInstructions: 10,
            instructionCounter: 0.5,
            diffLevel: 0,
            tablet: isTablet(context),
            onPausePressed: () {
              setState(() {
                _timer.pause();
                _currentIndex = 0 ;
                showInstructions = true;
              });
            },
            palette: palette1,
          ),

          if(showScore)
            RewardScreen(score: finalS, message: "ΠΟΛΥ ΩΡΑΙΑ!!!", time: _timeString,
                heigh: 200, screenHeigh: screenHeight, nextScreen: Instruction6a(),
                thisScreen: Instruction5(progress: widget.progress, items: widget.items,))
        ],
      ),
    );
  }
}