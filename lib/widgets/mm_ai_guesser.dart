

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mm_guesser_cubit.dart';
import '../models/mm_guess_result.dart';
import 'answer.dart';
import 'guess.dart';
import 'guess_result.dart';
import 'instructions.dart';

class MasterMindGuesser extends StatelessWidget {
  const MasterMindGuesser({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var guesserCubit = context.read<GuesserCubit>();

    return BlocConsumer<GuesserCubit, GuesserState>(
      listener: (context, state) {
        // do some side effect
      },
      builder: (context, state) {

        print('     building again with $state');

        List<Row>? guessRows = [];
        for (var i=0; i<state.guessSet.guesses.length; i++) {
          guessRows.add(
            Row(children: [
              const Spacer( flex: 1 ),
              Checkbox(
                value: state.activeGuessRows![i]==true,
                onChanged: (val) {
                  print('row $i is now $val');
                  guesserCubit.toggleGuessRow(i);
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
                child: 
                    (state.activeGuessRows![i]==true) ?
                      (state.guessSet.guessResults.asMap().containsKey(i)) ?  
                        GuessResult(
                          guess: state.guessSet.guessResults[i], 
                          onTap: (GuessResultValue g) {
                            guesserCubit.togglePeg(i, g);
                          },
                        ) : 
                        GuessResult(
                          guess: MasterMindGuessResult(),
                          onTap: (GuessResultValue g) {
                            if (g!=GuessResultValue.none) throw("what!?!  - how can a blank guess result value be anything other than none?!? - this is just a totally random code intergrity check");
                            guesserCubit.togglePeg(i, GuessResultValue.none);
                          },
                        ) :
                      const Text('-'),
              ),
              const Spacer( flex: 1 ),
            ],)
          );
        }

        
        return Column(children: [

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(40.0),
              child: (state.possibleAnswers==null) ? 
                    const Instructions() : 
                    (state.possibleAnswers!.length!=1) ?
                      Text("There are ${state.possibleAnswers!.length} possible answers") :
                      Answer(state.possibleAnswers![0].guess),
            ),

            const SizedBox(height: 10),

            ...guessRows,

            const SizedBox(height: 40),

            OutlinedButton(
              child: const Text('Check Guess'),
              onPressed: () {
                print('about to check the guess!!');
              },
            ),

        ]);

      }
    );
  }
  
}

