

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mm_guesser_cubit.dart';
import '../models/mm_guess_result.dart';
import 'guess.dart';
import 'guess_result.dart';

class MasterMindGuesser extends StatelessWidget {
  const MasterMindGuesser({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuesserCubit, GuesserState>(
      listener: (context, state) {
        // do some side effect
      },
      builder: (context, state) {


        List<Row>? guessRows = [];
        for (var i=0; i<state.guessSet.guesses.length; i++) {
          guessRows.add(
            Row(children: [
              const Spacer( flex: 1 ),
              Checkbox(
                value: true, //rememberMe,
                onChanged: (val) {
                  print(val);
                },
              ),
              Expanded(
                flex: 2,
                child: Text('Guess ${i+1}', style: const TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 12.0, ),),
              ),
              Expanded(
                flex: 6,
                child: Guess(state.guessSet.guesses[i]),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: (state.guessSet.guessResults.asMap().containsKey(i)) ?  
                        GuessResult(state.guessSet.guessResults[i]) : 
                        GuessResult(MasterMindGuessResult()),
              ),
              const Spacer( flex: 1 ),
            ],)
          );
        }


        return Column(children: [
            const SizedBox(height: 40),
            ...guessRows,
        ]);

      }
    );
  }
  
}

