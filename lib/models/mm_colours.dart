
import 'mm_num_slots.dart';

enum MMCols {
  white,
  black,
  red,
  green,
  orange,
  blue,
  yellow,
  pink,
}

class MasterMindColourSet {
  late List<MMCols> cols;

  MasterMindColourSet(List<MMCols> _cols) {
    assert(_cols.length == NUMBER_OF_COLOUR_SLOTS);
    cols = _cols;
  }
  
  //int get length => cols.length;  // cool idea, but also misleading, makes this class seem like the list
} 
