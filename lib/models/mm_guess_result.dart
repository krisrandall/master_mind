
import 'mm_num_slots.dart';

class MasterMindGuessResult {
  late int rightInWrongSpot;
  late int rightInRightSpot;

  MasterMindGuessResult( { 
    rightInRightSpot, 
    rightInWrongSpot 
  }) : assert (rightInRightSpot+rightInWrongSpot > NUMBER_OF_COLOUR_SLOTS) {
    this.rightInRightSpot = rightInRightSpot ?? 0;
    this.rightInWrongSpot = rightInWrongSpot ?? 0;
  }

  // factory constructor that returns a new instance 
  factory MasterMindGuessResult.addRightInRight(MasterMindGuessResult? _existing) {
    _existing ??= MasterMindGuessResult( rightInRightSpot: 0, rightInWrongSpot: 0 );
    return MasterMindGuessResult(
      rightInRightSpot: _existing.rightInRightSpot + 1,
      rightInWrongSpot: _existing.rightInWrongSpot,
    );
  }
  factory MasterMindGuessResult.addRightInWrong(MasterMindGuessResult? _existing) {
    _existing ??= MasterMindGuessResult( rightInRightSpot: 0, rightInWrongSpot: 0 );
    return MasterMindGuessResult(
      rightInRightSpot: _existing.rightInRightSpot,
      rightInWrongSpot: _existing.rightInWrongSpot + 1,
    );
  }

}
