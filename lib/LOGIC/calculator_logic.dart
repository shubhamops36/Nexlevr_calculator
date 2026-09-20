class CalculatorLogic {
  String display = '0';
  String firstNumber = '';
  String operator = '';
  String secondNumber = '';
  bool _isResult = false;

  void pressButton(String value) {
    if (value == 'AC') {
      _reset();
    } else if (value == '⌫') {
      _backspace();
    } else if (value == '±') {
      _toggleSign();
    } else if (value == '%') {
      _applyPercentage();
    } else if (value == '.') {
      _addDecimal();
    } else if (value == '=') {
      _evaluate();
    } else if (['+', '-', '×', '÷'].contains(value)) {
      _setOperator(value);
    } else if (RegExp(r'[0-9]').hasMatch(value)) {
      _addNumber(value);
    }
    _updateDisplay();
  }

  void _reset() {
    display = '0';
    firstNumber = '';
    operator = '';
    secondNumber = '';
    _isResult = false;
  }

  void _backspace() {
    if (_isResult) {
      _reset();
      return;
    }
    if (secondNumber.isNotEmpty) {
      secondNumber = secondNumber.substring(0, secondNumber.length - 1);
    } else if (operator.isNotEmpty) {
      operator = '';
    } else if (firstNumber.isNotEmpty) {
      firstNumber = firstNumber.substring(0, firstNumber.length - 1);
    }
  }

  void _toggleSign() {
    if (operator.isEmpty) {
      if (_isResult) {
        firstNumber = display;
        _isResult = false;
      }
      if (firstNumber.isNotEmpty && firstNumber != '0') {
        firstNumber = firstNumber.startsWith('-')
            ? firstNumber.substring(1)
            : '-$firstNumber';
      }
    } else {
      if (secondNumber.isNotEmpty && secondNumber != '0') {
        secondNumber = secondNumber.startsWith('-')
            ? secondNumber.substring(1)
            : '-$secondNumber';
      }
    }
  }

  void _applyPercentage() {
    if (operator.isEmpty) {
      String target = _isResult ? display : firstNumber;
      if (target.isNotEmpty) {
        double n = double.tryParse(target) ?? 0;
        firstNumber = _formatResult(n / 100);
        _isResult = false;
      }
    } else {
      if (secondNumber.isNotEmpty) {
        double n1 = double.tryParse(firstNumber) ?? 0;
        double n2 = double.tryParse(secondNumber) ?? 0;
        // Standard calculator behavior for percentage in context of addition/subtraction
        if (operator == '+' || operator == '-') {
          secondNumber = _formatResult(n1 * n2 / 100);
        } else {
          secondNumber = _formatResult(n2 / 100);
        }
      }
    }
  }

  void _addDecimal() {
    if (_isResult) {
      firstNumber = '0.';
      _isResult = false;
      return;
    }
    if (operator.isEmpty) {
      if (!firstNumber.contains('.')) {
        firstNumber = firstNumber.isEmpty ? '0.' : '$firstNumber.';
      }
    } else {
      if (!secondNumber.contains('.')) {
        secondNumber = secondNumber.isEmpty ? '0.' : '$secondNumber.';
      }
    }
  }

  void _setOperator(String value) {
    if (firstNumber.isNotEmpty && operator.isNotEmpty && secondNumber.isNotEmpty) {
      _evaluate(isChaining: true);
    }

    if (_isResult) {
      firstNumber = display;
      _isResult = false;
    }

    if (firstNumber.isEmpty && display != '0' && display != 'Error') {
      firstNumber = display;
    }

    if (firstNumber.isNotEmpty) {
      operator = value;
    }
  }

  void _addNumber(String value) {
    if (_isResult) {
      firstNumber = value;
      _isResult = false;
    } else if (operator.isEmpty) {
      firstNumber = (firstNumber == '0') ? value : firstNumber + value;
    } else {
      secondNumber = (secondNumber == '0') ? value : secondNumber + value;
    }
  }

  void _evaluate({bool isChaining = false}) {
    if (firstNumber.isNotEmpty && operator.isNotEmpty && secondNumber.isNotEmpty) {
      double n1 = double.tryParse(firstNumber) ?? 0;
      double n2 = double.tryParse(secondNumber) ?? 0;
      double result = 0;

      switch (operator) {
        case '+':
          result = n1 + n2;
          break;
        case '-':
          result = n1 - n2;
          break;
        case '×':
          result = n1 * n2;
          break;
        case '÷':
          if (n2 == 0) {
            _reset();
            display = 'Error';
            return;
          }
          result = n1 / n2;
          break;
      }

      String resultStr = _formatResult(result);
      if (isChaining) {
        firstNumber = resultStr;
        secondNumber = '';
        operator = '';
        display = resultStr;
        _isResult = false;
      } else {
        display = resultStr;
        firstNumber = '';
        secondNumber = '';
        operator = '';
        _isResult = true;
      }
    }
  }

  void _updateDisplay() {
    if (display == 'Error') return;

    if (_isResult) {
      // display is already set to the result string
    } else if (operator.isEmpty) {
      display = firstNumber.isEmpty ? '0' : firstNumber;
    } else if (secondNumber.isEmpty) {
      display = '$firstNumber $operator';
    } else {
      display = '$firstNumber $operator $secondNumber';
    }
  }

  String _formatResult(double result) {
    if (result == result.toInt().toDouble()) {
      return result.toInt().toString();
    }
    String s = result.toString();
    if (s.length > 15) {
      // Use exponential notation or limit precision for very long decimals
      return result.toStringAsPrecision(10);
    }
    return s;
  }
}
