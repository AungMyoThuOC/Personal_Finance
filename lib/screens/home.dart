// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_finance/model/firebaseservice.dart';
import 'package:personal_finance/provider/locale_provider.dart';
import 'package:personal_finance/screens/Calculator/calculator.dart';
import 'package:personal_finance/screens/dashboard.dart';
import 'package:personal_finance/screens/Saving/saving.dart';
import 'package:personal_finance/screens/Setting/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    // const Text("Saving"),
    Saving(),
    // const Text("Calculator"),
    // const CalculatorPage(),
    const CalcButton(),
    Setting(),
    // const Text("Setting"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void loginCheck() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/register",
          (route) => false,
        );
      } else {
        print('User is signed in!');
      }
    });
  }

  checkLang() async {
    final prefs = await SharedPreferences.getInstance();
    final int? lang = prefs.getInt('language');
    if (lang == 2) {
      // ignore: use_build_context_synchronously
      final provider = Provider.of<LocaleProvider>(
        context,
        listen: false,
      );
      provider.setLocale(Locale('my'));
    } else {
      // ignore: use_build_context_synchronously
      final provider = Provider.of<LocaleProvider>(
        context,
        listen: false,
      );
      provider.setLocale(Locale('en'));
    }
  }

  @override
  void initState() {
    checkLang();
    loginCheck();
    API().addCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 10,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blueGrey,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color(0xFF526480),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_savings_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_savings_filled),
              label: "Saving",
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_calculator_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_calculator_filled),
              label: "Calculator",
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_settings_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_settings_filled),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
