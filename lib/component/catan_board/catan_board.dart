library catan_board_component;

import 'package:catan_randomizer/component/catan_hex/catan_hex.dart';
import 'package:angular/angular.dart';

@Component(
    selector: 'catan-board',
    templateUrl: 'packages/catan_randomizer/component/catan_board/catan_board.html',
    cssUrl: 'packages/catan_randomizer/component/catan_board/catan_board.css')
class CatanBoardComponent {

  CatanBoard board;

  CatanBoardComponent() {
    board = new CatanBoard();
    randomize();
  }

  void randomize() {
    board.randomize();
  }

}

class CatanBoard {

  static final Map<int, List<Resource>> frequencies = {
    1: [Resource.DESERT],
    3: [Resource.BRICK, Resource.ORE],
    4: [Resource.SHEEP, Resource.WHEAT, Resource.WOOD]
  };

  static final List<int> hexValues = [5, 2, 6, 3, 8, 10, 9, 12, 11,
                                      4, 8, 10, 9, 4, 5, 6, 3, 11];
  static final List<int> hexOrder = [0, 3, 7, 12, 16, 17, 18, 15,
                                     11, 6, 2, 1, 4, 8, 13, 14, 10, 5, 9];

  List<Resource> _resources;
  List<CatanHex> hexes;

  CatanBoard() {
    _resources = new List<Resource>();
    hexes = new List<CatanHex>();
    _populateResources();
    _populateHexes();
  }

  void randomize() {
    _resources.shuffle();
    for(int i = 0; i < hexes.length; i++) {
      hexes[i].resource = _resources[i];
    }
    int valueIndex = 0;
    for(int i = 0; i < hexOrder.length; i++) {
      var hex = hexes[hexOrder[i]];
      if(hex.resource != Resource.DESERT) {
        hex.value = hexValues[valueIndex];
        valueIndex++;
      } else {
        hex.value = null;
      }
    }
  }

  void _generateResources(frequency, hexTypes) {
    for(int i = 0; i < hexTypes.length; i++) {
      for(int j = 0; j < frequency; j++) {
        _resources.add(hexTypes[i]);
      }
    }
  }

  void _populateHexes() {
    for(int i = 0; i < _resources.length; i++) {
      hexes.add(new CatanHex(_resources[i]));
    }
  }

  void _populateResources() {
    frequencies.forEach(_generateResources);
  }

}