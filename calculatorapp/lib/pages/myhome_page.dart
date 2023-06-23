import 'package:calculatorapp/config/constant.dart';
import 'package:calculatorapp/pages/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';

  var userAnswer = '';

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                String text = buttons[index];

                //clear button
                if (index == 0) {
                  return MyButton(
                    buttonTapped: (){
                      setState(() {
                        userQuestion = "";
                      });
                    },
                    color: tdGreen,
                    textColor: tWhite,
                    buttonText: text,
                  );
                }

                //delete button
                else if (index == 1) {
                  return MyButton(
                    buttonTapped: (){
                      setState(() {
                        userQuestion = userQuestion.substring(0 ,userQuestion.length - 1 );
                      });
                    },
                    color: tdRed,
                    textColor: tWhite,
                    buttonText: text,
                  );
                }

                else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: (){
                      setState(() {
                         equalPressed();
                      });
                    },
                    color: tdRed,
                    textColor: tWhite,
                    buttonText: text,
                  );
                }

                //
                else {
                  return MyButton(
                    buttonTapped: (){
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    color:
                        isOperator(text) ? tColorButtonOperator : tColorButton,
                    textColor: isOperator(text) ? tWhite : Colors.deepPurple,
                    buttonText: text,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "x" || x == "-" || x == "+" || x == "=") {
      return true;
    }
    return false;
  }

  void equalPressed(){
      String finalQuestion = userQuestion;
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      userAnswer = eval.toString();
  }
}
