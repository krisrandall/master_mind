

import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
        "Toggle on or off the guesses to include them, and toggle the pegs on the right to change the guess result.\n\n" +
        "(Clicking on an empty (grey) peg will add another black (meaning Right in the Right spot) peg, " +
        "clicking on a black peg will change a black (Right in the Right spot) peg to a white (right in the Wrong spot) peg, " +
        "and clicking a white peg will remove a white (right in the Wrong spot) peg.)\n\n",
      style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 12.0, ),
    );
  }

}


