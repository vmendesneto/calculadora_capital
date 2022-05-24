

import 'dart:math';

import 'package:flutter/cupertino.dart';

class tirController {
  static num irr(
      {@required List<num>? values,
        num guess = 0.1,
        num tol = 1e-6,
        num maxIter = 1000}) {
    num rn = guess;
    num iterator = 0;
    bool close = false;
    while ((iterator < maxIter) && !close) {
      final num rnp1 = rn - _npv_div_npvPrime(rn, values!);
      final num diff = (rnp1 - rn).abs();
      close = diff < tol;
      iterator += 1;
      rn = rnp1;
    }

    return rn;
  }

  static num npv({@required num? rate, @required List<num>? values}) {
    return List<int>.generate(values!.length, (int index) => index)
        .map((int index) => values[index] / pow(1 + rate!, index))
        .fold(0, (num p, num c) => p + c);
  }
  static num _npv_div_npvPrime(num rate, List<num> values) {
    final num t1 = npv(rate: rate, values: values);
    final num t2 = _npvPrime(rate: rate, values: values);
    return t1 / t2;
  }
  static num _npvPrime({@required num? rate, @required List<num>? values}) {
    return List<int>.generate(values!.length, (int index) => index)
        .map((int index) => -index * values[index] / pow(1 + rate!, index + 1))
        .fold(0, (num p, num c) => p + c);
  }
}
