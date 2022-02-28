
import 'package:flutter_test/flutter_test.dart';
import 'package:master_mind/bloc/mm_cubit.dart';
import 'package:master_mind/models/mm_colours.dart';
import 'package:master_mind/models/mm_game_model.dart';
import 'package:master_mind/models/mm_guess_result.dart';
import 'package:master_mind/models/mm_num_slots.dart';


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

  group('General Master Mind Tests:', () {

    test('Should throw if check guess before set Answer', () async {
      var gc = GameCubit();
      expect( () => gc.makeGuess(allRed), throwsA('No answer set, call setAnswer before calling makeGuess') );
    });

    test('Guess right returns all correct', () {
      var gc = GameCubit();
      gc.setAnswer(redRedRedBlackWhite);
      var guessRes = gc.makeGuess(redRedRedBlackWhite);
      expect(guessRes, MasterMindGuessResult(rightInRight: NUMBER_OF_COLOUR_SLOTS) );
    });
    
    test('Guess 3 right with all reds as guess', () {
      var gc = GameCubit();
      gc.setAnswer(redRedRedBlackWhite);
      var guessRes = gc.makeGuess(allRed);
      expect(guessRes, MasterMindGuessResult(rightInRight: 3));
    });

    test('Guess all wrong', () {
      var gc = GameCubit();
      gc.setAnswer(allRed);
      var guessRes = gc.makeGuess(wwggp);
      expect(guessRes, MasterMindGuessResult());
    });

    test('One right in wrong', (){
      var gc = GameCubit();
      gc.setAnswer(redRedRedBlackWhite);
      var guessRes = gc.makeGuess(wwggp);
      expect(guessRes, MasterMindGuessResult(rightInWrong: 1));
    });

    test('Another right in wrong', (){
      var gc = GameCubit();
      gc.setAnswer(wwggp);
      var guessRes = gc.makeGuess(redRedRedBlackWhite);
      expect(guessRes, MasterMindGuessResult(rightInWrong: 1));
    });


    test('One right in wrong - with multiple in guess', (){
      var gc = GameCubit();
      gc.setAnswer(yyggr);
      var guessRes = gc.makeGuess(redRedRedBlackWhite);
      expect(guessRes, MasterMindGuessResult(rightInWrong: 1));
    });

    test('One right in wrong - with multiple in answer', (){
      var gc = GameCubit();
      gc.setAnswer(redRedRedBlackWhite);
      var guessRes = gc.makeGuess(yyggr);
      expect(guessRes, MasterMindGuessResult(rightInWrong: 1));
    });

    test('Specific case that was wrong - should be 2 right of each', () {
      var g = MasterMindGameState();
      g.setAnswer( MasterMindColourSet([
        MMCols.white,
        MMCols.red,
        MMCols.green,
        MMCols.red,
        MMCols.blue,
      ]) );

      g.makeGuess( MasterMindColourSet([
        MMCols.white,
        MMCols.black,
        MMCols.red,
        MMCols.green,
        MMCols.blue,
      ]));

      expect(g.guessSet.guessResults[0], MasterMindGuessResult(rightInWrong: 2, rightInRight: 2));
    });


  });


/*
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  */

}
