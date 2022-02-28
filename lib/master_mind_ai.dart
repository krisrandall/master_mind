
// it really isn't an AI (it's not machine learning),
// it's a brute force test of the theory I'm working on developing

import 'models/mm_colours.dart';
import 'models/mm_game_model.dart';
import 'models/mm_guess_set.dart';

class MasterMindAi {

  // would be nice if this were async .. but not a priority right now .. 
  static List<MasterMindColourSet> fetchAllMatchingAnswers( MasterMindGuessSet guessSet ) {

    const quitOutAt = 10000000000;

    var hashOfGuessSet = guessSet.uniqueHashOfGuesses();
    List<MasterMindColourSet> matchingAnswers = [];

    // Loop through every possible answer
    outerloop:
    for (var c1=0; c1<MMCols.values.length; c1++) {
      for (var c2=0; c2<MMCols.values.length; c2++) {
        for (var c3=0; c3<MMCols.values.length; c3++) {
          for (var c4=0; c4<MMCols.values.length; c4++) {
            for (var c5=0; c5<MMCols.values.length; c5++) {

              var answerToTry = MasterMindColourSet([
                MMCols.values[c1],
                MMCols.values[c2],
                MMCols.values[c3],
                MMCols.values[c4],
                MMCols.values[c5],
              ]);

              var game = MasterMindGameState();
              game.setAnswer(answerToTry);

              for (var i=0; i<guessSet.guesses.length; i++) {
                game.makeGuess(guessSet.guesses[i]);
              }

              // Do the guess results for this answer match the guess results we passed in?
              var guessHash = game.uniqueHashOfGuesses();
              if (guessHash == hashOfGuessSet) {
                matchingAnswers.add(game.answer!);
              }

              if (matchingAnswers.length>quitOutAt) {
                break outerloop;
              }
            }
          }
        }
      }
    }

    return matchingAnswers;
  }
  


  /// based on the number of guesses involved, 
  static List<MasterMindColourSet> getInitialGuessSet(int numGuesses) {
    List<MasterMindColourSet> guessSet = [];
    var currentGuess = getNextGuess(null);
    for (var i=0; i<numGuesses; i++) {
      guessSet.add(currentGuess);
      currentGuess = getNextGuess(currentGuess);
    }
    return guessSet;
  }


  /// Using the "Master Mind AI Algorythm" generate a guess based on the current guess, or pass in null to start the guess set
  static MasterMindColourSet getNextGuess(MasterMindColourSet? current) {
    // Note that this function assumes 5 peg holes !, and the standard set of colours

    current ??= MasterMindColourSet([
        MMCols.values[0],
        MMCols.values[1],
        MMCols.values[2],
        MMCols.values[3],
        MMCols.values[4],
      ]);

    int getNextIndexAndWrap(int currentIndex) {
      currentIndex++;
      if (currentIndex>=MMCols.values.length) currentIndex = 0;
      return currentIndex;
    }

    int getIndexOfColEnum(MMCols col) {
      // I feel like there should be a way to do this in Flutter - but I ain't found it
      if (col==MMCols.white) return 0;
      if (col==MMCols.black) return 1;
      if (col==MMCols.red) return 2;
      if (col==MMCols.green) return 3;
      if (col==MMCols.orange) return 4;
      if (col==MMCols.blue) return 5;
      if (col==MMCols.yellow) return 6;
      if (col==MMCols.pink) return 7;
      throw('somehow your colour $col didn\'t match !!');
    }

    // so - this works by starting counting from the one colour after the last in the current set
    var colourIndex = getIndexOfColEnum(current.cols[current.cols.length-1]);
    colourIndex = getNextIndexAndWrap(colourIndex);

    List<MMCols> colours = [];
    colours.add(MMCols.values[colourIndex]);
    colourIndex = getNextIndexAndWrap(colourIndex);
    colours.add(MMCols.values[colourIndex]);
    colourIndex = getNextIndexAndWrap(colourIndex);
    colours.add(MMCols.values[colourIndex]);
    colourIndex = getNextIndexAndWrap(colourIndex);
    colours.add(MMCols.values[colourIndex]);
    colourIndex = getNextIndexAndWrap(colourIndex);
    colours.add(MMCols.values[colourIndex]);
    colourIndex = getNextIndexAndWrap(colourIndex);

    return MasterMindColourSet(colours);

    
  }

}