
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_mind/models/mm_guess_set.dart';

import '../models/mm_colours.dart';
import '../widgets/answer.dart';


class GuesserState {
  MasterMindGuessSet guessSet;
  List<Answer>? possibleAnswers;
  GuesserState( {
    required this.guessSet,
    this.possibleAnswers,
  });
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
    ) );

  }

}
