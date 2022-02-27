


import 'package:master_mind/models/mm_colours.dart';

import 'mm_guess_result.dart';
import 'mm_num_slots.dart';

class MasterMindGameState {
  MasterMindColourSet? answer;
  List<MasterMindColourSet> guesses = [];
  List<MasterMindGuessResult> guessResults = [];

  setAnswer( MasterMindColourSet a ) { answer = a; }

  makeGuess( MasterMindColourSet _guess ) {
    if (answer==null) throw("No answer set, call setAnswer before calling makeGuess");
    guesses.add( _guess );
    // now check the guess
    MasterMindGuessResult result = _checkGuess( guess: _guess, answer: answer! );
    guessResults.add( result );
    return result;
  }

  MasterMindGuessResult _checkGuess( { 
    required MasterMindColourSet guess, 
    required MasterMindColourSet answer 
  } ) {
    MasterMindGuessResult result = MasterMindGuessResult();
    List<bool> usedPositions = List.filled(NUMBER_OF_COLOUR_SLOTS, false);
    for (var a=0; a<answer.cols.length; a++) {
      //print(' Answer ($a)(${answer.cols[a]}');
      if (guess.cols[a]==answer.cols[a]) {
        result = MasterMindGuessResult.addRightInRight(result);
        usedPositions[a] = true;
      } else {
        var gotOneRightInWrong = false;
        for (var g=0; g<guess.cols.length; g++) {
          //print('      , Guess ($g)(${guess.cols[g]}) , Used ($g)(${usedPositions[g]}) ');
          if (!usedPositions[g]) {
            if (answer.cols[a]==guess.cols[g]) {
              usedPositions[g] = true;
              gotOneRightInWrong = true;
              //print('        YES - GOT IT!');
            }
          }
        }
        if (gotOneRightInWrong) {
          result = MasterMindGuessResult.addRightInWrong(result);
        }
      }
    }
    return result;
  }

}
