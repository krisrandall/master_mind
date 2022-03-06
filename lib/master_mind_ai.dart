
// it really isn't an AI (it's not machine learning),
// it's a brute force test of the theory I'm working on developing

import 'models/mm_colours.dart';
import 'models/mm_game_model.dart';
import 'models/mm_guess_set.dart';

class MasterMindAi {

  // would be nice if this were async .. but not a priority right now .. 
  static List<MasterMindColourSet> fetchAllMatchingAnswers( MasterMindGuessSet guessSet ) {

    const quitOutAt = 10000000000;
    List<MasterMindColourSet> matchingAnswers = [];

    // Loop through every possible answer
    outerloop:
    for (var c1=0; c1<MMCols.values.length; c1++) {
      for (var c2=0; c2<MMCols.values.length; c2++) {
        for (var c3=0; c3<MMCols.values.length; c3++) {
          for (var c4=0; c4<MMCols.values.length; c4++) {
            for (var c5=0; c5<MMCols.values.length; c5++) {

              var allRed = false;
              var answerToTry = MasterMindColourSet([
                MMCols.values[c1],
                MMCols.values[c2],
                MMCols.values[c3],
                MMCols.values[c4],
                MMCols.values[c5],
              ]);

             // print('trying $c1 $c2 $c3 $c4 $c5');

              var game = MasterMindGameState();
              game.setAnswer(answerToTry);

              if (
                (MMCols.values[c1]==MMCols.red) &&
                (MMCols.values[c2]==MMCols.red) &&
                (MMCols.values[c3]==MMCols.red) &&
                (MMCols.values[c4]==MMCols.red) &&
                (MMCols.values[c5]==MMCols.red) 
              ) {
                allRed = true;
                print('ALL RED!!    NB: ${game.guessSet.guesses.length} vs ${guessSet.guesses.length}');
              }


              for (var i=0; i<guessSet.guesses.length; i++) {
                if (allRed) print(' .. $i ..');
                var res = game.makeGuess(guessSet.guesses[i]);
                if (allRed) print(res);
              }

              if (allRed) print('       NOWB: ${game.guessSet.guesses.length} vs ${guessSet.guesses.length}');
              if (c1==0 && c2==0 && c3==0 && c4==0 && c5==0) {
                print(' First run :${game.guessSet.guesses.length} vs ${guessSet.guesses.length}');
              }

              // Do the guess results for this answer match the guess results we passed in?
              // Hard coded to 5 pegs, and 6 guesses (max)
              if ( 
                (game.guessSet.guessResults[0].rightInRightSpot == guessSet.guessResults[0].rightInRightSpot) &&
                (game.guessSet.guessResults[1].rightInRightSpot == guessSet.guessResults[1].rightInRightSpot) &&
                (game.guessSet.guessResults[2].rightInRightSpot == guessSet.guessResults[2].rightInRightSpot) &&
                (game.guessSet.guessResults[3].rightInRightSpot == guessSet.guessResults[3].rightInRightSpot) &&
                (game.guessSet.guessResults[4].rightInRightSpot == guessSet.guessResults[4].rightInRightSpot) &&
                (game.guessSet.guessResults[5].rightInWrongSpot == guessSet.guessResults[5].rightInWrongSpot) 
                &&
                (game.guessSet.guesses[0].cols[0] == guessSet.guesses[0].cols[0]) &&
                (game.guessSet.guesses[1].cols[0] == guessSet.guesses[1].cols[0]) &&
                (game.guessSet.guesses[2].cols[0] == guessSet.guesses[2].cols[0]) &&
                (game.guessSet.guesses[3].cols[0] == guessSet.guesses[3].cols[0]) &&
                (game.guessSet.guesses[4].cols[0] == guessSet.guesses[4].cols[0]) &&
                (game.guessSet.guesses[5].cols[0] == guessSet.guesses[5].cols[0]) &&

                (game.guessSet.guesses[0].cols[1] == guessSet.guesses[0].cols[1]) &&
                (game.guessSet.guesses[1].cols[1] == guessSet.guesses[1].cols[1]) &&
                (game.guessSet.guesses[2].cols[1] == guessSet.guesses[2].cols[1]) &&
                (game.guessSet.guesses[3].cols[1] == guessSet.guesses[3].cols[1]) &&
                (game.guessSet.guesses[4].cols[1] == guessSet.guesses[4].cols[1]) &&
                (game.guessSet.guesses[5].cols[1] == guessSet.guesses[5].cols[1]) &&

                (game.guessSet.guesses[0].cols[2] == guessSet.guesses[0].cols[2]) &&
                (game.guessSet.guesses[1].cols[2] == guessSet.guesses[1].cols[2]) &&
                (game.guessSet.guesses[2].cols[2] == guessSet.guesses[2].cols[2]) &&
                (game.guessSet.guesses[3].cols[2] == guessSet.guesses[3].cols[2]) &&
                (game.guessSet.guesses[4].cols[2] == guessSet.guesses[4].cols[2]) &&
                (game.guessSet.guesses[5].cols[2] == guessSet.guesses[5].cols[2]) &&

                (game.guessSet.guesses[0].cols[3] == guessSet.guesses[0].cols[3]) &&
                (game.guessSet.guesses[1].cols[3] == guessSet.guesses[1].cols[3]) &&
                (game.guessSet.guesses[2].cols[3] == guessSet.guesses[2].cols[3]) &&
                (game.guessSet.guesses[3].cols[3] == guessSet.guesses[3].cols[3]) &&
                (game.guessSet.guesses[4].cols[3] == guessSet.guesses[4].cols[3]) &&
                (game.guessSet.guesses[5].cols[3] == guessSet.guesses[5].cols[3]) &&

                (game.guessSet.guesses[0].cols[4] == guessSet.guesses[0].cols[4]) &&
                (game.guessSet.guesses[1].cols[4] == guessSet.guesses[1].cols[4]) &&
                (game.guessSet.guesses[2].cols[4] == guessSet.guesses[2].cols[4]) &&
                (game.guessSet.guesses[3].cols[4] == guessSet.guesses[3].cols[4]) &&
                (game.guessSet.guesses[4].cols[4] == guessSet.guesses[4].cols[4]) &&
                (game.guessSet.guesses[5].cols[4] == guessSet.guesses[5].cols[4]) 

              ){
              //if (guessHash == hashOfGuessSet) {
                print('A MATCH !!!!!   NB: ${game.guessSet.guessResults.length} vs ${guessSet.guessResults.length}');
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