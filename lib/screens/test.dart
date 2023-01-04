import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/testModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/Test.dart';
import '../data/card_generator.dart';
import '../widgets/card_widget.dart';

class Test extends StatefulWidget {
  String id;
  Test({key, required this.id});

  @override
  State<Test> createState() => _TestState(id: id);
}

class _TestState extends State<Test> {
  String id;
  late BoxDecoration status;
  @override
  void initState() {
    status = BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
    super.initState();
  }
  _TestState({key, required this.id});
  @override
  Widget build(BuildContext context) {
    TestModel model = new TestModel(id: id);

    return Scaffold(
        body: Container(
      height: 1000,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Images/backgrounds/testpage.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        child: Text(""),
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("Images/icons/close_button.png")),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 205,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                  child: SizedBox(
                    width: 55,
                    height: 55,
                    child: PopupMenuButton(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      icon: SvgPicture.asset("Images/icons/svg/more-fill.svg"),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: Text(""),
                          // child: GestureDetector(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, "/settings");
                          //   },
                          //   child: Row(
                          //     children: [
                          //       SvgPicture.asset(
                          //           "Images/icons/svg/gear-fill.svg"),
                          //       const SizedBox(
                          //         width: 10,
                          //       ),
                          //       const Text("Settings"),
                          //     ],
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      CardWidget.emptyCard(
                        width: 350,
                        height: 512,
                        image: "Images/cards/testpage/1.png",
                        updateParent: () {},
                      ),
                    ],
                  ),
                  CardWidget.emptyCard(
                    width: 350,
                    height: 512,
                    image: "Images/cards/testpage/2.png",
                    updateParent: () {},
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.height > 652)
                            ? 350
                            : 350 - 50,
                        height: (MediaQuery.of(context).size.height > 751)
                            ? 512
                            : (MediaQuery.of(context).size.height > 652)
                                ? 512
                                : 512 - 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/cards/testpage/0.png"),
                              fit: BoxFit.fill),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "Question One",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                minFontSize: 24,
                                stepGranularity: 1,
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Color(0xff551B1B),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Column(
                                children: [
                                  ShakeWidget(
                                    shakeConstant: ShakeRotateConstant2(),
                                    autoPlay: false,
                                    enableWebMouseHover: true,
                                    child: GestureDetector(
                                      child: Opacity(
                                        opacity: 0.3,
                                        child: Container(
                                          width: 305,
                                          height: 71,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xff000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Color(0xfffff4f4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //
                                    },
                                    child: Container(
                                      width: 305,
                                      height: 71,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color:
                                            Color.fromARGB(55, 242, 242, 242),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //
                                    },
                                    child: Container(
                                      width: 305,
                                      height: 71,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color:
                                            Color.fromARGB(55, 242, 242, 242),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    ));
  }
}
