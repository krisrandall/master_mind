

import 'package:flutter/material.dart';

import '../models/mm_game_model.dart';
import 'answer.dart';
import 'guess.dart';
import 'guess_result.dart';

class MasterMindGame extends StatelessWidget {
  MasterMindGameState mmGameState;
  MasterMindGame( this.mmGameState );

  @override
  Widget build(BuildContext context) {
    if (mmGameState.answer==null) return const Text('Answer must be set');

    List<Row> guessRows = mmGameState.guesses.map((e) {
      return Row(children: [
        const Text('Guess index??'),
        Guess(e),
        const Text('TODO !!'), // GuessResult(e.)
      ],);
    }).toList();
    return Column(children: [
      Row(children: [
        const Text('Answer'),
        Answer(mmGameState.answer!),
        const Text('----------'),
      ],),

    ],);
  }
}
