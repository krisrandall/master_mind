
import 'package:flutter_test/flutter_test.dart';
import 'package:master_mind/bloc/mm_cubit.dart';
import 'package:master_mind/models/mm_colours.dart';


var redRedRedBlackWhite = MasterMindSColourSet([
  MMCols.red, MMCols.red, MMCols.red,
  MMCols.black,
  MMCols.white,
]);

var allRed = MasterMindSColourSet(
  List.filled(5, MMCols.red)
);

var wwggp = MasterMindSColourSet([
  MMCols.white, MMCols.white,
  MMCols.green, MMCols.green,
  MMCols.pink
]);

void main() {

  group('General Master Mind Tests', () {

    test('Should throw if check guess before set Answer', () async {
      var gc = GameCubit();
      expect(() => gc.makeGuess(allRed), throwsA(Exception()));
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
