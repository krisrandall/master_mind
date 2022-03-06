

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mm_guesser_cubit.dart';
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

        List<Row>? guessRows = [];
        for (var i=0; i<state.guessSet.guesses.length; i++) {
          guessRows.add(
            Row(children: [
              const Spacer( flex: 1 ),
              Checkbox(
                value: state.activeGuessRows![i]==true,
                onChanged: (val) {
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
                        GuessResult(
                          guess: state.guessSet.guessResults[i], 
                          onTap: (GuessResultValue g) {
                            guesserCubit.togglePeg(i, g);
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

            Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: 
                      (state.checkingAnswers==true) ?
                        const Text('Checking answers...', style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 20.0, ),) :
                        (state.possibleAnswers==null) ? 
                          const Instructions() : 
                          (state.possibleAnswers!.length!=1) ?
                            Text("There are ${state.possibleAnswers!.length} possible answers") :
                            Answer(state.possibleAnswers![0]),
                ),
            ),

            const SizedBox(height: 10),

            ...guessRows,

            const SizedBox(height: 40),

            OutlinedButton(
              child: const Text('Check Guess'),
              onPressed: () {
                guesserCubit.checkGuesses();
              },
            ),

            const Spacer(),

            (state.possibleAnswers!=null&& state.possibleAnswers!.length<6 && state.possibleAnswers!.length>1) ?
              Column(children: state.possibleAnswers!.map((e) => Answer(e),).toList() ):
              const Spacer()

        ]);

      }
    );
  }
  
}

