import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State createState() => new CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String _output = "0", _temp, _operand;
  double _num1, _num2, _res;
  String _updatedOutput;
  bool _cascading;
  double evaluate(double n1, double n2, String op) {
    if (op == '+') return n1 + n2;
    if (op == '-') return n1 - n2;
    if (op == '/') {
      return double.parse((n1 / n2).toStringAsFixed(2));
    }
    if (op == 'X') return n1 * n2;
  }

  _buttonPressed(String text) {
    _cascading = false;
    if (text == 'AC') {
      _updatedOutput = '';
      _num1 = null;
      _num2 = null;
      _output = '0';
      _operand = null;
    } else if (text == '+' || text == '-' || text == '/' || text == 'X') {
      if (_operand == null) {
        _num1 = double.parse(_output);
        _operand = text;
        _updatedOutput = null;
      } else {
        _num2 = double.parse(_output);
        _res = evaluate(_num1, _num2, _operand);
        if (_res == double.infinity) {
          _updatedOutput = "Error";
          _num1 = null;
          _num2 = null;
          _operand = null;
          _res = null;
        } else {
          _updatedOutput = _res.toString();
          _cascading = true;
          _operand = text;
          _num1 = _res;
          _num2 = null;
        }
      }
    } else if (text == '.') {
      if (_output.contains('.')) {
        _updatedOutput = "Error";
        _num1 = null;
        _num2 = null;
        _operand = null;
        _res = null;
      } else {
        _updatedOutput = _output + text;
      }
    } else if (text == '=') {
      if (_num1 == null) {
        _updatedOutput = _output;
      } else {
        _num2 = double.parse(_output);
        _res = evaluate(_num1, _num2, _operand);
        print(_res);
        if (_res == double.infinity) {
          _updatedOutput = "Error";
          _num1 = null;
          _num2 = null;
          _operand = null;
          _res = null;
        } else {
          _updatedOutput = _res.toString();
        }
      }
      _operand = null;
      _num1 = null;
      _num2 = null;
      _cascading = true;
    } else if (text == "+/-") {
      _updatedOutput = (double.parse(_output) * -1).toString();
    } else if (text == '%') {
      _updatedOutput = (double.parse(_output) / 100).toString();
      _operand = null;
      _num2 = null;
      _num1 = double.parse(_output) / 100;
    } else {
      if (_updatedOutput == null || _updatedOutput == '')
        _updatedOutput = text;
      else
        _updatedOutput = _output + text;
    }

    setState(() {
      if (_updatedOutput == '')
        _output = '0';
      else if (_updatedOutput != null) _output = _updatedOutput;
      if (_cascading) _updatedOutput = null;
    });
  }

  Widget _buildButton(
      String text, int flexNumber, Color color, Color fontColor) {
    double width = MediaQuery.of(context).size.width / 4;
    return Expanded(
      flex: flexNumber,
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: ButtonTheme(
          height: width,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30,
                color: fontColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            color: color,
            onPressed: () => _buttonPressed(text),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 12,
              ),
              child: Text(
                _output,
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.w100),
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                _buildButton("AC", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("+/-", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("%", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton(
                    "/", 1, Color.fromRGBO(255, 149, 0, 1), Color(0xFFFFFFFF)),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton("7", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("8", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("9", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton(
                    "X", 1, Color.fromRGBO(255, 149, 0, 1), Color(0xFFFFFFFF)),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton("4", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("5", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("6", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton(
                    "-", 1, Color.fromRGBO(255, 149, 0, 1), Color(0xFFFFFFFF)),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton("1", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("2", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton("3", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton(
                    "+", 1, Color.fromRGBO(255, 149, 0, 1), Color(0xFFFFFFFF)),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton("0", 2, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton(".", 1, Color.fromRGBO(212, 212, 212, 1),
                    Color(0xFF000000)),
                _buildButton(
                    "=", 1, Color.fromRGBO(255, 149, 0, 1), Color(0xFFFFFFFF)),
                // _buildButton("3")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
