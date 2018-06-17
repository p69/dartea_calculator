typedef OpFunction = double Function(double acc, double operand);
enum Op { add, sub, mult, div, clear, eq, init }
const symbols = {
  Op.add: '+',
  Op.sub: '-',
  Op.mult: 'x',
  Op.div: '/',
  Op.clear: 'C',
  Op.eq: '=',
  Op.init: ''
};
final operations = <Op, OpFunction>{
  Op.add: (acc, operand) => acc + operand,
  Op.sub: (acc, operand) => acc - operand,
  Op.mult: (acc, operand) => acc * operand,
  Op.div: (acc, operand) => acc / operand,
  Op.clear: (_, __) => 0.0,
  Op.eq: (acc, _) => acc,
  Op.init: (_, x) => x
};

class Model {
  final String resultString;
  final double acc;
  final Op operation;
  final int currentNum;

  Model(this.resultString, this.currentNum, this.acc, this.operation);

  Model copyWith(
      {String resultString, int currentNum, double acc, Op operation}) {
    return Model(
        resultString ?? this.resultString,
        currentNum ?? this.currentNum,
        acc ?? this.acc,
        operation ?? this.operation);
  }

  factory Model.init() {
    return Model('', 0, 0.0, Op.init);
  }

  @override
  String toString() {
    return '{acc:$acc; currentNum:$currentNum; result:$resultString}';
  }
}

abstract class Msg {}

class NumberMsg implements Msg {
  final int number;
  NumberMsg(this.number);
  @override
  String toString() {
    return 'NumberMsg: $number';
  }
}

class OperationMsg implements Msg {
  final Op operation;
  OperationMsg(this.operation);
  @override
  String toString() {
    return 'OperationMsg: $operation';
  }
}
