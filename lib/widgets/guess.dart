
import 'package:flutter/material.dart';
import '../models/mm_colours.dart';

class _BigCircle extends StatelessWidget {
  final MMCols pegColour;
  _BigCircle( this.pegColour );

  final Map<MMCols, Color> _masterMindColours = {
    MMCols.white: Colors.white,
    MMCols.black: Colors.black,
    MMCols.green: Colors.green,
    MMCols.red: Colors.red,
    MMCols.pink: Colors.pink,
    MMCols.orange: Colors.orange,
    MMCols.blue: Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: _masterMindColours[pegColour],
        shape: BoxShape.circle,
      ),);
  }
}

class Guess extends StatelessWidget {
  final MasterMindSColourSet guess;
  const Guess( this.guess, {Key? key} ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<_BigCircle> pegs = guess.cols.map((c) => _BigCircle(c)).toList();
    return Row(children: pegs);
  }
}
