

import 'package:flutter/material.dart';

import '../models/mm_game_model.dart';
import 'answer.dart';
import 'guess.dart';
import 'guess_result.dart';

class MasterMindGame extends StatelessWidget {
  final MasterMindGameState mmGameState;
  const MasterMindGame( this.mmGameState, {Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mmGameState.answer==null) return const Text('Answer must be set');

    List<Row>? guessRows = [];
    for (var i=0; i<mmGameState.guesses.length; i++) {
      guessRows.add(
        Row(children: [
          const Expanded(
            flex: 1,
            child: Text('Guess index??'),
          ),
          Expanded(
            flex: 1,
            child: Guess(mmGameState.guesses[i]),
          ),
          Expanded(
            flex: 1,
            child: GuessResult(mmGameState.guessResults[i]),
          ),
        ],)
      );
    }

    return Column(children: [
      Row(children: [
        const Expanded(
          flex: 1,
          child: Text('Answer'),
        ),
        Expanded(
          flex: 1,
          child: Answer(mmGameState.answer!),
        ),
        const Expanded(
          flex: 1,
          child: Text('----------'),
        ),
      ],),
      ...guessRows,
    ],);
  }
}
