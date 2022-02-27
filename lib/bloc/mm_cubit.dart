
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_mind/models/mm_colours.dart';

import '../models/mm_game_model.dart';
import '../models/mm_guess_result.dart';

class GameCubit extends Cubit<MasterMindGameState> {

  GameCubit() : super( MasterMindGameState() );

  setAnswer( MasterMindSColourSet _answer ) {
    state.answer = _answer;
  }

  MasterMindGuessResult makeGuess( MasterMindSColourSet _guess ) {
    if (state.answer==null) throw("No answer set, call setAnswer before calling makeGuess");
    state.guesses.add( _guess );
    // now check the guess
    return _checkGuess( guess: _guess, answer: state.answer! );
  }

  MasterMindGuessResult _checkGuess( { 
    required MasterMindSColourSet guess, 
    required MasterMindSColourSet answer 
  } ) {
    MasterMindGuessResult result = MasterMindGuessResult();
    for (var a=0; a<answer.cols.length; a++) {
      var gotThisRight = false;
      var gotThisRightInRight = false;
      var currentAnswerCol = answer.cols[a];
      for (var g=0; g<guess.cols.length; g++) {
        if (answer.cols[a]==guess.cols[g] && !gotThisRightInRight) {
          result = MasterMindGuessResult.addRightInRight(result);
          gotThisRightInRight = true;
        }
        if (currentAnswerCol==guess.cols[g]) {
          gotThisRight = true;
        }
      }
      if (gotThisRight&&!gotThisRightInRight) {
        result = MasterMindGuessResult.addRightInWrong(result);
      }
    }
    return result;
  }

}
