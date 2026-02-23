import 'package:flutter/cupertino.dart';
import 'Instruction1.dart';
import 'Instruction6b.dart';

class Instruction6a extends Instruction1 {
  Instruction6a({super.key});

  @override
  Instruction6aState createState() => Instruction6aState();
}

class Instruction6aState extends Instruction1State {
  @override
  List<String> InsructionsList = ['6.α) Οδηγία:\n Να γράψεις, ερευνώντας τα είδη όλων των ΑΡΤΟΠΟΙΕΙΩΝ, όλα τα είδη ψωμιού.'];

  @override
  int currentInstruction = 6;

  @override
  void initState() {
    super.initState();
    instructionLabel = 'ΟΔΗΓΙΑ 6A';
    nextScreen = Instruction6b();
    thisScreen = Instruction6a();
    instructionSize = 30;
    solutions = ['Ζαπάτα','Ψωμί καλαμποκίσιο','Μπαγκέτα γαλλική','Ψωμί σικάλεως'];
    progress = 0.6;
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}