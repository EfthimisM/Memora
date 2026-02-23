import 'package:flutter/cupertino.dart';
import 'package:memora/View/Instructions/Instruction5.dart';
import 'Instruction2a.dart';

class Instruction4 extends Instruction2a {
  const Instruction4({
    super.key,
    required super.items,
    required super.progress,
  });

  @override
  Instruction4State createState() => Instruction4State();
}

class Instruction4State extends Instruction2aState {
  @override
  List<String> instructions = ['4) Οδηγία: Παρατήρησε με προσοχή τα πρώτα δύο είδη του 2ου αρτοποιείου. '
  'Χρειάζεται να τα  γράψεις και να τα μάθεις καλά, ώστε να τα θυμάσαι όλα χωρίς κανένα λάθος, όταν θα σου το'
  ' ζητήσω αργότερα. Μην προχωρήσεις στην επόμενη άσκηση, αν δεν είσαι βέβαιος, ότι έχεις μάθει και τα δύο είδη, χωρίς κανένα λάθος'];

  @override
  int currentInstruction = 4;

  @override
  void initState() {
    super.initState();
    instructionLabel = 'ΟΔΗΓΕΙΑ 4';
    bucketLabels = [];
    bucketColors = [];
    clickable = false;
    nextScreen = Instruction5(progress: progress, items: widget.items,);
    thisScreen = Instruction4(items: widget.items, progress: progress);
    instructionSize = 25;
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}