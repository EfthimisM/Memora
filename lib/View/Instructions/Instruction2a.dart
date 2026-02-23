import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustonWidgets/AppTimer.dart';
import '../CustonWidgets/DashBoard.dart';
import '../CustonWidgets/InstructionBar.dart';
import '../CustonWidgets/ItemList.dart';
import '../CustonWidgets/RewardScreen.dart';
import '../CustonWidgets/ZoomedListBuckets.dart';
import '../Item.dart';
import '../Palettes/Palette1.dart';
import '../TextTemplates/AppText.dart';
import '../TextTemplates/AppUnderlinedText.dart';
import '../TextTemplates/InstructionText.dart';
import 'Instruction3a.dart';

class Instruction2a extends StatefulWidget {
  final List<List<Item>> items;
  final double progress;

  const Instruction2a({
    super.key,
    required this.items,
    required this.progress,
  });

  @override
  State<Instruction2a> createState() => Instruction2aState();
}


class Instruction2aState extends State<Instruction2a>{

  late bool showInstruction;

  // color pallete
  late Palette1 pallete1 = Palette1();
  bool showScore = false;
  late double finalS = 0;



  // timer
  late AppTimer _timer;
  String _timeString = "00:00";
  String instructionLabel = 'ΟΔΗΓΙΑ 2';

  final ValueNotifier<int> itemsSelected = ValueNotifier(0);
  int totalInstructions = 10;
  int currentInstruction = 2;
  late double progress;

  // next screen
  late Widget nextScreen;
  late Widget thisScreen;

  // Bucket lists
  List<String> bucketLabels = ['Προϊόντα < 1,00 €','Προϊόντα > 6,00 €'];
  List<Color> bucketColors = [Color(0xFFFFCC00), Color(0xFF02D822)];

  // allow lists to be clickable
  late bool clickable = true;

  // Instructions List
  List<String> instructions = [' 2) Οδηγία:\n Να ψάξεις σε όλα τα ΑΡΤΟΠΟΙΕΙΑ και να βρεις τα είδη που '
      'κοστίζουν κάτω από 1,00 ευρώ και τα είδη  που κοστίζουν πάνω από 6,00 ευρώ,'
      ' και να τα γράψεις με τη σειρά που τα συναντάς.'];

  // hard code the correct answers
  List<String> solutionsA = ["Σταφιδόψωμο", "Ψωμί σικάλεως"];
  List<String> solutionsB = ["Πάστες", "Κρουασάν"];

  bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }

  double instructionSize = 25;

  double checkSolutions(){
    double score = 0.0;

    for(List<Item> list in widget.items){
      for(Item item in list){
        if(item.select){
          // sostes apantiseis +1.5
          // lathos apantiseis - 0.5
          if(solutionsA.contains(item.name) && item.type == 0){
            if(item.order == solutionsA.indexOf(item.name) + 1)
              score += 3/4;
            else
              score += 0.5;
          }else if (solutionsB.contains(item.name) && item.type == 1){
            if(item.order == solutionsB.indexOf(item.name) + 1)
              score += 3/4;
            else
              score += 0.5;
          }else{
            score -= 0.5;
          }
        }
      }
    }

    if(score < 0)
      return 0;

    double tmp = score/30;
    progress += tmp;

    return score;
  }

  @override
  void initState() {
    super.initState();
    for(var list in widget.items){
      for(var item in list){
        item.selected = false;
      }
    }
    _timer = AppTimer(
        onTick: (time) => setState(() => _timeString = time)
    );
    progress = widget.progress;
    showInstruction = true;
    nextScreen = Instruction3a(progress: progress,
    items: widget.items,);
    thisScreen = Instruction2a(items: widget.items, progress: progress);
  }

  @override
  void dispose() {
    _timer.dispose();
    itemsSelected.dispose();
    super.dispose();
  }

  Map<String,bool> flags = {
    'listOpened': false,
    'bakery1': false,
    'bakery2': false,
    'bakery3': false,
    'bakery4': false,
  };
  
  @override
  build(context){
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
                        text: instructions[0],
                        size:  isTablet(context) ? instructionSize : instructionSize - 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height:screenHeight / 8 ),
                      IconButton(onPressed: () {
                        setState(() {
                          showInstruction = false;
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
          if(!showInstruction) ...[
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
                          AppText(text: "ΑΡΤΟΠΟΙΕΙΑ", size: 30, fontWeight: FontWeight.bold,
                              color: Colors.black),
                          SizedBox(height: isTablet(context)?40 : 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 1", items: widget.items[0],width:  screenWidth / 3,
                                id: 1, flags: flags, isTablet: isTablet(context), colors: bucketColors,),
                              SizedBox( width:isTablet(context)? 50 : 25,),
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 2", items: widget.items[1],width:  screenWidth / 3,
                                  id: 2, flags: flags, isTablet: isTablet(context), colors: bucketColors)
                            ],
                          ),
                          SizedBox(height: isTablet(context)?40 : 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 3", items: widget.items[2], width:  screenWidth / 3,
                                  id: 3, flags: flags, isTablet: isTablet(context), colors: bucketColors),
                              SizedBox( width:isTablet(context)? 50 : 25,),
                              ItemList(title: "ΑΡΤΟΠΟΙΕΙΟ 4", items: widget.items[3], width:  screenWidth / 3,
                                  id: 4, flags: flags, isTablet: isTablet(context), colors: bucketColors)
                            ],
                          ),
                          SizedBox(height: isTablet(context)?40 : 30,),
                          if(itemsSelected.value > 0 || !clickable)
                            GestureDetector(
                              onTap: (){
                                setState(() {

                                  if(clickable){
                                    finalS = checkSolutions();
                                    showScore = true;
                                    _timer.pause();
                                  }else{
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => nextScreen),
                                    );
                                  }

                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: AppText(text: "ΣΥΝΕΧΕΙΑ",size:  isTablet(context)? 30 : 15,fontWeight:  FontWeight.bold,color: pallete1.Dark ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(color: pallete1.Dark, width: 3.0),
                                ),
                              ),
                            ),
                          SizedBox(height: isTablet(context)? 300: 150,),
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
                    child: ZoomedListBuckets(width: screenWidth/1.5,items: widget.items[0], isTablet: isTablet(context),
                      title: 'ΑΡΤΟΠΟΙΕΙΟ 1',id: 1,itemsSelected: itemsSelected, palette: pallete1, colors: bucketColors, labels: bucketLabels,
                      clickable: clickable,)
                ),
              ),
            ),

            Center(
              child: IgnorePointer(
                ignoring: flags['bakery2'] == false,
                child: Opacity(
                    opacity:
                    flags['listOpened'] == true && flags['bakery2'] == true? 1 : 0,
                    child: ZoomedListBuckets(width: screenWidth/1.5,items: widget.items[1], isTablet: isTablet(context),
                      title: 'ΑΡΤΟΠΟΙΕΙΟ 2',id: 2,itemsSelected: itemsSelected, palette: pallete1, colors: bucketColors, labels: bucketLabels
                      ,clickable: clickable,)
                ),
              ),
            ),

            Center(
              child: IgnorePointer(
                ignoring: flags['bakery3'] == false,
                child: Opacity(
                    opacity:
                    flags['listOpened'] == true && flags['bakery3'] == true? 1 : 0,
                    child: ZoomedListBuckets(width: screenWidth/1.5,items: widget.items[2], isTablet: isTablet(context),
                      title: 'ΑΡΤΟΠΟΙΕΙΟ 3',id: 3,itemsSelected: itemsSelected, palette: pallete1,colors: bucketColors, labels: bucketLabels,
                      clickable: clickable,)
                ),
              ),
            ),

            Center(
              child: IgnorePointer(
                ignoring: flags['bakery4'] == false,
                child: Opacity(
                    opacity:
                    flags['listOpened'] == true && flags['bakery4'] == true? 1 : 0,
                    child: ZoomedListBuckets(width: screenWidth/1.5,items: widget.items[3], isTablet: isTablet(context),
                      title: 'ΑΡΤΟΠΟΙΕΙΟ 4',id: 4,itemsSelected: itemsSelected, palette: pallete1,colors: bucketColors, labels: bucketLabels,
                      clickable: clickable,)
                ),
              ),
            ),
            Opacity(
              opacity: showScore ? 0.05 : 1,
              child: InstructionBar(
                palette1: pallete1,
                instruction: instructions[0],
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
            timeString: _timeString,
            currentInstruction: currentInstruction,
            totalInstructions: 10,
            instructionCounter: currentInstruction/ 10,
            diffLevel: 0,
            tablet: isTablet(context),
            onPausePressed: () {
              setState(() {
                _timer.pause();
                showInstruction = true;
              });
            },
            palette: pallete1,
          ),

          if(showScore)
            RewardScreen(score: finalS, message: "ΠΟΛΥ ΩΡΑΙΑ!!!", time: _timeString,
                heigh: 200, screenHeigh: screenHeight, nextScreen: nextScreen,
                thisScreen: thisScreen)
        ],
      ),
    );
  }

}