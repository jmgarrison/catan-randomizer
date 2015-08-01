library catan_randomizer;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:catan_randomizer/component/catan_hex/catan_hex.dart';

class CatanRandomizerModule extends Module {
  CatanRandomizerModule() {
    bind(CatanHexComponent);
  }
}

void main() {
  applicationFactory()
  .addModule(new CatanRandomizerModule())
  .run();
}