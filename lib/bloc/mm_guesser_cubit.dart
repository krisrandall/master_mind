
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
    var activeGuessComplete = List.filled( 5, true );
    if (activeGuessRows!=null) {
      for (var i = 0; i < activeGuessRows!.length; i++) {
        activeGuessComplete[i] = activeGuessRows![i];
      }
    }
    activeGuessRows = activeGuessComplete;
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
    state.activeGuessRows![rowIndex] = !state.activeGuessRows![rowIndex];
    emit(state);
  }

  togglePeg( int onWhichRow, GuessResultValue colourOfPegBeingToggled ) {
    // click on empty peg to add in a RightInRight
    // click on a black (RightInRigtht) to add RightInWrong and remove RightInRight
    // click on a white (RightInWrong) to reove a RightInWrong
    var currentGuessResult = state.guessSet.guessResults[onWhichRow];
    if (colourOfPegBeingToggled==GuessResultValue.none) {
      currentGuessResult = MasterMindGuessResult(
        rightInRight: currentGuessResult.rightInRightSpot + 1,
        rightInWrong: currentGuessResult.rightInWrongSpot,
      );
    } else if (colourOfPegBeingToggled==GuessResultValue.black) {
        currentGuessResult = MasterMindGuessResult(
          rightInRight: currentGuessResult.rightInRightSpot - 1,
          rightInWrong: currentGuessResult.rightInWrongSpot + 1,
      );
    } else if (colourOfPegBeingToggled==GuessResultValue.white) {
      currentGuessResult = MasterMindGuessResult(
        rightInRight: currentGuessResult.rightInRightSpot,
        rightInWrong: currentGuessResult.rightInWrongSpot - 1,
      );
    }
    state.guessSet.guessResults[onWhichRow] = currentGuessResult;
    emit(state);  
  }



}
