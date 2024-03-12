import 'dart:developer';

import 'package:calculator/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ScreenCalculator extends StatefulWidget {
  const ScreenCalculator({super.key});

  @override
  State<ScreenCalculator> createState() => _ScreenCalculatorState();
}

class _ScreenCalculatorState extends State<ScreenCalculator> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 185, 243),
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 50)))
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: SizedBox(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CalculatorButtons(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                              userAnswer = '';
                            });
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else if (index == 1) {
                      return CalculatorButtons(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else if (index == buttons.length - 1) {
                      return CalculatorButtons(
                          buttonTapped: () {
                            setState(() {
                              evaluate();
                            });
                          },
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else {
                      return CalculatorButtons(
                          buttonTapped: () {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          color: isOperator(buttons[index])
                              ? Colors.deepPurple
                              : const Color.fromARGB(255, 237, 231, 246),
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.black,
                          buttonText: buttons[index]);
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void evaluate() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('X', '*');
    Parser p = Parser();
    Expression exp;
    try {
      exp = p.parse(finalQuestion);
    } catch (e) {
      log("Syntax error: $e");
      userAnswer = 'Not Defined';
      return;
    }
    ContextModel cm = ContextModel();
    try {
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      userAnswer = eval.toString();
    } catch (e) {
      log("Evaluation error: $e");
      userAnswer = 'Not Defined';
    }
  }
}
