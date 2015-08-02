library slice;

import 'package:angular/angular.dart';

@Formatter(name: 'slice')
class SliceFilter {
  List call(list, int start, int end) {
    if (list is Iterable) {
      return list.sublist(start, end);
    }
    return null;
  }
}