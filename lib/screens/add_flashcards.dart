// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import "package:flutter/material.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';

class AddFlashcards extends StatefulWidget {
  const AddFlashcards({super.key});

  @override
  State<AddFlashcards> createState() => _AddFlashcardsState();
}

class _AddFlashcardsState extends State<AddFlashcards> {
  List ControllerDefinitionData = [TextEditingController()];
  List ControllerTermData = [TextEditingController()];
  List termkeys = [GlobalKey<FormState>()];
  List definitionkeys = [GlobalKey<FormState>()];

  List resultedData = [Column()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Images/backgrounds/homepage.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50, left: 15),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "Images/icons/arrow-left-s-line.png"),
                                fit: BoxFit.cover),
                          ),
                          width: 45,
                          height: 45,
                          child: const Text(""))),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('Add Flashcard',
                      style: TextStyle(
                          color: Color(0xBF000000),
                          fontFamily: 'PolySans_Median',
                          fontSize: 42,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(
                    child: NoGlowScroll(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          for (int index = 0;
                              index < resultedData.length;
                              index++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 25),
                              child: Container(
                                height: 350,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color.fromARGB(42, 167, 167, 167)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, top: 20),
                                            child: Text(
                                              'Term',
                                              style: TextStyle(
                                                fontFamily: 'PolySans_Median',
                                                fontSize: 24,
                                                color: Color(0xCC000000),
                                                // fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 207, right: 15, top: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  resultedData.remove(
                                                      resultedData[index]);
                                                });
                                              },
                                              child: index == 0
                                                  ? Container()
                                                  : Opacity(
                                                      opacity: 0.85,
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                top: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "Images/icons/trash.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 17.0, right: 17),
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'PolySans_Neutral',
                                            fontSize: 24,
                                            color:
                                                Color.fromARGB(255, 49, 49, 49),
                                          ),
                                          controller: ControllerTermData[index],
                                          key: termkeys[index],
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20.0, 17.0, 10.0, 17.0),
                                            isDense: true,
                                            filled: true,
                                            fillColor: Color.fromARGB(
                                                93, 167, 167, 167),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, top: 20),
                                        child: Text(
                                          'Definition',
                                          style: TextStyle(
                                            fontFamily: 'PolySans_Median',
                                            fontSize: 24,
                                            color: Color(0xCC000000),
                                            // fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 17, right: 17, top: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                93, 167, 167, 167),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          height: 130,
                                          child: TextField(
                                            maxLines: 5,
                                            style: TextStyle(
                                              fontFamily: 'PolySans_Neutral',
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 49, 49, 49),
                                            ),
                                            controller:
                                                ControllerDefinitionData[index],
                                            key: definitionkeys[index],
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                resultedData.add(Column());
                                ControllerDefinitionData.add(
                                    TextEditingController());
                                ControllerTermData.add(TextEditingController());
                                termkeys.add(GlobalKey<FormState>());
                                definitionkeys.add(GlobalKey<FormState>());
                              });
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("Images/icons/add.png"),
                                      fit: BoxFit.cover),
                                ),
                                width: 40,
                                height: 40,
                                child: const Text(""))),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(right: 20, bottom: 35, top: 65),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              for (int index = 0;
                                  index < ControllerDefinitionData.length;
                                  index++) {
                                if (ControllerDefinitionData[index]
                                        .text
                                        .isEmpty ||
                                    ControllerTermData[index].text.isEmpty)
                                  print('Please enter a text into the fields');
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.withOpacity(0.30)),
                                width: 85,
                                height: 40,
                                child: const Text("Done",
                                    style: TextStyle(
                                        color: Color(0xFF191C32),
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)))),
                      ),
                    ],
                  ),
                )),
              ],
            )));
  }
}
