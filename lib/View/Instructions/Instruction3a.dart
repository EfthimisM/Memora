import 'package:flutter/cupertino.dart';
import 'package:memora/View/Instructions/Instruction4.dart';
import 'Instruction2a.dart';

class Instruction3a extends Instruction2a {
  const Instruction3a({
    super.key,
    required super.items,
    required super.progress,
  });

  @override
  Instruction3aState createState() => Instruction3aState();
}

class Instruction3aState extends Instruction2aState {
  @override
  List<String> instructions = ['3) Οδηγία:\n Να ψάξεις σε όλα τα ΑΡΤΟΠΟΙΕΙΑ  και να βρεις τα μπισκότα, '
      'τις πίτες και τα σιροπιαστά γλυκά. Να τα επιλέξεις με τη σειρά που τα συναντάς'];

  @override
  List<String> solutionsA = ["Πάστες", "Κρουασάν"];
  @override
  List<String> solutionsB = ["Πάστες", "Κρουασάν"];
  List<String> solutionsC = ["Πάστες", "Κρουασάν"];

  @override
  List<String> bucketLabels = ['Μπισκότα','Πίτες', 'Σιροπιαστά γλυκά'];


  @override
  List<Color> bucketColors = [Color(0xFFFFCC00), Color(0xFF02D822),
    Color(0xFFDD00FF)];

  @override
  int currentInstruction = 3;

  @override
  void initState() {
    super.initState();
    instructionLabel = 'ΟΔΗΓΕΙΑ 3';
    nextScreen = Instruction4(items: widget.items, progress: widget.progress);
    thisScreen = Instruction3a(items: widget.items, progress: widget.progress);
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}