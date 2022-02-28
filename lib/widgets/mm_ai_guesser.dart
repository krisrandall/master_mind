

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mm_guesser_cubit.dart';
import '../models/mm_guess_result.dart';
import 'guess.dart';
import 'guess_result.dart';

class MasterMindGuesser extends StatefulWidget {
  const MasterMindGuesser({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MasterMindGuesserState();
}

class _MasterMindGuesserState extends State<MasterMindGuesser> {
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
              const Spacer(),
              Checkbox(
                value: true, //rememberMe,
                onChanged: (val) {
                  print(val);
                },
              ),
              Expanded(
                flex: 1,
                child: Text('Guess ${i+1}', style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 30.0, ),),
              ),
              Expanded(
                flex: 2,
                child: Guess(state.guessSet.guesses[i]),
              ),
              Expanded(
                flex: 1,
                child: (state.guessSet.guessResults.asMap().containsKey(i)) ?  
                        GuessResult(state.guessSet.guessResults[i]) : 
                        GuessResult(MasterMindGuessResult()),
              ),
              const Spacer(),
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

