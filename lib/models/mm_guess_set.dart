

import 'mm_colours.dart';
import 'mm_guess_result.dart';

class MasterMindGuessSet {
  List<MasterMindColourSet> guesses;
  List<MasterMindGuessResult> guessResults;
  MasterMindGuessSet({
    guesses,
    guessResults,
  }) : guesses = guesses ?? [],
       guessResults = guessResults ?? [];

  /// set the guessResults property to no matches, for all of the guesses 
  initGuessResultsToBlank() {
    guessResults = List.filled( guesses.length, MasterMindGuessResult() );
  }
}
