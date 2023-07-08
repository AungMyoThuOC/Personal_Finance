import 'package:flutter/material.dart';
import 'package:personal_finance/classes/language_constants.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          // "About",
          translation(context).about,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        backgroundColor: const Color(0xFFB0B7C0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/budget.png",
                      width: 200,
                      height: 150,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  // "Personal Finance",
                  translation(context).per_fin,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Color(0xFF3b3b3b),
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "v 0.1.2",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "You can record your incomes and expenditures.",
                      translation(context).youIn,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      // "And also can categorize not only income types",
                      translation(context).andCat,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      // "but also expenditure types. If you have any plan",
                      translation(context).butExp,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      // "to take a trip or something, you  can  set cash",
                      translation(context).toTake,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      // "target for it. In the settings menu, you can ",
                      translation(context).targe,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      // "change language, reset the app and Logout the",
                      translation(context).chglan,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      // "app.",
                      translation(context).app,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
