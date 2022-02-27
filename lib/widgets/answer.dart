
import 'package:flutter/material.dart';
import 'package:master_mind/models/mm_colours.dart';

import 'guess.dart';

// it's exactly the same as a Guess
class Answer extends Guess {
  const Answer(MasterMindColourSet answer, {Key? key}) : super(answer, key: key);
}
