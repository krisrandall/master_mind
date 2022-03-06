

import 'mm_guess_set.dart';
import 'mm_colours.dart';
import 'mm_guess_result.dart';
import 'mm_num_slots.dart'; 

 
class MasterMindGameState {
  MasterMindColourSet? answer;
  MasterMindGuessSet guessSet = MasterMindGuessSet();

  setAnswer( MasterMindColourSet a ) { answer = a; }

  makeGuess( MasterMindColourSet _guess ) {
    if (answer==null) throw("No answer set, call setAnswer before calling makeGuess");
    // now check the guess
    MasterMindGuessResult result = _checkGuess( guess: _guess, answer: answer! );
    guessSet.addGuessAndGuessResult(guess: _guess, guessResult: result);
    return result;
  }

  MasterMindGuessResult _checkGuess( { 
    required MasterMindColourSet guess, 
    required MasterMindColourSet answer 
  } ) {
    var allred = false;
    if ( (answer.cols[0]==MMCols.red ) &&
    (answer.cols[1]==MMCols.red ) &&
    (answer.cols[2]==MMCols.red ) &&
    (answer.cols[3]==MMCols.red ) &&
    (answer.cols[4]==MMCols.red )  )
    {
      allred = true;
    }
    if (allred) {
      print(' -- Testing $guess against $answer -- ');
    }

    MasterMindGuessResult result = MasterMindGuessResult();
    List<bool> usedPositions = List.filled(NUMBER_OF_COLOUR_SLOTS, false);
    for (var g=0; g<guess.cols.length; g++) {
      //print(' Answer ($a)(${answer.cols[a]}');
      if (guess.cols[g]==answer.cols[g] ) {
        result = MasterMindGuessResult.addRightInRight(result);
        usedPositions[g] = true;
      } else {
        var gotOneRightInWrong = false;
          for (var a=0; a<answer.cols.length; a++) {
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

  @override 
  toString() {
    return answerString() + guessesString() + "\n Guesses Hash : ${uniqueHashOfGuesses()}\n";
  }

  String answerString() {
    return " Answer : ${answer.toString()} \n";
  }

  String guessesString() => guessSet.guessesString();

  String uniqueHashOfGuesses() => guessSet.uniqueHashOfGuesses();


}
