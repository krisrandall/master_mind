
import 'package:flutter_test/flutter_test.dart';
import 'package:master_mind/bloc/mm_cubit.dart';
import 'package:master_mind/models/mm_colours.dart';
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
      expect(guessRes, MasterMindGuessResult(rightInRightSpot: NUMBER_OF_COLOUR_SLOTS) );
    });
    
    test('Guess 3 right with all reds as guess', () {
      var gc = GameCubit();
      gc.setAnswer(redRedRedBlackWhite);
      var guessRes = gc.makeGuess(allRed);
      expect(guessRes, MasterMindGuessResult(rightInRightSpot: 3));
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
      expect(guessRes, MasterMindGuessResult(rightInWrongSpot: 1));
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
