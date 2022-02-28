
import 'package:flutter/material.dart';

import '../models/mm_guess_result.dart';
import '../models/mm_num_slots.dart';

enum GuessResultValue {
  white,
  black,
  none,
}

class _SmallCircle extends StatelessWidget {
  final GuessResultValue guessResult;
  final Function(GuessResultValue) callback;
  const _SmallCircle( { required this.guessResult, required this.callback } );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          callback( guessResult );
        },
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: (guessResult==GuessResultValue.black) ? Colors.black :
                  (guessResult==GuessResultValue.white) ? Colors.white :
                  Colors.grey,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blueAccent)
          ),
        ),
      ),
    );
  }
}

class GuessResult extends StatelessWidget {
  final MasterMindGuessResult guess;
  final Function(GuessResultValue) onTap;
  const GuessResult( { required this.guess, required this.onTap, Key? key} ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int remaining = NUMBER_OF_COLOUR_SLOTS - guess.rightInRightSpot - guess.rightInWrongSpot;
    List<_SmallCircle> answerCircles = [
      ...List.filled(guess.rightInRightSpot, _SmallCircle(guessResult: GuessResultValue.black, callback: onTap )),
      ...List.filled(guess.rightInWrongSpot, _SmallCircle(guessResult: GuessResultValue.white, callback: onTap )),
      ...List.filled(remaining, _SmallCircle(guessResult: GuessResultValue.none, callback: onTap )),
    ];
    //print('displaying data for $guess');
    return Row(children: answerCircles);
  }
  
}
