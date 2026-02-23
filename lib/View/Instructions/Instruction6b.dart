

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memora/View/Instructions/Instruction5.dart';
import '../CustonWidgets/DashBoard.dart';
import '../CustonWidgets/ItemList.dart';
import '../CustonWidgets/RewardScreen.dart';
import '../CustonWidgets/ZoomedItemList.dart';
import '../Item.dart';
import '../TextTemplates/AppText.dart';
import '../TextTemplates/AppUnderlinedText.dart';
import '../TextTemplates/InstructionText.dart';
import 'Instruction1.dart';

class Instruction6b extends Instruction1 {
  Instruction6b({super.key});

  @override
  Instruction6bState createState() => Instruction6bState();
}

class Instruction6bState extends Instruction1State {
  @override
  List<String> InsructionsList = ['6.β) Οδηγία:\n Να επιλέξεις τα είδη ψωμιού με αλφαβητική σειρά.'];

  @override
  List<Item> items1 = [Item("Ζαπάτα", 1.25), Item("Ψωμί καλαμποκίσιο", 1.80),
    Item("Μπαγκέτα γαλλική", 1.10), Item("Ψωμί σικάλεως", 0.90)];

  @override
  int currentInstruction = 6;

  @override
  void initState() {
    super.initState();
    instructionLabel = 'ΟΔΗΓΙΑ 6B';
    nextScreen = Instruction5(progress: progress, items: [items1, items2, items3, items4],);
    thisScreen = Instruction6b();
    instructionSize = 30;
    solutions = ['Ζαπάτα','Μπαγκέτα γαλλική','Ψωμί καλαμποκίσιο','Ψωμί σικάλεως'];
    progress = 0.6;
    instructionCounter = 0.6;
  }

  @override
  double checkSolutions() {
    // todo: implement it
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          if(showInstruction) ...[
            GestureDetector(
                onTap: () {
                  setState(() {
                    if(flags['listOpened'] == true) {
                      flags['listOpened'] = false;
                      flags.updateAll((key, value) => false);
                    }
                  });
                },
                child: Center(
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
                            text: InsructionsList[0],
                            size:  isTablet(context) ? 30 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height:screenHeight / 8 ),
                          IconButton(onPressed: () {
                            setState(() {
                              showInstruction = false;
                              timer.start();
                            });
                          },
                              icon: Icon(CupertinoIcons.play, size: isTablet(context)? 100 : 50, color: Colors.black,)
                          ),
                        ],
                    ),
                  ),
                ),
              ),
          ],

          if (!showInstruction) ...[

            GestureDetector(
              onTap: () {
                setState(() {
                  if(flags['listOpened'] == true) {
                    flags['listOpened'] = false;
                    flags.updateAll((key, value) => false);
                  }
                });
              },
              child: Center(
                child: Opacity(
                  opacity: flags['listOpened'] == true ? 0.2 : showScore? 0.05 :1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: isTablet(context)? 50 : 30,),
                        AppText(text: "ΕΙΔΗ", size: 30, fontWeight: FontWeight.bold,
                            color: Colors.black),
                        SizedBox(height: isTablet(context)?40 : 30,),
                        ItemList(title: "", items: items1,width:  screenWidth / 3, id: 1,
                          flags: flags, isTablet: isTablet(context), colors: [Color(0xFFFFCC00)],),

                        SizedBox(height: isTablet(context)?40 : 30,),
                        if(itemsSelected1.value + itemsSelected2.value + itemsSelected3.value + itemsSelected4.value  > 0)
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                showScore = true;
                                timer.pause();

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: AppText(text: "ΣΥΝΕΧΕΙΑ",size: isTablet(context)? 30 : 15,fontWeight:  FontWeight.bold,color: pallete1.Dark ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: pallete1.Dark, width: 3.0),
                              ),
                            ),
                          ),
                        SizedBox(height: isTablet(context)? 300 : 100,),

                      ],
                    ),
                ),
              ),
            ),

            // Individual Item Lists
            Center(
              child: IgnorePointer(
                ignoring: flags['bakery1'] == false,
                child: Opacity(
                    opacity:
                    flags['listOpened'] == true && flags['bakery1'] == true? 1 : 0,
                    child: ZoomedItemList(width: screenWidth/1.5,items: items1, isTablet: isTablet(context),
                      title: '',id: 1,itemsSelected: itemsSelected1, palette: pallete1,)
                ),
              ),
            ),

          ],
          DashBoard(
            progress: progress,
            borderWidth: 8.0,
            circleSizeOuter: 150.0,
            circleSizeInner: 150 * 0.66666 - 12,
            timeString: timeString,
            currentInstruction: currentInstruction,
            totalInstructions: totalInstructions,
            instructionCounter: instructionCounter,
            diffLevel: diffLevel,
            tablet: isTablet(context),
            onPausePressed: () {
              if(!showScore){
                setState(() {
                  timer.pause();
                  showInstruction = true;
                });
              }
            },
            palette: pallete1,
          ),

          if(showScore)
            RewardScreen(score: checkSolutions(), message: "ΠΟΛΥ ΩΡΑΙΑ!!!", time: timeString,
                heigh: 200, screenHeigh: screenHeight, nextScreen: nextScreen, thisScreen : thisScreen)

        ],
      )
    );
  }
}