
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
  
  @override
  toString() {
    var string = "  ";
    for (var i=0; i<cols.length; i++) {
      string += " ${cols[i].toString()},";
    }
    return string;
  }

}
