import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/entities/user.dart' as User2;

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference users = firestore.collection('users');
  late CollectionReference transaction = firestore.collection('transaction');

  final userId = FirebaseAuth.instance.currentUser?.uid;
  late User2.User user;

  TextEditingController textController = TextEditingController(text: "0");

  int sliderIndex = 0;

  int sliderValue = 0;

  int selectedValue = 0;

  final List<double> values = [
    0,
    10000,
    50000,
    100000,
    200000,
    500000,
    1000000
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text("Top Up"),
      ),
      body: Column(
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                      stream: users.doc(userId).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            children: [
                              const Icon(
                                Icons.wallet,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "E-Wallet",
                                style: kBodyText3,
                              ),
                              Expanded(
                                child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp ',
                                              decimalDigits: 0)
                                          .format(snapshot.data!['balance']),
                                      style: kBodyText,
                                    )),
                              )
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Amount",
                        style: kHeadline4,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: textController,
                      style: kBodyText.copyWith(color: Colors.white),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(min: 0, max: 1000000000000)
                      ],
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding:
                              EdgeInsets.only(left: 15.0, right: 0, bottom: 3),
                          child: Text(
                            "Rp ",
                            style: kBodyText,
                          ),
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(minHeight: 0),
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: kBodyText,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          if (text.startsWith("0")) {
                            textController.text = text.substring(1);
                            textController.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: textController.text.length),
                            );
                          }
                          if (text == '') {
                            textController.text = "0";
                            sliderIndex = 0;
                            textController.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: textController.text.length),
                            );
                          }
                          double val = double.parse(text.replaceAll(".", ""));
                          if (val >= 0 && val < 10000) {
                            sliderIndex = 0;
                            selectedValue = 0;
                          } else if (val >= 10000 && val < 50000) {
                            sliderIndex = 1;
                            selectedValue = 10000;
                          } else if (val >= 50000 && val < 100000) {
                            sliderIndex = 2;
                            selectedValue = 50000;
                          } else if (val >= 100000 && val < 200000) {
                            sliderIndex = 3;
                            selectedValue = 100000;
                          } else if (val >= 200000 && val < 500000) {
                            sliderIndex = 4;
                            selectedValue = 200000;
                          } else if (val >= 500000 && val < 1000000) {
                            sliderIndex = 5;
                            selectedValue = 500000;
                          } else {
                            sliderIndex = 6;
                            selectedValue = val == 1000000 ? 1000000 : 0;
                          }
                        });
                      },
                    ),
                  ),
                  Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white10,
                    value: sliderIndex.toDouble(),
                    min: 0,
                    max: values.length - 1,
                    divisions: values.length - 1,
                    // label: values[_currentSliderValue].toInt(),
                    label: NumberFormat.currency(
                            locale: 'id', symbol: '', decimalDigits: 0)
                        .format(values[sliderIndex].toInt()),
                    onChanged: (double value) {
                      setState(() {
                        sliderIndex = value.toInt();
                        sliderValue = values[sliderIndex].toInt();
                        selectedValue = values[sliderIndex].toInt();
                        textController.text = NumberFormat.currency(
                                locale: 'id', symbol: '', decimalDigits: 0)
                            .format(sliderValue);
                        textController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController.text.length),
                        );
                      });
                    },
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Or choose an amount from template",
                    style: kBodyText5,
                  ),
                  Wrap(
                    children: List.generate(
                        values.length,
                        (index) => index != 0
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedValue = values[index].toInt();
                                    textController.text = NumberFormat.currency(
                                            locale: 'id',
                                            symbol: '',
                                            decimalDigits: 0)
                                        .format(selectedValue);
                                    textController.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                          offset: textController.text.length),
                                    );
                                    sliderIndex = index;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.only(right: 24, top: 20),
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: selectedValue == values[index]
                                          ? Colors.amber.shade600
                                          : const Color(0xFF1B191C)),
                                  child: Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(values[index].toInt()),
                                    style: TextStyle(
                                        color: selectedValue == values[index]
                                            ? kBackgroundColor
                                            : Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : const SizedBox()),
                  )
                ],
              )),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(bottom: 30),
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                if (textController.text == "0") {
                  showNotification(context, "Empty amount",
                      "Please input the amount to top up");
                } else {
                  showProgress(context);
                  int amount =
                      int.parse(textController.text.replaceAll(".", ""));

                  await users
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .get()
                      .then((value) {
                    var data = value.data() as Map<String, dynamic>;
                    transaction.add({
                      'date': DateTime.now(),
                      'amount': amount,
                      'type': 'receive',
                      'name': 'Top Up Wallet',
                      'user_id': userId
                    });
                    users.doc(FirebaseAuth.instance.currentUser?.uid).update({
                      'balance': data['balance'] + amount,
                    }).then((value) {
                      Navigator.pop(context);
                      Timer(const Duration(milliseconds: 300),
                          () => showSuccess(context));
                    });
                  });
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: textController.text != "0"
                        ? Colors.blue.shade900
                        : Colors.grey.shade700),
                child: const Text(
                  "Top Up",
                  style: kBodyText4,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  void showNotification(BuildContext context, String title, String message) {
    AwesomeDialog(
      dialogBackgroundColor: kBackgroundColor,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnOkOnPress: () {},
      btnOkText: "OK",
    ).show();
  }

  void showSuccess(BuildContext context) {
    AwesomeDialog(
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      descTextStyle: const TextStyle(color: Colors.white),
      title: 'Top Up Successful!',
      dialogBackgroundColor: kBackgroundColor,
      width: MediaQuery.of(context).size.width,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      onDismissCallback: (_) {
        Timer(const Duration(milliseconds: 300), () {
          Navigator.of(context).pop();
        });
      },
      btnOkOnPress: () {},
      btnOkText: "Return to E-Wallet",
    ).show();
  }

  void showProgress(BuildContext context) {
    AwesomeDialog(
        dialogBackgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        context: context,
        dialogType: DialogType.noHeader,
        animType: AnimType.bottomSlide,
        body: const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        )).show();
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  CurrencyInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    if (value > max) {
      return oldValue;
    }

    final formatter =
        NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);

    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
