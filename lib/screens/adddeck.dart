// ignore_for_file: unnecessary_new

//import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import "package:flutter/material.dart";
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
// import '../models/libraryModel.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';

main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Adddeck(),
    ));

class Adddeck extends StatefulWidget {
  const Adddeck({key});

  @override
  State<Adddeck> createState() => _AdddeckState();
}

class _AdddeckState extends State<Adddeck> {
  List Controllerdescription = [TextEditingController()];
  List Controllertitle = [TextEditingController()];
  List namekeys = [GlobalKey<FormState>()];
  List descriptionkeys = [GlobalKey<FormState>()];

  List resultedData = [Column()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/deckbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "Images/icons/arrow-left-s-line.png"),
                                fit: BoxFit.cover),
                          ),
                          width: 40,
                          height: 40,
                          child: const Text("")),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text("Create Deck",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xBF000000),
                        fontFamily: 'PolySans_Median',
                        fontSize: 48,
                        fontWeight: FontWeight.w500)),
              ),
              Expanded(
                child: ListView(children: [
                  Text(
                    "Title",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  for (int index = 0; index < resultedData.length; index++)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextField(
                        controller: Controllertitle[index],
                        key: namekeys[index],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          hintText: 'Enter the deck title',
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  for (int index = 0; index < resultedData.length; index++)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextField(
                        controller: Controllerdescription[index],
                        key: descriptionkeys[index],
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          hintText: 'Enter the deck description',
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tags",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MultiSelectContainer(
                        textStyles: MultiSelectTextStyles(
                            textStyle: TextStyle(
                                fontFamily: "PolySans_Neutral",
                                fontSize: 15,
                                color: Color(0xff212523)),
                            selectedTextStyle: TextStyle(
                                fontFamily: "PolySans_Neutral",
                                fontSize: 15,
                                color: Color(0xff212523))),
                        itemsDecoration: MultiSelectDecorations(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.1),
                                ]),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(20)),
                            selectedDecoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffA000A4), width: 1),
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffF4B1EB),
                            )),
                        items: [
                          MultiSelectCard(value: 'Dart', label: 'Dart'),
                          MultiSelectCard(value: 'Python', label: 'Python'),
                          MultiSelectCard(
                            value: 'JavaScript',
                            label: 'JavaScript',
                          ),
                          MultiSelectCard(value: 'Java', label: 'Java'),
                          MultiSelectCard(value: 'C#', label: 'C#'),
                          MultiSelectCard(value: 'C++', label: 'C++'),
                        ],
                        onChange: (allSelectedItems, selectedItem) {}),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(right: 20, bottom: 35),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Controllerdescription.add(TextEditingController());
                        Controllertitle.add(TextEditingController());
                        namekeys.add(GlobalKey<FormState>());
                        descriptionkeys.add(GlobalKey<FormState>());
                      });
                      for (int index = 0;
                          index < Controllerdescription.length;
                          index++) {
                        if (Controllerdescription[index].text.isEmpty ||
                            Controllertitle[index].text.isEmpty)
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
        ),
      ),
    );
  }
}
