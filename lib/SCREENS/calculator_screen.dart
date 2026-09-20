import 'package:flutter/material.dart';
import '../LOGIC/calculator_logic.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();

}

class _CalculatorScreenState extends State<CalculatorScreen> {

  final CalculatorLogic calculatorLogic = CalculatorLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nexlevr Calculator'),
      ),

      body: Column(
        children: [
          //Display section
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                calculatorLogic.display,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //Buttons section

          Expanded(
            flex: 5,
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _calculatorButton('AC'),
                _calculatorButton('⌫'),
                _calculatorButton('%'),
                _calculatorButton('÷'),

                _calculatorButton('7'),
                _calculatorButton('8'),
                _calculatorButton('9'),
                _calculatorButton('×'),

                _calculatorButton('4'),
                _calculatorButton('5'),
                _calculatorButton('6'),
                _calculatorButton('-'),

                _calculatorButton('1'),
                _calculatorButton('2'),
                _calculatorButton('3'),
                _calculatorButton('+'),

                _calculatorButton('±'),
                _calculatorButton('0'),
                _calculatorButton('.'),
                _calculatorButton('='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calculatorButton(String text) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            calculatorLogic.pressButton(text);
          });
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
            )
          ),
        ),
    );
  }
}
