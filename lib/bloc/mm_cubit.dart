
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
