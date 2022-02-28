
import 'package:flutter_test/flutter_test.dart';
import 'package:master_mind/master_mind_ai.dart';
import 'package:master_mind/models/mm_colours.dart';
import 'package:master_mind/models/mm_guess_result.dart';
import 'package:master_mind/models/mm_guess_set.dart';


var redRedRedBlackWhite = MasterMindColourSet([
  MMCols.red, MMCols.red, MMCols.red,
  MMCols.black,
  MMCols.white,
]);

var allRed = MasterMindColourSet(
  List.filled(5, MMCols.red)
);

var wwggp = MasterMindColourSet([
  MMCols.white, MMCols.white,
  MMCols.green, MMCols.green,
  MMCols.pink
]);

var yyggr = MasterMindColourSet([
  MMCols.yellow, MMCols.yellow,
  MMCols.green, MMCols.green,
  MMCols.red,
]);


void main() {

  print('THIS WILL BE SLOOOOOOOOOOOOOOOOOOOOOOOW!   Lots of processing in this test');
  group('Testing the MasterMindAi class', () {

    test('Should get one match one a guess of all red', () {
      var guessSet = MasterMindGuessSet(
        guesses: [allRed],
        guessResults: [ MasterMindGuessResult( rightInRight: 5 ) ]
      );
      var matchingAnswers = MasterMindAi.fetchAllMatchingAnswers( guessSet );
      expect(matchingAnswers.length, 1);
    });


  });

}

