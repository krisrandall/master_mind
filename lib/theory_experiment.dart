
import 'models/mm_colours.dart';
import 'models/mm_game_model.dart';

/// 
/// The theory is like this :
/// That a standard set of initial guesses which is systematic in going
/// through each of the colours, will guarantee the answer.
/// 
/// If this is true, I should be able to do this :
///  1. Make X number of these systematic guesses
///  2. Go through every single possible answer
///      (like so, RRRRR, RRRRY, RRRYR .. something like that)
///  3. Check if I get the same guess results across all my X guesses
///     more than once while going through every possible answer

// The rest of the code allows more colours, and more peg holes to be added,
// This one assumes the standard 8 cols, and 5 peg holes for simplicity


void main() {

  const numGuessesToMake = 6; // can experiment with changing this 

  // ------------------------------------------------------------


  var currentGuess = getNextGuess(null);
  List<MasterMindColourSet> guessesSet = [];
  for (var i=0; i<numGuessesToMake; i++) {
    guessesSet.add(currentGuess);
    currentGuess = getNextGuess(currentGuess);
  }

  // ------------------------------------------------------------



  var compareToGame = MasterMindGameState();
  compareToGame.setAnswer(MasterMindColourSet([
      MMCols.red,
      MMCols.red,
      MMCols.red,
      MMCols.yellow,
      MMCols.pink,
  ]));
  for (var i=0; i<guessesSet.length; i++) {
    compareToGame.makeGuess(guessesSet[i]);
  }
  var compareToGuessHash = compareToGame.uniqueHashOfGuesses();
  
  print("\n\n $compareToGame \n Checking the solution ${compareToGame.answer} , when I made ${guessesSet.length} guesses , for other solutions that would give the same exact result : ");

  var numMatchesToCompare = 0;


  // ------------------------------------------------------------


  var answerCounter = 0;
  List<String> guessSetHashes = [];
  var howManyDuplicateGuessSets = 0;

  // Loop through every possible answer
  for (var c1=0; c1<MMCols.values.length; c1++) {
    for (var c2=0; c2<MMCols.values.length; c2++) {
      for (var c3=0; c3<MMCols.values.length; c3++) {
        for (var c4=0; c4<MMCols.values.length; c4++) {
          for (var c5=0; c5<MMCols.values.length; c5++) {

            var answer = MasterMindColourSet([
              MMCols.values[c1],
              MMCols.values[c2],
              MMCols.values[c3],
              MMCols.values[c4],
              MMCols.values[c5],
            ]);

            var game = MasterMindGameState();
            game.setAnswer(answer);

            answerCounter++;

            for (var i=0; i<guessesSet.length; i++) {
              game.makeGuess(guessesSet[i]);
            }

            //print(game);

            /* This code for checking all against all

            // check this guess value already exists
            var guessHash = game.uniqueHashOfGuesses();
            for (var i=0; i<guessSetHashes.length; i++) {
              if (guessSetHashes[i]==guessHash) {
                //print('    ONE ALREADY EXISTS !!');
                howManyDuplicateGuessSets++;
              }
            }
            guessSetHashes.add(guessHash);

            */

            /* this code for checking current against compareToAnswer */
            var guessHash = game.uniqueHashOfGuesses();
            if (guessHash == compareToGuessHash) {
              numMatchesToCompare++;
              print('\n  Answer found with matching solution results for $game');
            }

          }
        }
      }
    }
  }

  //print('\n\n ** In $answerCounter possible answers, THERE ARE $howManyDuplicateGuessSets DUPLICATES WITH $numGuessesToMake GUESSES ** \n\n');
  print('\n\n ** In $answerCounter possible answers, there are ${numMatchesToCompare-1} answers that are the same as ${compareToGame.answer} \n\n');
  
}



MasterMindColourSet getNextGuess(MasterMindColourSet? current) {

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



