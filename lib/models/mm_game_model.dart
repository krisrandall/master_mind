


import 'package:master_mind/models/mm_colours.dart';

import 'mm_guess_result.dart';

class MasterMindGameState {
  MasterMindColourSet? answer;
  List<MasterMindColourSet> guesses = [];
  List<MasterMindGuessResult> guessResults = [];

  setAnswer( MasterMindColourSet a ) { answer = a; }

  makeGuess( MasterMindColourSet _guess ) {
    if (answer==null) throw("No answer set, call setAnswer before calling makeGuess");
    guesses.add( _guess );
    // now check the guess
    guessResults.add( _checkGuess( guess: _guess, answer: answer! ) );
  }

  MasterMindGuessResult _checkGuess( { 
    required MasterMindColourSet guess, 
    required MasterMindColourSet answer 
  } ) {
    MasterMindGuessResult result = MasterMindGuessResult();
    for (var a=0; a<answer.cols.length; a++) {
      if (guess.cols[a]==answer.cols[a]) {
        result = MasterMindGuessResult.addRightInRight(result);
      } else {
        var gotOneRightInWrong = false;
        for (var g=0; g<guess.cols.length; g++) {
          if (answer.cols[a]==guess.cols[g]) gotOneRightInWrong = true;
        }
        if (gotOneRightInWrong) {
          result = MasterMindGuessResult.addRightInWrong(result);
        }
      }
    }
    return result;
  }

}
