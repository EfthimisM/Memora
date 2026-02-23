import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memora/View/CustonWidgets/RewardScreen.dart';
import 'package:memora/View/CustonWidgets/ZoomedItemList.dart';
import 'package:memora/View/Instructions/Instruction2a.dart';

import '../CustonWidgets/AppTimer.dart';
import '../CustonWidgets/DashBoard.dart';
import '../CustonWidgets/InstructionBar.dart';
import '../CustonWidgets/ItemList.dart';
import '../Item.dart';
import '../Palettes/Palette1.dart';
import '../TextTemplates/AppText.dart';
import '../TextTemplates/AppUnderlinedText.dart';
import '../TextTemplates/InstructionText.dart';

class Instruction1 extends StatefulWidget{
  Instruction1({super.key});

  @override
  State<Instruction1> createState() => Instruction1State();
}

class Instruction1State extends State<Instruction1>{

  // Flags to handle list selection
  Map<String,bool> flags = {
    'listOpened': false,
    'bakery1': false,
    'bakery2': false,
    'bakery3': false,
    'bakery4': false,
  };

  bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }

  late bool showInstruction;
  bool showScore = false;

  // used for instruction bar
  double instructionCounter = 0.1;
  // used for score completion bar
  double progress = 0;
  late Widget nextScreen ;

  final ValueNotifier<int> itemsSelected1 = ValueNotifier(0);
  final ValueNotifier<int> itemsSelected2 = ValueNotifier(0);
  final ValueNotifier<int> itemsSelected3 = ValueNotifier(0);
  final ValueNotifier<int> itemsSelected4 = ValueNotifier(0);

  int totalInstructions = 10;
  int currentInstruction = 1;

  // timer
  late AppTimer timer;
  String timeString = "00:00";

  // color pallete
  late Palette1 pallete1 = Palette1();

  // level difficulty
  int diffLevel = 0;

  String instructionLabel = "ΟΔΗΓΙΑ 1";


  Widget thisScreen = Instruction1();
  double instructionSize = 30;

  // temporary test Lists
  List<Item> items1 = [Item("Μπισκότα Βουτύρου", 3.80), Item("Σταφιδόψωμο", 0.70),
    Item("Τουλούμπες", 5.10), Item("Ζαπάτα", 1.25), Item("Τυραμισού", 5.60)
  ];
  List<Item> items2 = [Item("Πάστες", 6.20), Item("Προφιτερόλ", 3.60),
    Item("Κριτσίνια", 2.20), Item("Τυρόπιτα", 1.30), Item("Ψωμί καλαμποκίσιο", 1.80)
  ];
  List<Item> items3 = [Item("Μπαγκέτα γαλλική", 1.10), Item("Τάρτα ", 5.20),
    Item("Ψωμί σικάλεως", 0.90), Item("Γιαούρτι", 5.50), Item("Ραβανί Βεροίας", 4.80)
  ];
  List<Item> items4 = [Item("Μπισκότα Κανέλας", 4.10), Item("Σπανακόπιτα", 1.50),
    Item("Κανταΐφι", 5.80), Item("Κρουασάν", 6.90), Item("Σοκολατάκια", 5.40)
  ];

  // hard code the correct answers
  List<String> solutions = ["Μπαγκέτα γαλλική", "Ψωμί σικάλεως"];

  // temporary instructio
  List<String> InsructionsList = ['1) Οδηγία:\nΝα βρεις και να επιξεις από το ΑΡΤΟΠΟΙΕΙΟ 3, τα είδη ψωμιού '
      'και επέλεξε τα με την σειρά που τα διαβάζεις'];

  double checkSolutions() {

    final allBakeryItems = [...items1, ...items2, ...items3, ...items4];
    double totalScore = 0.0;

    for (var item in allBakeryItems.where((i) => i.select)) {
      if (solutions.contains(item.name)) {
        bool isCorrectOrder = item.order == solutions.indexOf(item.name) + 1;
        totalScore += isCorrectOrder ? 1.5 : 1.0;
      } else {
        totalScore -= 0.5;
      }
    }
    final finalScore = totalScore < 0 ? 0.0 : totalScore;

    setState(() {
      progress += (finalScore / 30);
    });

    return finalScore;
  }


  @override
  void dispose() {
    timer.dispose();

    itemsSelected1.dispose();
    itemsSelected2.dispose();
    itemsSelected3.dispose();
    itemsSelected4.dispose();

    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    timer = AppTimer(
        onTick: (time) => setState(() => timeString = time)
    );
    showInstruction = true;
    nextScreen = Instruction2a(progress: progress,
        items: [items1, items2, items3, items4]);
    // _timer.start();
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Stack(
        children: [

          if(showInstruction) ...[
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 12, vertical: screenHeight / 8),
                child: Column(
                  children: [
                    SizedBox(height:screenHeight / 8 ),
                    AppUnderlinedText(
                      text: "ΟΔΗΓΕΙΑ 1",
                      size: isTablet(context) ? 35 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      underlineColor: Colors.black,),
                    SizedBox(height:screenHeight / 8 ),
                    InstructionText(
                        text: InsructionsList[0],
                        size: isTablet(context) ? 35 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height:screenHeight / 8 ),
                    IconButton(onPressed: () {
                        setState(() {
                          showInstruction = false;
                          timer.start();
                        });
                      },
                      icon: Icon(CupertinoIcons.play, size: isTablet(context) ? 100 : 50, color: Colors.black,)
                    ),
                  ]
                ),
              ),
            )
          ],

          if (!showInstruction) ...[
            // Items lists
            Positioned(
              top: 150,
              right: 0,
              left: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if(flags['listOpened'] == true) {
                      flags['listOpened'] = false;
                      flags.updateAll((key, value) => false);
                    }
                  });
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Opacity(
                      opacity: flags['listOpened'] == true ? 0.2 : showScore? 0.05 :1,
                      child: Column(
                        children: [
                          SizedBox(height: isTablet(context)? 50 : 30,),
                          AppText(text: "ΑΡΤΟΠΟΙΕΙΑ", size: isTablet(context) ? 30 : 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          SizedBox(height: isTablet(context)?40 : 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 1", items: items1,width:  screenWidth / 3, id: 1,
                                  flags: flags, isTablet: isTablet(context), colors: [Color(0xFFFFCC00)],),
                              SizedBox( width:isTablet(context)? 50 : 25,),
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 2", items: items2,width:  screenWidth / 3, id: 2,
                                  flags: flags, isTablet: isTablet(context),colors: [Color(0xFFFFCC00)])
                            ],
                          ),
                          SizedBox(height: isTablet(context)?40 : 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 3", items: items3, width:  screenWidth / 3, id: 3,
                                  flags: flags, isTablet: isTablet(context), colors: [Color(0xFFFFCC00)]),
                              SizedBox( width:isTablet(context)? 50 : 25,),
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 4", items: items4, width:  screenWidth / 3, id: 4,
                                  flags: flags, isTablet: isTablet(context), colors: [Color(0xFFFFCC00)])
                            ],
                          ),
                          SizedBox(height: isTablet(context)?40 : 30,),
                          if(itemsSelected1.value + itemsSelected2.value + itemsSelected3.value + itemsSelected4.value  > 0)
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  // todo: move to the next phase
                                  // testing pane stin epomeni amesos
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
                        title: 'ΑΡΤΟΠΟΙΕΙΟ 1',id: 1,itemsSelected: itemsSelected1, palette: pallete1,)
                ),
              ),
            ),

            Center(
              child: IgnorePointer(
                ignoring: flags['bakery2'] == false,
                child: Opacity(
                    opacity:
                    flags['listOpened'] == true && flags['bakery2'] == true? 1 : 0,
                    child: ZoomedItemList(width: screenWidth/1.5,items: items2, isTablet: isTablet(context),
                      title: 'ΑΡΤΟΠΟΙΕΙΟ 2',id: 2,itemsSelected: itemsSelected2, palette: pallete1,)
                ),
              ),
            ),

            Center(
              child: IgnorePointer(
                ignoring: flags['bakery3'] == false,
                child: Opacity(
                    opacity:
                    flags['listOpened'] == true && flags['bakery3'] == true? 1 : 0,
                    child: ZoomedItemList(width: screenWidth/1.5,items: items3, isTablet: isTablet(context),
                      title: 'ΑΡΤΟΠΟΙΕΙΟ 3',id: 3,itemsSelected: itemsSelected3, palette: pallete1,)
                ),
              ),
            ),

            Center(
              child: IgnorePointer(
                ignoring: flags['bakery4'] == false,
                child: Opacity(
                    opacity:
                    flags['listOpened'] == true && flags['bakery4'] == true? 1 : 0,
                    child: ZoomedItemList(width: screenWidth/1.5,items: items4, isTablet: isTablet(context),
                      title: 'ΑΡΤΟΠΟΙΕΙΟ 4',id: 4,itemsSelected: itemsSelected4, palette: pallete1,)
                ),
              ),
            ),

            Opacity(
              opacity: showScore ? 0.05 : 1,
              child: InstructionBar(
                  palette1: pallete1,
                  instruction: InsructionsList[0],
                  InstructionIndex: 1,
                isTablet: isTablet(context),
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


      ),
    );
  }

}