import 'package:calculator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNightMode = false;
  var textEditingController = TextEditingController();
  String equation = "0";
  String expression = "";
  String result = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  _buildButton(_text, _color) {
    return MaterialButton(
        elevation: 2.0,
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          _text,
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
              color: isNightMode ? Colors.white : Colors.black),
        ),
        color: _color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        onPressed: () {
          onButtonPressed(_text);
        });
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        if (equation.length != 1)
          equation = equation.substring(0, equation.length - 1);
        else
          equation = "0";

        equationFontSize = 48.0;
        resultFontSize = 38.0;
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression.replaceAll('×', '*');
        expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final kKeysColor = isNightMode ? Color(0xff5B5D72) : Color(0xffE5E8FB);
    final kOperandColor = isNightMode ? Color(0xff947D99) : Color(0xffF5EAF8);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: !isNightMode ? Colors.white : Colors.black,
          elevation: 0.0,
          actions: <Widget>[
            Switch(
              value: isNightMode,
              activeColor: Colors.white,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              inactiveThumbColor: Colors.black,
              onChanged: (bool newValue) {
                setState(() {
                  isNightMode = !isNightMode;
                });
              },
            ),
          ],
        ),
        backgroundColor: isNightMode ? nightMode : normalMode,
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * .4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      equation,
                      style: TextStyle(
                        fontSize: equationFontSize,
                        color: !isNightMode ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: resultFontSize,
                        color: !isNightMode ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: !isNightMode ? Colors.black12 : Colors.white12,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildButton("C", kOperandColor),
                        _buildButton("7", kKeysColor),
                        _buildButton("4", kKeysColor),
                        _buildButton("1", kKeysColor),
                        _buildButton(".", kKeysColor),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildButton("⌫", kOperandColor),
                        _buildButton("8", kKeysColor),
                        _buildButton("5", kKeysColor),
                        _buildButton("2", kKeysColor),
                        _buildButton("0", kKeysColor),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildButton("%", kOperandColor),
                        _buildButton("9", kKeysColor),
                        _buildButton("6", kKeysColor),
                        _buildButton("3", kKeysColor),
                        _buildButton("00", kKeysColor),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildButton("÷", kOperandColor),
                        _buildButton("×", kOperandColor),
                        _buildButton("-", kOperandColor),
                        _buildButton("+", kOperandColor),
                        _buildButton("=", kOperandColor),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
