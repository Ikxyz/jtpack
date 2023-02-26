import 'package:flutter_test/flutter_test.dart';

import 'package:jtpack/modules/regex.dart';

void main() {
  test('Money Regex', () {
    final isString = isMoney("200", 100, 1000, symbol: "GDP");
    expect(isString, "");
  });
}
