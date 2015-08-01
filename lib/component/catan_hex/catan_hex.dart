library catan_hex_component;

import 'package:angular/angular.dart';

@Component(
    selector: 'catan-hex',
    templateUrl: 'packages/catan_randomizer/component/catan_hex/catan_hex.html',
    cssUrl: 'packages/catan_randomizer/component/catan_hex/catan_hex.css')
class CatanHexComponent {

  static final probableValues = [6, 8];
  static final probableClass = 'probable';

  @NgOneWay('resource')
  Resource resource;

  @NgOneWay('value')
  int value;

  String hexClass() {
    switch(resource) {
      case Resource.BRICK:
        return 'brick';
      case Resource.DESERT:
        return 'desert';
      case Resource.ORE:
        return 'ore';
      case Resource.SHEEP:
        return 'sheep';
      case Resource.WHEAT:
        return 'wheat';
      case Resource.WOOD:
        return 'wood';
    }
    return '';
  }

  String valueClass() {
    return probableValues.contains(value) ? probableClass : null;
  }

}

enum Resource {
  BRICK,
  DESERT,
  ORE,
  SHEEP,
  WHEAT,
  WOOD
}

class CatanHex {
  Resource resource;
  int value;

  CatanHex(this.resource);
}