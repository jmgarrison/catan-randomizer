@TestOn('content-shell')

library catan_board_test;

import "package:test/test.dart";
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:mockito/mockito.dart';
import 'package:catan_randomizer/component/catan_board/catan_board.dart';
import 'package:catan_randomizer/component/catan_hex/catan_hex.dart';
import '../../web/main.dart';
import '../mock/mock_catan_board.dart';

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('CatanBoardComponent', () {

    setUp(module((Module m) =>  m.install(new CatanRandomizerModule())));

    group('initialization', () {
      test('creates a new board', inject((CatanBoardComponent component) {
        expect(component.board, isNotNull);
      }));
    });

    group('#randomize', () {
      test('calls #randomize on #board', inject((CatanBoardComponent component) {
        component.board = new MockCatanBoard();
        component.randomize();
        verify(component.board.randomize());
      }));
    });

  });

  group('CatanBoard', () {
    var board;

    setUp(() {
      board = new CatanBoard();
    });

    group('initialization', () {

      test('distributes resource types from frequencies', () {
        var resources = board.hexes.map( (h) => h.resource ).toList();
        var frequencies = _generateFrequencyMap(resources);

        frequencies.forEach((resource, count) {
          expect(CatanBoard.frequencies[count], contains(resource));
        });
      });
    });

    group('#randomize', () {

      /* The testing / mocking frameworks are currently incompatible.
       * The shuffled resources should be stubbed / returned with a deterministic
       * value for reliable tests. This is fragile since it depends on
       * the randomization to not return the exact same order, though it is unlikely.
       **************************************************************************/

      test('shuffles #resources, and reassigns resource types', () {
        var oldResources = board.hexes.map((hex) => hex.resource).toList();
        board.randomize();
        var newResources = board.hexes.map((hex) => hex.resource).toList();

        expect(oldResources, isNot(equals(newResources)));

        var frequencies = _generateFrequencyMap(newResources);

        frequencies.forEach((resource, count) {
          expect(CatanBoard.frequencies[count], contains(resource));
        });
      });

      test('assigns numbers from .hexOrder and .hexValues, skipping Resource.DESERT', () {
        board.randomize();

        var valueIndex = 0;
        for(var i=0; i < CatanBoard.hexOrder.length; i++) {
          var hex = board.hexes[CatanBoard.hexOrder[i]];

          if(hex.resource == Resource.DESERT) {
            expect(hex.value, equals(null));
          } else {
            expect(hex.value, equals(CatanBoard.hexValues[valueIndex]));
            valueIndex++;
          }
        }
      });
    });
  });
}

Map<Resource, int> _generateFrequencyMap(List<Resource> resources) {
  var frequencies = new Map<Resource, int>();

  resources.forEach((resource) {
    frequencies.putIfAbsent(resource, () => 0);
    frequencies[resource]++;
  });

  return frequencies;
}