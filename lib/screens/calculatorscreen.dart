import 'package:flutter/material.dart';
import 'dart:math';
import 'package:loan_calculator/main.dart';

void main() => runApp(const MyApp());

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double result = 0.0;
  double term = 0.0;
  double months = 0.0;
  double output = 0.0;
  double amount = 0.0;
  double interest = 0.0;
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController termEditingController = TextEditingController();
  TextEditingController interestEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loan Calculator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Loan Calculator",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Payment Calculator",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 8,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Column(
                              children: [
                                const SizedBox(height: 30.0),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: amountEditingController,
                                          decoration: InputDecoration(
                                              labelText: 'Loan amount',
                                              labelStyle: TextStyle(),
                                              hintText: 'Enter loan amount',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                        ),
                                        const SizedBox(height: 10.0),
                                        TextFormField(
                                          controller: termEditingController,
                                          decoration: InputDecoration(
                                              labelText: 'Loan term',
                                              labelStyle: TextStyle(),
                                              hintText: 'Enter loan term',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                        ),
                                        const SizedBox(height: 10.0),
                                        TextField(
                                          controller: interestEditingController,
                                          decoration: InputDecoration(
                                              labelText: ' Interest rate',
                                              labelStyle: TextStyle(),
                                              hintText: 'Enter interest rate',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  {_pressMe("Calculate")},
                                              child: const Text("Calculate"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  {_pressMe("Clear")},
                                              child: const Text("Clear"),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30.0),
                                      ],
                                    )),
                              ],
                            ))),
                  ),
                  Text(
                    "Monthly Payment : RM " + result.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Visibility(
                    visible: result > 0.0,
                    child: Text(
                      "You will need to pay RM " +
                          result.toStringAsFixed(2) +
                          " every month for " +
                          term.toStringAsFixed(0) +
                          " years to pay the debt.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Visibility(
                    visible: result > 0.0,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text("Total of ${months.toInt()} payment")),
                        DataColumn(
                            label: Text("RM ${(output).toStringAsFixed(2)}")),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("Total interest")),
                          DataCell(Text(
                              "RM ${(output - amount).toStringAsFixed(2)} ")),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _pressMe(String s) {
    setState(() {
      switch (s) {
        case "Calculate":
          term = double.parse(termEditingController.text);
          amount = double.parse(amountEditingController.text);
          interest = double.parse(interestEditingController.text);
          months = term * 12;
          double monthlyInterest = interest / 12 / 100;
          double numerator =
              amount * monthlyInterest * pow(1 + monthlyInterest, months);
          double denominator = pow(1 + monthlyInterest, months) - 1;
          double monthlyPayment = numerator / denominator;
          result = monthlyPayment;
          output = months * monthlyPayment;
          break;

        case "Clear":
          amountEditingController.clear();
          termEditingController.clear();
          interestEditingController.clear();
          result = 0.0;
          term = 0.0;
          months = 0.0;
          output = 0.0;
          amount = 0.0;
          interest = 0.0;
          break;
      }
    });
  }
}
