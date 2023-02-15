import 'dart:math';

import 'package:calc_game/const.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String a, b, op;
  var ans = '';
  var numPadNum = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0'
  ];
  var opList = ['+', '-'];

  @override
  void initState() {
    super.initState();
    randomiseVar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Expanded(
              flex: 12,
              child: Container(
                color: Colors.grey.shade800,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '$a $op $b = ',
                    style: whiteTextStyle,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        border: Border.all(
                            color: Colors.grey.shade400, width: 0.5)),
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ans,
                        style: whiteTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ]),
              )),
          Expanded(
            flex: 13,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: numPadNum.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 0.5),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              numPadNum[index],
                              style: blackTextStyle,
                            ),
                          ),
                        ),
                        onTap: () => numPadClick(numPadNum[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void numPadClick(String ele) {
    switch (ele) {
      case '=':
        if (ans == '') {
          showNackBar('Answer the question');
        } else {
          checkAnswer(a, b, op);
        }
        break;
      case 'DEL':
        if (ans != '') {
          setState(() {
            ans = ans.substring(0, ans.length - 1);
          });
        }
        break;
      case 'C':
        setState(() {
          ans = '';
        });
        break;
      default:
        if (ans.length < 3) {
          setState(() {
            ans += ele;
          });
        }
    }
  }

  void randomiseVar() {
    setState(() {
      a = (Random().nextInt(25) + 1).toString();
      b = (Random().nextInt(25) + 1).toString();
      op = opList[Random().nextInt(opList.length)];
      ans = '';
    });
  }

  SnackBar snackBar(String s) {
    return SnackBar(
      content: Text(s),
    );
  }

  void checkAnswer(String a, String b, String op) {
    switch (op) {
      case '+':
        if ((int.parse(a) + int.parse(b)) == int.parse(ans)) {
          showNackBar('Correct');
          randomiseVar();
        } else {
          showNackBar('Incorrect');
        }
        break;
      case '-':
        if ((int.parse(a) - int.parse(b)) == int.parse(ans)) {
          showNackBar('Correct');
          randomiseVar();
        } else {
          showNackBar('Incorrect');
        }
        break;
      default:
        print('operator error');
    }
  }

  void showNackBar(String s) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar(s));
  }
}
