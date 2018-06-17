import 'package:dartea/dartea.dart';
import 'package:dartea_calculator/model.dart';
import 'package:flutter/material.dart';

Widget view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return MaterialApp(
      home: SafeArea(
    child: Material(
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
          buildRow(dispatch, 3, 7, 1, Op.div, 1),
          buildRow(dispatch, 3, 4, 1, Op.mult, 1),
          buildRow(dispatch, 3, 1, 1, Op.sub, 1),
          buildRow(dispatch, 1, 0, 3, Op.add, 1),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildOperatorButton(dispatch, Op.clear, 1, color: Colors.grey),
              buildOperatorButton(dispatch, Op.eq, 3)
            ],
          ))
        ],
      ),
    ),
  ));
}

Widget buildRow(Dispatch<Msg> dispatch, int numberKeyCount, int startNumber,
    int numberFlex, Op operation, int operrationFlex) {
  return new Expanded(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: new List.from(buildNumberButtons(
            dispatch,
            numberKeyCount,
            startNumber,
            numberFlex,
          ))
            ..add(buildOperatorButton(dispatch, operation, operrationFlex))));
}

Widget buildOperatorButton(Dispatch<Msg> dispatch, Op operation, int flex,
    {Color color = Colors.amber}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: FlatButton(
          onPressed: () => dispatch(OperationMsg(operation)),
          color: color,
          child: Text(
            symbols[operation],
            style: TextStyle(fontSize: 40.0),
          )),
    ),
  );
}

List<Widget> buildNumberButtons(
    Dispatch<Msg> dispatch, int count, int from, int flex) {
  return Iterable.generate(count, (index) {
    return Expanded(
      flex: flex,
      child: Padding(
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
