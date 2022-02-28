
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_mind/models/mm_guess_set.dart';

import '../models/mm_colours.dart';
import '../models/mm_guess_result.dart';
import '../widgets/answer.dart';
import '../widgets/guess_result.dart';


class GuesserState {
  
  MasterMindGuessSet guessSet;
  List<Answer>? possibleAnswers;
  List<bool>? activeGuessRows;

  GuesserState( {
    required this.guessSet,
    this.possibleAnswers,
    this.activeGuessRows,
  }) {
    var activeGuessComplete = List.filled( guessSet.guesses.length+1, true );
    if (activeGuessRows!=null) {
      for (var i = 0; i < activeGuessRows!.length; i++) {
        activeGuessComplete[i] = activeGuessRows![i];
      }
    }
    activeGuessRows = activeGuessComplete;
  }

  @override toString() {
    return " GuesserState ($guessSet), active = $activeGuessRows, possible answers = $possibleAnswers";
  }

}


class GuesserCubit extends Cubit<GuesserState> {

  GuesserCubit( List<MasterMindColourSet> _initial ) :
    super( GuesserState(guessSet: MasterMindGuessSet( guesses: _initial ) ) );


  void checkGuesses( MasterMindGuessSet guessSet ) {
    // Now check for how many possible answers there are
    List<Answer>? possibleAnswers; // TODO !!

    emit( GuesserState(
      guessSet: guessSet,
      possibleAnswers: possibleAnswers,
      activeGuessRows: state.activeGuessRows,
    ) );
  }

  toggleGuessRow( int rowIndex ) {
    var activeGuesses = state.activeGuessRows;
    activeGuesses![rowIndex] = !activeGuesses[rowIndex];
    emit( GuesserState(
      guessSet: state.guessSet,
      possibleAnswers: state.possibleAnswers,
      activeGuessRows: activeGuesses,
    ) );
  }

  togglePeg( int onWhichRow, GuessResultValue colourOfPegBeingToggled ) {
    // click on empty peg to add in a RightInRight
    // click on a black (RightInRigtht) to add RightInWrong and remove RightInRight
    // click on a white (RightInWrong) to reove a RightInWrong
    var guessSet = state.guessSet;
    if (colourOfPegBeingToggled==GuessResultValue.none) {
      guessSet.guessResults[onWhichRow] = MasterMindGuessResult(
        rightInRight: guessSet.guessResults[onWhichRow].rightInRightSpot + 1,
        rightInWrong: guessSet.guessResults[onWhichRow].rightInWrongSpot,
      );
    } else if (colourOfPegBeingToggled==GuessResultValue.black) {
        guessSet.guessResults[onWhichRow] = MasterMindGuessResult(
          rightInRight: guessSet.guessResults[onWhichRow].rightInRightSpot - 1,
          rightInWrong: guessSet.guessResults[onWhichRow].rightInWrongSpot + 1,
      );
    } else if (colourOfPegBeingToggled==GuessResultValue.white) {
      guessSet.guessResults[onWhichRow] = MasterMindGuessResult(
        rightInRight: guessSet.guessResults[onWhichRow].rightInRightSpot,
        rightInWrong: guessSet.guessResults[onWhichRow].rightInWrongSpot - 1,
      );
    }
    emit( GuesserState(
      guessSet: state.guessSet,
      possibleAnswers: state.possibleAnswers,
      activeGuessRows: state.activeGuessRows,
    ) );
  }



}
