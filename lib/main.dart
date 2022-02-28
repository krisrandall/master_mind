import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/mm_guesser_cubit.dart';
import 'master_mind_ai.dart';
import 'widgets/mm_ai_guesser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Master Mind',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<GuesserCubit>(
        create: (context) => GuesserCubit( MasterMindAi.getInitialGuessSet(6) ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Master Mind AI'),
          ),
          body: const MasterMindGuesser(),
        ),
      ),
    );
  }
}





/*
// This is not used by the guesser - it was an earlier iteration of the game

//import 'widgets/mm_game.dart';


class MasterMind extends StatelessWidget {
  const MasterMind({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var g = MasterMindGameState();
    g.setAnswer( MasterMindColourSet([
      MMCols.white,
      MMCols.red,
      MMCols.green,
      MMCols.red,
      MMCols.blue,
    ]) );

    g.makeGuess( MasterMindColourSet([
      MMCols.white,
      MMCols.black,
      MMCols.red,
      MMCols.green,
      MMCols.blue,
    ]));

    g.makeGuess( MasterMindColourSet([
      MMCols.orange,
      MMCols.pink,
      MMCols.red,
      MMCols.green,
      MMCols.blue,
    ]));

    g.makeGuess( MasterMindColourSet([
      MMCols.yellow,
      MMCols.red,
      MMCols.white,
      MMCols.black,
      MMCols.blue,
    ]));

    g.makeGuess( MasterMindColourSet([
      MMCols.pink,
      MMCols.white,
      MMCols.pink,
      MMCols.black,
      MMCols.green,
    ]));


    return MasterMindGame(g);

  }
}

*/
