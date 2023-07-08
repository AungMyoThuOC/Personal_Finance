import 'package:flutter/material.dart';
import 'package:personal_finance/screens/Income/incomadding_detail.dart';
import 'package:personal_finance/screens/Outcome/outcomeadding_detail.dart';

class AddValue extends StatefulWidget {
  const AddValue({Key? key}) : super(key: key);

  @override
  State<AddValue> createState() => _AddValueState();
}

class _AddValueState extends State<AddValue> {
  TextEditingController outcomeamountcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.grey[850],
            // unselectedLabelColor: Colors.grey[850],
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.blue[700],
            tabs: const [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Outcome',
              ),
              // Tab(
              //   text: 'Saving',
              // ),
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const SizedBox(
            width: 30,
            child: Divider(
              color: Colors.black,
              thickness: 2,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: const TabBarView(
            children: [
              IncomeAddingDetail(),
              OutcomeAddingDetail(),
              // #edit
              // AddSaving(
              //   isEdit: false,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
