

import 'mm_colours.dart';
import 'mm_guess_result.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


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

  String guessesString() {
    var string = '';
    for (var i=0; i<guesses.length; i++) {
      string += "  Guess $i : ${guesses[i]} -- ${guessResults[i]} \n";
    }
    return string;
  }

  String uniqueHashOfGuesses() {
    var bytes1 = utf8.encode(guessesString());
    return sha256.convert(bytes1).toString();
  }


}

// retrospective note - I should have just had a map of a ColourSet to a GuessResult and called that a Guess,
// and then simply had a List of those, rahter than this object, but I'm tired and it's staying like this for now.
