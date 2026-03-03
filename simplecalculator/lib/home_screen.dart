import 'package:calculator/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var UserInput = "";
var answer = "";
const int maxInputLength = 39;

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  void addInput(String value) {
    setState(() {
      if (UserInput.length < maxInputLength) UserInput += value;
      // Scroll to end whenever input changes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  void deleteInput() {
    setState(() {
      if (UserInput.isNotEmpty) {
        UserInput = UserInput.substring(0, UserInput.length - 1);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              // Display
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * (10 / 360),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Multi-line input with wrapping
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.2,
                        ),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [
                              Text(
                                UserInput,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.08,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Answer display
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          answer,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.07,
                            color: const Color.fromARGB(255, 235, 158, 43),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),

              // Buttons
              SizedBox(height: 30),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyButton(
                          text: "AC",
                          onpressed: () {
                            setState(() {
                              UserInput = "";
                              answer = "";
                            });
                          },
                        ),
                        MyButton(text: "+/-", onpressed: () => addInput("+/-")),
                        MyButton(text: "%", onpressed: () => addInput("%")),
                        MyButton(
                          text: "/",
                          clr: const Color(0xffffa00a),
                          onpressed: () => addInput("/"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(text: "7", onpressed: () => addInput("7")),
                        MyButton(text: "8", onpressed: () => addInput("8")),
                        MyButton(text: "9", onpressed: () => addInput("9")),
                        MyButton(
                          text: "x",
                          clr: const Color(0xffffa00a),
                          onpressed: () => addInput("x"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(text: "4", onpressed: () => addInput("4")),
                        MyButton(text: "5", onpressed: () => addInput("5")),
                        MyButton(text: "6", onpressed: () => addInput("6")),
                        MyButton(
                          text: "-",
                          clr: const Color(0xffffa00a),
                          onpressed: () => addInput("-"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(text: "1", onpressed: () => addInput("1")),
                        MyButton(text: "2", onpressed: () => addInput("2")),
                        MyButton(text: "3", onpressed: () => addInput("3")),
                        MyButton(
                          text: "+",
                          clr: const Color(0xffffa00a),
                          onpressed: () => addInput("+"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(text: "0", onpressed: () => addInput("0")),
                        MyButton(text: ".", onpressed: () => addInput(".")),
                        MyButton(text: "DEL", onpressed: deleteInput),
                        MyButton(
                          text: "=",
                          clr: const Color(0xffffa00a),
                          onpressed: () {
                            equalPress();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Safe evaluation
void equalPress() {
  try {
    String finaluserInput = UserInput.replaceAll('x', '*');
    Parser p = Parser();
    Expression expression = p.parse(finaluserInput);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    answer = eval.toString();
  } catch (e) {
    answer = "Shiii hisaaab kr";
  }
}
