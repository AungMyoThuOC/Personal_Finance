// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
// import 'package:personal_finance/components/categobadge.dart';
import 'package:personal_finance/screens/Outcome/outcomeadding_detail.dart';
import 'package:personal_finance/model/firebaseservice.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:personal_finance/screens/Outcome/outcomecatego_detail.dart';

class Outcome extends StatefulWidget {
  const Outcome({Key? key}) : super(key: key);

  @override
  State<Outcome> createState() => _OutcomeState();
}

class _OutcomeState extends State<Outcome> {
  var stream1 = FirebaseFirestore.instance
      .collection("${FirebaseAuth.instance.currentUser!.email}")
      .doc("Outcome")
      .collection("outcome-data")
      .snapshots();

  var stream2 = FirebaseFirestore.instance
      .collection("${FirebaseAuth.instance.currentUser!.email}")
      .doc("Outcome-catego")
      .collection('data')
      .snapshots();

  @override
  void initState() {
    API().addCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.outcome,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OutcomeAddingDetail(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
        backgroundColor: const Color(0xFFB0B7C0),
      ),
      body: StreamBuilder2(
        streams: StreamTuple2(stream1, stream2),
        builder: (BuildContext context,
            SnapshotTuple2<QuerySnapshot<Object?>, QuerySnapshot<Object?>>
                snapshots) {
          int outcomeTotal = 0;
          int outcomecategototal = 0;
          int amount = 0;
          if (snapshots.snapshot1.hasError) {
            return Text('Error: ${snapshots.snapshot1.error}');
          } else if (snapshots.snapshot2.hasError) {
            return Text('Error: ${snapshots.snapshot1.error}');
          }

          if (snapshots.snapshot1.connectionState ==
              "ConnectionState.waiting") {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshots.snapshot2.connectionState ==
              "ConnectionState.waiting") {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshots.snapshot1.hasData) {
            for (var data in snapshots.snapshot1.data!.docs) {
              var outcomeField = data;
              int amount = outcomeField['amount'];
              outcomeTotal = outcomeTotal + amount;
            }
          }

          if (snapshots.snapshot2.hasData) {
            choices = [];
            outcomecategototal = 0;
            for (var element in snapshots.snapshot2.data!.docs) {
              var outcomecategodata = element.data() as Map<String, dynamic>;
              if (snapshots.snapshot1.hasData) {
                for (var data in snapshots.snapshot1.data!.docs) {
                  if (data['category'] == outcomecategodata['categoname']) {
                    amount = data['amount'];
                    outcomecategototal += amount;
                  }
                }
              }
              choices.add(
                Choice(
                  title: outcomecategodata['categoname'],
                  imgname: outcomecategodata['imagId'],
                  amount: outcomecategototal,
                ),
              );
              outcomecategototal = 0;
            }
            return Container(
              color: Colors.grey[100],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                color: Colors.grey[100],
                width: (MediaQuery.of(context).size.width),
                height: MediaQuery.of(context).size.height * 0.4,
                child: GridView.count(
                  crossAxisCount: 3,
                  primary: false,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: SelectCard(
                        choice: choices[index],
                        choose: true,
                      ),
                    );
                  }),
                ),
              ),
            );
          }

          return Center(
            child: Container(),
          );
        },
      ),
    );
  }
}

class Choice {
  const Choice({
    required this.title,
    required this.imgname,
    required this.amount,
  });
  final String title;
  final String imgname;
  final int amount;
}

List<Choice> choices = [];

class SelectCard extends StatelessWidget {
  const SelectCard({
    Key? key,
    required this.choice,
    required this.choose,
  }) : super(key: key);
  final Choice choice;
  final bool choose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const OutcomeCategoDetail(),
          ),
        );
      },
      child: SizedBox(
        // width: 3000,
        // height: 300,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
          ),
          child: Card(
            elevation: 2,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                        "images/${choice.imgname}.png",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                      top: 4,
                    ),
                    child: Text(
                      choice.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[850],
                      ),
                    ),
                  ),
                  Text(
                    '${NumberFormat.decimalPattern().format(choice.amount)} MMK',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey[850],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
