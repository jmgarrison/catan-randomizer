@TestOn('content-shell')

library slice_test;

import "package:test/test.dart";
import 'package:catan_randomizer/formatter/slice.dart';

main() {
  var filter = new SliceFilter();
  var list = [1,2,3,4,5];

  setUp(() {
    filter = new SliceFilter();

  });

  group('SliceFilter', () {

    group('#call', () {
      test('returns the sublist from start to end exclusive', () {
        expect(filter.call(list, 0, 1), equals([1]));
        expect(filter.call(list, 2, 4), equals([3,4]));
      });

      test('raises an exception with an invalid range', () {
        expect(() => filter.call(list, 5, 6), throwsA(new isInstanceOf<RangeError>()));
      });

      test('returns null if the list is not iterable', () {
        expect(filter.call("foo", 0, 1), isNull);
      });
    });

  });

}