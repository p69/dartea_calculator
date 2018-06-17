import 'package:dartea/dartea.dart';
import 'package:dartea_calculator/model.dart';

Upd<Model, Msg> update(Msg msg, Model model) {
  if (msg is NumberMsg) {
    final curNum = model.currentNum * 10 + msg.number;
    final str = '${model.resultString}${msg.number}';
    return Upd(model.copyWith(resultString: str, currentNum: curNum));
  }
  if (msg is OperationMsg) {
    switch (msg.operation) {
      case Op.add:
      case Op.sub:
      case Op.mult:
      case Op.div:
        final acc =
            operations[model.operation](model.acc, model.currentNum.toDouble());
        final str = '${model.resultString}${symbols[msg.operation]}';
        return Upd(model.copyWith(
            acc: acc,
            currentNum: 0,
            operation: msg.operation,
            resultString: str));
      case Op.clear:
        return Upd(Model.init());
      case Op.eq:
        final acc =
            operations[model.operation](model.acc, model.currentNum.toDouble());
        final str = _formatResult(acc);
        return Upd(model.copyWith(
            acc: acc, resultString: str, operation: Op.eq, currentNum: 0));
      default:
        return Upd(model);
    }
  }

  return Upd(model);
}

String _formatResult(double val) {
  return val.toStringAsFixed(val.truncateToDouble() == val ? 0 : 3);
}
