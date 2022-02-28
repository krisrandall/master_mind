
import 'package:flutter/material.dart';

import '../models/mm_guess_result.dart';
import '../models/mm_num_slots.dart';

enum AnswerResult {
  white,
  black,
  none,
}

class _SmallCircle extends StatelessWidget {
  final AnswerResult answerResult;
  const _SmallCircle( this.answerResult );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: (answerResult==AnswerResult.black) ? Colors.black :
                (answerResult==AnswerResult.white) ? Colors.white :
                Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blueAccent)
        ),
      ),
    );
  }
}

class GuessResult extends StatelessWidget {
  final MasterMindGuessResult guess;
  const GuessResult( this.guess, {Key? key} ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int remaining = NUMBER_OF_COLOUR_SLOTS - guess.rightInRightSpot - guess.rightInWrongSpot;
    List<_SmallCircle> answerCircles = [
      ...List.filled(guess.rightInRightSpot, const _SmallCircle(AnswerResult.black)),
      ...List.filled(guess.rightInWrongSpot, const _SmallCircle(AnswerResult.white)),
      ...List.filled(remaining, const _SmallCircle(AnswerResult.none)),
    ];
    //print('displaying data for $guess');
    return Row(children: answerCircles);
  }
  
}
