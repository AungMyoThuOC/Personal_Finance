import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_finance/screens/home.dart';

class CalcButton extends StatefulWidget {
  const CalcButton({Key? key}) : super(key: key);

  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  double? _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    var calc = SimpleCalculator(
      value: _currentValue!,
      hideExpression: false,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        if (kDebugMode) {
          print('$key\t$value\t$expression');
        }
      },
      onTappedDisplay: (value, details) {
        if (kDebugMode) {
          print('$value\t${details.globalPosition}');
        }
      },
      theme: const CalculatorThemeData(
        borderColor: Colors.black,
        borderWidth: 2,
        displayColor: Colors.white,
        displayStyle: TextStyle(
          fontSize: 40,
          color: Colors.black,
        ),
        expressionColor: Colors.white,
        expressionStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        operatorColor: Color(0xFFB0B7C0),
        operatorStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
        commandColor: Color(0xFFE0E0E0),
        commandStyle: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
        numColor: Colors.white,
        numStyle: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          // "Calculator",
          AppLocalizations.of(context)!.cal,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB0B7C0),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: const Mainpage(),
            ),
          );
          return false;
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: calc,
        ),
      ),
    );
  }
}
