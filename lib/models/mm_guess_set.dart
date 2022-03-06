

import 'mm_colours.dart';
import 'mm_guess_result.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


class MasterMindGuessSet {
  List<MasterMindColourSet>? _guesses;
  List<MasterMindGuessResult>? _guessResults;

  List<MasterMindColourSet> get guesses => _guesses!;
  List<MasterMindGuessResult> get guessResults { 
    var doctoredResults = _guessResults!;
    for (var i = 0; i < _guesses!.length - doctoredResults.length; i++) {
        doctoredResults.add(MasterMindGuessResult());
    }
    return doctoredResults;
  }

  MasterMindGuessSet({
    guesses,
    guessResults,
  }) {
    _guesses = guesses ?? [];
    _guessResults = guessResults ?? [];
  }

  addGuess( MasterMindColourSet guess ) {
    _guesses!.add(guess);
  }

  addGuessAndGuessResult( { required MasterMindColourSet guess, required MasterMindGuessResult guessResult } ) {
    _guesses!.add(guess);
    _guessResults!.add(guessResult);
  }

  String guessesString() {
    var string = '';
    for (var i=0; i<_guesses!.length; i++) {
      string += "  Guess $i : ${_guesses![i]} -- ${_guessResults![i]} \n";
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
