import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _number1Controller = TextEditingController();
  var _number2Controller = TextEditingController();

  var _sign1 = false;
  var _sign2 = false;

  var _signedNumber1 = 0;
  var _signedNumber2 = 0;

  var _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNumberTextFields(),
            SizedBox(height: 16),
            _buildSignSwitches(),
            _buildCalculationButton(),
            SizedBox(height: 16),
            _buildExpression(),
            SizedBox(height: 16),
            _buildResultText(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberTextFields() {
    return Row(
      children: [
        Expanded(
          child: _buildNumberTextField(controller: _number1Controller, labelText: '数値1'),
        ),
        Expanded(
          child: _buildNumberTextField(controller: _number2Controller, labelText: '数値2'),
        ),
      ],
    );
  }

  Widget _buildNumberTextField({
    TextEditingController controller,
    String labelText
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }

  Widget _buildSignSwitches() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSignSwitch(value: _sign1, onChanged: (e) {
          setState(() {
            _sign1 = e;
          });
        }),
        _buildSignSwitch(value: _sign2, onChanged: (e) {
          setState(() {
            _sign2 = e;
          });
        }),
      ],
    );
  }

  Widget _buildSignSwitch({
    bool value,
    void Function(bool) onChanged
  }) {
    final textStyle = TextStyle(
      fontSize: 20
    );
    return Row(
      children: [
        Text('+', style: textStyle),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
        Text('-', style: textStyle),
      ],
    );
  }

  Widget _buildCalculationButton() {
    return TextButton(
        onPressed: () {
          final number1 = int.tryParse(_number1Controller.text) ?? 0;
          final number2 = int.tryParse(_number2Controller.text) ?? 0;

          setState(() {
            _signedNumber1 = _sign1 ? -number1 : number1;
            _signedNumber2 = _sign2 ? -number2 : number2;

            _result = _signedNumber1 + _signedNumber2;
          });
        },
        child: Text('計算'),
    );
  }

  Widget _buildExpression() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(_signedNumber1.toString()),
        Text('+'),
        Text(_signedNumber2.toString()),
      ],
    );
  }

  Widget _buildResultText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(_result.toString()),
      ],
    );
  }
}
