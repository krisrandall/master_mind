
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
    MMCols.pink: const Color.fromARGB(255, 199, 106, 137),
    MMCols.orange: Colors.orange,
    MMCols.blue: Colors.blue,
    MMCols.yellow: Colors.yellow,
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
         width: 60.0,
         height: 60.0,
        decoration: BoxDecoration(
          color: _masterMindColours[pegColour],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blueAccent)
        ),
      ),
    );
  }
}

class Guess extends StatelessWidget {
  final MasterMindColourSet guess;
  const Guess( this.guess, {Key? key} ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<_BigCircle> pegs = guess.cols.map((c) => _BigCircle(c)).toList();
    return Row(children: pegs);
  }

  List<MMCols> get pegs =>  guess.cols;
}
