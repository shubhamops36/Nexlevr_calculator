import 'package:flutter/material.dart';
import 'SCREENS/calculator_screen.dart';
void main() {
  runApp(const NexlevrCalculator());
}

class NexlevrCalculator extends StatelessWidget {
  const NexlevrCalculator({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nexlevr Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
       useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}
