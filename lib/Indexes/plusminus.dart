import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

import 'dropdown.dart';

void main() {
  runApp(PlusMinus());
}

class PlusMinus extends StatefulWidget {
  @override
  State<PlusMinus> createState() => _QuantityInputSampleState();
}

class _QuantityInputSampleState extends State<PlusMinus> {
  int simpleIntInput = 1;
  int steppedIntInput = 1;
  double simpleDoubleInput = 1;
  double steppedDoubleInput = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QuantityInput(
                    label: 'Simple int input',
                    value: simpleIntInput,
                    onChanged: (value) => setState(() =>
                        simpleIntInput = int.parse(value.replaceAll(',', '')))),
                Text('Value: $simpleIntInput',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
