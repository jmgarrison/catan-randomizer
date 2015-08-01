@TestOn('content-shell')

library catan_board_test;

import "package:test/test.dart";
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:catan_randomizer/component/catan_hex/catan_hex.dart';
import '../../web/main.dart';

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('CatanHexComponent', () {

    setUp(module((Module m) =>  m.install(new CatanRandomizerModule())));

    group('#hexClass', () {
      test('returns the resource name lowercased', inject((CatanHexComponent component) {
        var values = ['brick', 'desert', 'ore', 'sheep', 'wheat', 'wood'];
        var expectedValues = new Map.fromIterables(Resource.values, values);

        expectedValues.forEach((resource, expected) {
          component.resource = resource;
          expect(component.hexClass(), equals(expected));
        });
      }));
    });

    group('#valueClass', () {
      test('returns null for values not in  .probableValues', inject((CatanHexComponent component) {
        expect(CatanHexComponent.probableValues.contains(1), isFalse);
        component.value = 1;
        expect(component.valueClass(), isNull);

        expect(CatanHexComponent.probableValues.contains(7), isFalse);
        component.value = 7;
        expect(component.valueClass(), isNull);

        expect(CatanHexComponent.probableValues.contains(12), isFalse);
        component.value = 12;
        expect(component.valueClass(), isNull);
      }));

      test('returns .probableClass for values in .probableValues', inject((CatanHexComponent component) {
        for(int value in CatanHexComponent.probableValues) {
          component.value = value;
          expect(component.valueClass(), equals(CatanHexComponent.probableClass));
        }
      }));
    });

  });

}