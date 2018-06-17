import 'package:dartea_calculator/model.dart';
import 'package:dartea_calculator/update.dart';
import 'package:dartea_calculator/view.dart';
import 'package:flutter/material.dart';
import 'package:dartea/dartea.dart';

void main() {
  var program = Program(() => Upd<Model, Msg>(Model.init()), update, view)
      .withDebugTrace();
  runApp(MyApp(program));
}

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
