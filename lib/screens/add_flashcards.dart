// ignore_for_file: prefer_const_constructors

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
    //TODO: Add a form to add flashcards
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Images/backgrounds/homepage.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 60),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 20),
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
                            padding: const EdgeInsets.only(left: 15, top: 20),
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
                              height: 105,
                              child: TextFormField(
                                maxLines: null,
                                key: _keyParams['Defination'],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
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
                          )
                        ]),
                  ),
                ),
              ],
            )));
  }
}
