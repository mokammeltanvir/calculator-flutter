import 'package:flutter/material.dart';

void main() {
  runApp(SimpleCalculator());
}

class SimpleCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            height: 300.0,
            width: 300.0,
            color: Color.fromARGB(255, 78, 78, 78),
            child: Center(
              child: CalculatorScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String output = '';

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          output = _calculate(input);
        } catch (e) {
          output = 'Error';
        }
      } else if (buttonText == 'C') {
        input = '';
        output = '';
      } else {
        input += buttonText;
      }
    });
  }

  String _calculate(String input) {
    // Split the input string to extract numbers and operators
    List<String> elements = input.split(RegExp(r'[-+*/]'));
    List<String> operators = input.split(RegExp(r'[0-9]')).where((s) => s.isNotEmpty).toList();
    
    // Handle invalid input
    if (elements.length != 2 || operators.length != 1) {
      return 'Error';
    }

    double num1 = double.parse(elements[0]);
    double num2 = double.parse(elements[1]);
    String operator = operators[0];

    double result = 0;

    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          return 'Error';
        }
        break;
      default:
        return 'Error';
    }

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 41, 41, 41),
      
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            child: Text(
              input,
              style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              output,
              style: TextStyle(fontSize: 48, color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Row(
                  children: [
                    CalculatorButton(
                      text: '7',
                      onPressed: () => onButtonPressed('7'),
                    ),
                    CalculatorButton(
                      text: '8',
                      onPressed: () => onButtonPressed('8'),
                    ),
                    CalculatorButton(
                      text: '9',
                      onPressed: () => onButtonPressed('9'),
                    ),
                    CalculatorButton(
                      text: '/',
                      onPressed: () => onButtonPressed('/'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CalculatorButton(
                      text: '4',
                      onPressed: () => onButtonPressed('4'),
                    ),
                    CalculatorButton(
                      text: '5',
                      onPressed: () => onButtonPressed('5'),
                    ),
                    CalculatorButton(
                      text: '6',
                      onPressed: () => onButtonPressed('6'),
                    ),
                    CalculatorButton(
                      text: '*',
                      onPressed: () => onButtonPressed('*'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CalculatorButton(
                      text: '1',
                      onPressed: () => onButtonPressed('1'),
                    ),
                    CalculatorButton(
                      text: '2',
                      onPressed: () => onButtonPressed('2'),
                    ),
                    CalculatorButton(
                      text: '3',
                      onPressed: () => onButtonPressed('3'),
                    ),
                    CalculatorButton(
                      text: '-',
                      onPressed: () => onButtonPressed('-'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CalculatorButton(
                      text: 'C',
                      onPressed: () => onButtonPressed('C'),
                    ),
                    CalculatorButton(
                      text: '0',
                      onPressed: () => onButtonPressed('0'),
                    ),
                    CalculatorButton(
                      text: '=',
                      onPressed: () => onButtonPressed('='),
                    ),
                    CalculatorButton(
                      text: '+',
                      onPressed: () => onButtonPressed('+'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 25,
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 219, 219)),
        ),
      ),
    );
  }
}
