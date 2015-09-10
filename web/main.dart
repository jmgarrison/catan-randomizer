library catan_randomizer;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:catan_randomizer/uri/resource_url_resolver_wrapper.dart';
import 'package:catan_randomizer/component/catan_board/catan_board.dart';
import 'package:catan_randomizer/component/catan_hex/catan_hex.dart';
import 'package:catan_randomizer/formatter/slice.dart';

class CatanRandomizerModule extends Module {
  CatanRandomizerModule() {
    bind(CatanBoardComponent);
    bind(CatanHexComponent);
    bind(SliceFilter);
    bind(ResourceResolverConfig, toValue: new ResourceResolverConfig.resolveRelativeUrls(false));
    bind(ResourceUrlResolver, toImplementation: ResourceUrlResolverWrapper);
  }
}

void main() {
  applicationFactory()
  .addModule(new CatanRandomizerModule())
  .run();
}