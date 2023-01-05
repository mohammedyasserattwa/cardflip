// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";

class AddFlashcards extends StatefulWidget {
  const AddFlashcards({super.key});

  @override
  State<AddFlashcards> createState() => _AddFlashcardsState();
}

class _AddFlashcardsState extends State<AddFlashcards> {
  final _keyParams = {
    "Term": GlobalKey<FormState>(),
    "Defination": GlobalKey<FormState>(),
  };

  List resultedData = [];

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
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 50),
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
                              width: 40,
                              height: 40,
                              child: const Text(""))),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('Add Flashcard',
                          style: TextStyle(
                              color: Color(0xFF191C32),
                              fontFamily: 'Poppins',
                              fontSize: 45,
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.withOpacity(0.25)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 20),
                                    child: Text(
                                      'Term',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 26,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 230, right: 15, top: 10),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "Images/icons/trash.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 12.0, right: 12),
                                child: TextFormField(
                                  key: _keyParams['Term'],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 20),
                                child: Text(
                                  'Definition',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 26,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  height: 130,
                                  child: TextFormField(
                                    maxLines: null,
                                    key: _keyParams['Defination'],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {},
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
                  height: 150,
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(0.30)),
                          width: 85,
                          height: 35,
                          child: const Text("Done",
                              style: TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)))),
                ),
              ],
            )));
  }
}
