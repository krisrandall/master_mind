
import 'mm_num_slots.dart';

class MasterMindGuessResult {
  late int rightInWrongSpot;
  late int rightInRightSpot;

  MasterMindGuessResult( { 
    rightInRightSpot, 
    rightInWrongSpot 
  }) : assert ((rightInRightSpot??0)+(rightInWrongSpot??0) <= NUMBER_OF_COLOUR_SLOTS) {
    this.rightInRightSpot = rightInRightSpot ?? 0;
    this.rightInWrongSpot = rightInWrongSpot ?? 0;
  }

  // factory constructor that returns a new instance 
  factory MasterMindGuessResult.addRightInRight(MasterMindGuessResult? _existing) {
    _existing ??= MasterMindGuessResult();
    return MasterMindGuessResult(
      rightInRightSpot: _existing.rightInRightSpot + 1,
      rightInWrongSpot: _existing.rightInWrongSpot,
    );
  }
  factory MasterMindGuessResult.addRightInWrong(MasterMindGuessResult? _existing) {
    _existing ??= MasterMindGuessResult();
    return MasterMindGuessResult(
      rightInRightSpot: _existing.rightInRightSpot,
      rightInWrongSpot: _existing.rightInWrongSpot + 1,
    );
  }

  @override
  int get hashCode => (rightInRightSpot.hashCode + rightInWrongSpot.hashCode);

  @override
  bool operator == (Object other) {
    if (other is MasterMindGuessResult && other.runtimeType == runtimeType) {
      if (
        (other.rightInRightSpot == rightInRightSpot) && 
        (other.rightInRightSpot == rightInRightSpot) 
      ) {
        return true;
      }
    }
    return false;
  }



  @override 
  toString() {
    return "Right in Right = $rightInRightSpot, Right in Wrong = $rightInWrongSpot";
  }
}



