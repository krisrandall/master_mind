
import 'package:flutter/material.dart';

import 'mm_num_slots.dart';

enum MMCols {
  white,
  black,
  green,
  red,
  pink,
  orange,
  blue,
}

List<Color> _masterMindColours = {
  MMCols.white: Colors.white,
  MMCols.black: Colors.black,
  MMCols.green: Colors.green,
  MMCols.red: Colors.red,
  MMCols.pink: Colors.pink,
  MMCols.orange: Colors.orange,
  MMCols.blue: Colors.blue,
} as List<Color>;

class MasterMindSColourSet {
  late List<MMCols> cols;

  MasterMindSColourSet(List<MMCols> _cols) {
    // check exactly the right number of colours
    assert(_cols.length == NUMBER_OF_COLOUR_SLOTS);
    // check each one of the colours is from the valid masterMindColours
    for (var i=0; i<cols.length; i++) {
      var gotForThisOne = false;
      for (var j=0; j<_masterMindColours.length; j++) {
        if (_cols[i]==MMCols.values[j]) gotForThisOne = true;
      }
      assert(gotForThisOne);
    }
    cols = _cols;
  }
  
  //int get length => cols.length;  // cool idea, but also misleading, makes this class seem like the list
} 
