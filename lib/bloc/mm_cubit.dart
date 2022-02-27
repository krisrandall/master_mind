
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_mind/models/mm_colours.dart';
import '../models/mm_game_model.dart';

class GameCubit extends Cubit<MasterMindGameState> {

  GameCubit() : super( MasterMindGameState() );

  setAnswer( MasterMindColourSet _answer ) {
    state.setAnswer(_answer);
  }

  makeGuess( MasterMindColourSet _guess ) {
    state.makeGuess(_guess);
  }


}
