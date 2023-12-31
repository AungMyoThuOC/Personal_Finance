// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_finance/provider/locale_provider.dart';
import 'package:personal_finance/screens/Login/reset_pw.dart';
import 'package:personal_finance/screens/Login/reset_pw2.dart';
// import 'package:personal_finance/screens/change_pw.dart';
import 'package:personal_finance/screens/check_screen.dart';
import 'package:personal_finance/screens/home.dart';
import 'package:personal_finance/screens/Setting/language.dart';
import 'package:personal_finance/screens/Login/leadingpage.dart';
import 'package:personal_finance/screens/Login/login.dart';
import 'package:personal_finance/screens/Login/pass_code.dart';
import 'package:personal_finance/screens/Login/register.dart';
import 'package:personal_finance/screens/Saving/saving_money_adding_history.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            title: 'Personal Finance',
            supportedLocales: L10n.all,
            locale: provider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: const TextStyle(fontSize: 13),
                contentPadding: const EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade800,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade800,
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/checkScreen',
            routes: {
              '/': (context) => const FrontScreen(),
              '/login': (context) => const MyLogInPage(),
              '/register': (context) => const RegisterPage(),
              '/reset': (context) => const ResetPassword(),
              '/reset2': (context) => const ResetPassword2(),
              '/main': (context) => const Mainpage(),
              // '/changepassword': (context) => const ChangePw(),
              '/checkScreen': (context) => const checkScreen(),
              '/passcode': (context) => const MyPasscode(),
              '/savingHistory': (context) => const SavingHistory(),
              '/language': (context) => const Language()
            },
          );
        },
      );
}
