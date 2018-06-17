import 'package:dartea_calculator/model.dart';
import 'package:dartea_calculator/update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('numbers', () {
    test('1 digit', () {
      final model = Model.init();
      final digit = 3;

      final updModel = update(NumberMsg(digit), model).model;

      expect(updModel.resultString, digit.toStringAsFixed(0));
      expect(updModel.currentNum, digit);
    });

    test('2 digits', () {
      final model = Model.init();
      final digit1 = 3;
      final digit2 = 2;
      final expectedNum = digit1 * 10 + digit2;

      var updModel = update(NumberMsg(digit1), model).model;
      updModel = update(NumberMsg(digit2), updModel).model;

      expect(updModel.resultString, expectedNum.toStringAsFixed(0));
      expect(updModel.currentNum, expectedNum);
    });

    test('3 digits', () {
      final model = Model.init();
      final digit1 = 3;
      final digit2 = 2;
      final digit3 = 5;
      final expectedNum = digit1 * 100 + digit2 * 10 + digit3;

      var updModel = update(NumberMsg(digit1), model).model;
      updModel = update(NumberMsg(digit2), updModel).model;
      updModel = update(NumberMsg(digit3), updModel).model;

      expect(updModel.resultString, expectedNum.toStringAsFixed(0));
      expect(updModel.currentNum, expectedNum);
    });
  });
  group('operatiorns', () {
    test('1+3', () {
      final model = Model.init();
      final first = 1;
      final second = 3;
      final expected = first + second;

      var updModel = update(NumberMsg(first), model).model;
      updModel = update(OperationMsg(Op.add), updModel).model;
      updModel = update(NumberMsg(second), updModel).model;
      updModel = update(OperationMsg(Op.eq), updModel).model;

      expect(updModel.acc, expected.toDouble());
    });

    test('4-1', () {
      final model = Model.init();
      final first = 4;
      final second = 1;
      final expected = first - second;

      var updModel = update(NumberMsg(first), model).model;
      updModel = update(OperationMsg(Op.sub), updModel).model;
      updModel = update(NumberMsg(second), updModel).model;
      updModel = update(OperationMsg(Op.eq), updModel).model;

      expect(updModel.acc, expected.toDouble());
    });

    test('2*3', () {
      final model = Model.init();
      final first = 2;
      final second = 3;
      final expected = first * second;

      var updModel = update(NumberMsg(first), model).model;
      updModel = update(OperationMsg(Op.mult), updModel).model;
      updModel = update(NumberMsg(second), updModel).model;
      updModel = update(OperationMsg(Op.eq), updModel).model;

      expect(updModel.acc, expected.toDouble());
    });

    test('7/2', () {
      final model = Model.init();
      final first = 7;
      final second = 2;
      final expected = first / second;

      var updModel = update(NumberMsg(first), model).model;
      updModel = update(OperationMsg(Op.div), updModel).model;
      updModel = update(NumberMsg(second), updModel).model;
      updModel = update(OperationMsg(Op.eq), updModel).model;

      expect(updModel.acc, expected.toDouble());
    });

    test('1+2-3', () {
      final model = Model.init();
      final first = 1;
      final second = 2;
      final third = 3;
      final expected = first + second - third;

      var updModel = update(NumberMsg(first), model).model;
      updModel = update(OperationMsg(Op.add), updModel).model;
      updModel = update(NumberMsg(second), updModel).model;
      updModel = update(OperationMsg(Op.sub), updModel).model;
      updModel = update(NumberMsg(third), updModel).model;
      updModel = update(OperationMsg(Op.eq), updModel).model;

      expect(updModel.acc, expected.toDouble());
    });
  });
}
