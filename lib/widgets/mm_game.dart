

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
    for (var i=0; i<mmGameState.guessSet.guesses.length; i++) {
      guessRows.add(
        Row(children: [
          const Spacer(),
          Expanded(
            flex: 1,
            child: Text('Guess ${i+1}', style: const TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 30.0, ),),
          ),
          Expanded(
            flex: 2,
            child: Guess(mmGameState.guessSet.guesses[i]),
          ),
          Expanded(
            flex: 1,
            child: GuessResult(mmGameState.guessSet.guessResults[i]),
          ),
          const Spacer(),
        ],)
      );
    }

    return Column(children: [
      Row(children: [
        const Spacer(),
        const Expanded(
          flex: 1,
          child: Text('Answer', style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 30.0, ),),
        ),
        Expanded(
          flex: 2,
          child: Answer(mmGameState.answer!),
        ),
        const Expanded(
          flex: 1,
          child: Text(''),
        ),
        const Spacer(),
      ],),
      const SizedBox(height: 40),
      ...guessRows,
    ],);
  }
}
