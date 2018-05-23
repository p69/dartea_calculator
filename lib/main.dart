import 'package:flutter/material.dart';
import 'package:dartea/dartea.dart';

void main() {
  final program = Program(() => Upd<Model, Msg>(Model()), update, view);
  runApp(MyApp(program));
}

class Model {
  final String resultString;
}

typedef Operation = double Function(double acc, double operand);

abstract class Msg {}

class NumberMsg implements Msg {
  final int number;
  NumberMsg(this.number);
}

class OperationMsg implements Msg {
  final Operation operation;
  OperationMsg(this.operation);
}

Upd<Model, Msg> update(Msg msg, Model model) {}

class MyApp extends StatelessWidget {
  final Program program;

  MyApp(this.program);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: program.build(),
    );
  }
}

Widget view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return new MaterialApp(
      home: new SafeArea(
    child: new Material(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                Text(
                  model.resultString,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 50.0, color: Colors.white),
                )
              ])),
          buildRow(
              dispatch, 3, 7, 1, "/", (accu, dividor) => accu / dividor, 1),
          buildRow(
              dispatch, 3, 4, 1, "x", (accu, dividor) => accu * dividor, 1),
          buildRow(
              dispatch, 3, 1, 1, "-", (accu, dividor) => accu - dividor, 1),
          buildRow(
              dispatch, 1, 0, 3, "+", (accu, dividor) => accu + dividor, 1),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildOperatorButton("C", null, 1, color: Colors.grey),
              buildOperatorButton("=", (accu, dividor) => accu, 3)
            ],
          ))
        ],
      ),
    ),
  ));
}

Widget buildRow(
    Dispatch<Msg> dispatch,
    int numberKeyCount,
    int startNumber,
    int numberFlex,
    String operationLabel,
    Operation operation,
    int operrationFlex) {
  return new Expanded(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: new List.from(buildNumberButtons(
            dispatch,
            numberKeyCount,
            startNumber,
            numberFlex,
          ))
            ..add(buildOperatorButton(
                operationLabel, operation, operrationFlex))));
}

Widget buildOperatorButton(String label, Operation func, int flex,
    {Color color = Colors.amber}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: FlatButton(
          onPressed: () => calc(func),
          color: color,
          child: Text(
            label,
            style: TextStyle(fontSize: 40.0),
          )),
    ),
  );
}

List<Widget> buildNumberButtons(
    Dispatch<Msg> dispatch, int count, int from, int flex) {
  return new Iterable.generate(count, (index) {
    return new Expanded(
      flex: flex,
      child: new Padding(
        padding: const EdgeInsets.all(1.0),
        child: FlatButton(
            onPressed: () => dispatch(NumberMsg(from + index)),
            color: Colors.white,
            child: Text(
              "${from + index}",
              style: TextStyle(fontSize: 40.0),
            )),
      ),
    );
  }).toList();
}
