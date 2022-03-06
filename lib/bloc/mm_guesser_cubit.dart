
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_mind/models/mm_guess_set.dart';

import '../master_mind_ai.dart';
import '../models/mm_colours.dart';
import '../models/mm_guess_result.dart';
import '../widgets/guess_result.dart';


class GuesserState {
  
  MasterMindGuessSet guessSet;
  List<MasterMindColourSet>? possibleAnswers;
  List<bool>? activeGuessRows;
  bool? checkingAnswers = false;

  GuesserState( {
    required this.guessSet,
    this.possibleAnswers,
    this.activeGuessRows,
    this.checkingAnswers,
  }) {
    var activeGuessComplete = List.filled( guessSet.guesses.length, true );
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


  void checkGuesses() {

    emit( GuesserState(
      guessSet: state.guessSet,
      possibleAnswers: state.possibleAnswers,
      activeGuessRows: state.activeGuessRows,
      checkingAnswers: true,
    ) );

    // wrap in future delayed to try to get the UI to update with the above emit
    Future.delayed(const Duration(milliseconds: 500), () {

      Future<List<MasterMindColourSet>> fetchTheAnswers() async {
        return Future( () {
          MasterMindGuessSet? guessSet = MasterMindGuessSet();

          for (var i=0; i<state.guessSet.guesses.length; i++) {
            if (state.activeGuessRows![i]) {
              guessSet.addGuessAndGuessResult( 
                guess: state.guessSet.guesses[i],
                guessResult: state.guessSet.guessResults[i] 
              );
            }
          }
          // Now check for how many possible answers there are
          return MasterMindAi.fetchAllMatchingAnswers(guessSet);
        });
      }

      fetchTheAnswers().then((possibleAnswers) {
        emit( GuesserState(
          guessSet: state.guessSet,
          possibleAnswers: possibleAnswers,
          activeGuessRows: state.activeGuessRows,
          checkingAnswers: false,
        ) );
      });
    });

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
    var guessSet = state.guessSet;

    // click on empty peg to add in a RightInRight
    // click on a black (RightInRigtht) to add RightInWrong and remove RightInRight
    // click on a white (RightInWrong) to reove a RightInWrong
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
