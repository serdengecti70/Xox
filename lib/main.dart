import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Xox(),
    );
  }
}

class Xox extends StatefulWidget {
  @override
  _XoxState createState() => _XoxState();
}

class _XoxState extends State<Xox> {
  List<String> valueList = List.generate(9, (index) => "");
  bool turn = false;
  bool win = true;
  String turnLetter = "";
  String winnerLetter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: turnLetter.isEmpty ? Text("X turn") : Text("$turnLetter turn"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
            9,
            (index) => Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: win
                          ? () {
                              setState(() {
                                if (turn) {
                                  if (valueList[index].isEmpty) {
                                    valueList[index] = "O";
                                    turn = false;
                                    turnLetter = "X";
                                    win = winner("O");
                                    if (win == false) {
                                      winnerLetter = "O";
                                    }
                                  }
                                } else {
                                  if (valueList[index].isEmpty) {
                                    valueList[index] = "X";
                                    turn = true;
                                    turnLetter = "O";
                                    win = winner("X");
                                    if (win == false) {
                                      winnerLetter = "X";
                                    }
                                  }
                                }
                              });
                            }
                          : () {
                              _simpeDialog(winnerLetter);
                            },
                      child: Text(valueList[index]),
                    ),
                  ),
                )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resetAll();
        },
        child: Icon(Icons.archive),
      ),
    );
  }

  void resetAll() {
    setState(() {
      win = true;
      valueList.clear();
      valueList = List.generate(9, (index) => "");
      winnerLetter = "";
      turn = false;
    });
  }

  // 123 456 789  147 258 369 159 357
  // 012 345 678  036 147 258 048 246
  bool winner(String letter) {
    for (int i = 0; i < 7; i += 3) {
      if (valueList[i] == letter &&
          valueList[i + 1] == letter &&
          valueList[i + 2] == letter) {
        return false;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (valueList[i] == letter &&
          valueList[i + 3] == letter &&
          valueList[i + 6] == letter) {
        return false;
      }
    }
    for (int i = 0; i < 2; i++) {
      if (valueList[0] == letter &&
          valueList[4] == letter &&
          valueList[8] == letter) {
        return false;
      }
      if (valueList[2] == letter &&
          valueList[4] == letter &&
          valueList[6] == letter) {
        return false;
      }
    }

    return true;
  }

  _simpeDialog(String letter) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RaisedButton(
            child: Text("$letter Winner"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        });
  }
}
