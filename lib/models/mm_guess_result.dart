
import 'mm_num_slots.dart';

class MasterMindGuessResult {
  int? _rightInWrongSpot;
  int? _rightInRightSpot;

  int get rightInRightSpot => _rightInRightSpot!;
  int get rightInWrongSpot => _rightInWrongSpot!;

  MasterMindGuessResult( { 
    rightInRight, 
    rightInWrong, 
  }) : assert ((rightInRight??0)+(rightInWrong??0) <= NUMBER_OF_COLOUR_SLOTS) {
    _rightInRightSpot = rightInRight ?? 0;
    _rightInWrongSpot = rightInWrong ?? 0;
  }

  // factory constructor that returns a new instance 
  factory MasterMindGuessResult.addRightInRight(MasterMindGuessResult? _existing) {
    _existing ??= MasterMindGuessResult();
    return MasterMindGuessResult(
      rightInRight: _existing.rightInRightSpot + 1,
      rightInWrong: _existing.rightInWrongSpot,
    );
  }
  factory MasterMindGuessResult.addRightInWrong(MasterMindGuessResult? _existing) {
    _existing ??= MasterMindGuessResult();
    return MasterMindGuessResult(
      rightInRight: _existing.rightInRightSpot,
      rightInWrong: _existing.rightInWrongSpot + 1,
    );
  }

  @override
  int get hashCode => (rightInRightSpot.hashCode + rightInWrongSpot.hashCode);

  @override
  bool operator == (Object other) {
    if (other is MasterMindGuessResult && other.runtimeType == runtimeType) {
      if (
        (other.rightInRightSpot == rightInRightSpot) && 
        (other.rightInWrongSpot == rightInWrongSpot) 
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



