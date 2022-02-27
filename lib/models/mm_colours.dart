
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

class MasterMindSColourSet {
  late List<MMCols> cols;

  MasterMindSColourSet(List<MMCols> _cols) {
    // check exactly the right number of colours
    assert(_cols.length == NUMBER_OF_COLOUR_SLOTS);
    // check each one of the colours is from the valid masterMindColours
    for (var i=0; i<_cols.length; i++) {
      var gotForThisOne = false;
      for (var j=0; j<NUMBER_OF_COLOUR_SLOTS; j++) {
        if (_cols[i]==MMCols.values[j]) gotForThisOne = true;
      }
      assert(gotForThisOne);
    }
    cols = _cols;
  }
  
  //int get length => cols.length;  // cool idea, but also misleading, makes this class seem like the list
} 
