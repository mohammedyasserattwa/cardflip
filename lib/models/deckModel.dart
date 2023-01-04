import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/deck.dart';
import 'package:cardflip/data/card.dart';
import '../data/user.dart';

class DeckModel {
  final List<Deck> recentDecks = [
    Deck(
        name: "Meteorology",
        description:
            "Some vocabulary terms and definitions related to meteorology",
        author: "Lara",
        id: "1",
        rating: 4099,
        cards: [
          Card(
              id: 0,
              term: "Air Mass",
              definition:
                  "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
          Card(
              id: 1,
              term: "Continental Polar",
              definition: "cold, dry air mass that forms over land"),
          Card(
              id: 2,
              term: "Continental Tropical",
              definition: "warm, dry air mass that forms over land"),
          Card(
              id: 3,
              term: "Maritime Polar",
              definition: "cold, moist air mass that forms over cold oceans"),
          Card(
              id: 4,
              term: "Maritime Tropical",
              definition: "warm, moist air mass that is formed over water"),
          Card(
              id: 5,
              term: "Continental Arctic",
              definition: "very cold, very dry air mass"),
        ]),
    Deck(
        name: "Astronomy",
        description:
            "Some vocabulary terms and definitions related to astronomy",
        author: "Yasser",
        id: "2",
        rating: 2949,
        cards: [
          Card(
              id: 0,
              term: "Satellite",
              definition:
                  "An object that revolves around another object in space"),
          Card(
              id: 1,
              term: "Orbiter",
              definition:
                  "The main part of the space shuttle that has wings like an airplane."),
          Card(
              id: 2,
              term: "Astronaut milestones",
              definition:
                  "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
          Card(
              id: 3,
              term: "Revolution",
              definition: "The movement of an object around another object"),
          Card(
              id: 4,
              term: "Horizon",
              definition: "the line at which the sky and Earth appear to meet"),
        ]),
    Deck(
        name: "Computer Science",
        description:
            "Some vocabulary terms and definitions related to Computer Science",
        author: "Omar",
        id: "3",
        userID: "01f4bll5",
        rating: 3000,
        cards: [
          Card(
              id: 0,
              term: "Central Processing Unit (CPU)",
              definition:
                  "Brain of the computer that performs instructions defined by software"),
          Card(
              id: 1,
              term: "Operating System (OS)",
              definition:
                  "Software used to control the computer and its peripheral equipment."),
          Card(
              id: 2,
              term: "Software",
              definition:
                  "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
          Card(
              id: 3,
              term: "Hardware",
              definition:
                  "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
          Card(
              id: 4,
              term: "Machine Language",
              definition: "Programs written in binary code"),
        ])
  ];
  final List<Deck> userPreferences = [
    Deck(
        name: "Geography",
        description:
            "Some vocabulary terms and definitions related to meteorology",
        author: "Shehab",
        id: "5",
        rating: 4099,
        cards: [
          Card(
              id: 0,
              term: "Air Mass",
              definition:
                  "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
          Card(
              id: 1,
              term: "Continental Polar",
              definition: "cold, dry air mass that forms over land"),
          Card(
              id: 2,
              term: "Continental Tropical",
              definition: "warm, dry air mass that forms over land"),
          Card(
              id: 3,
              term: "Maritime Polar",
              definition: "cold, moist air mass that forms over cold oceans"),
          Card(
              id: 4,
              term: "Maritime Tropical",
              definition: "warm, moist air mass that is formed over water"),
          Card(
              id: 5,
              term: "Continental Arctic",
              definition: "very cold, very dry air mass"),
        ]),
    Deck(
        name: "Planets",
        description:
            "Some vocabulary terms and definitions related to astronomy",
        author: "Yasser",
        id: "6",
        rating: 2949,
        cards: [
          Card(
              id: 0,
              term: "Satellite",
              definition:
                  "An object that revolves around another object in space"),
          Card(
              id: 1,
              term: "Orbiter",
              definition:
                  "The main part of the space shuttle that has wings like an airplane."),
          Card(
              id: 2,
              term: "Astronaut milestones",
              definition:
                  "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
          Card(
              id: 3,
              term: "Revolution",
              definition: "The movement of an object around another object"),
          Card(
              id: 4,
              term: "Horizon",
              definition: "the line at which the sky and Earth appear to meet"),
        ]),
    Deck(
        name: "Machine Learning",
        description:
            "Some vocabulary terms and definitions related to Computer Science",
        author: "Omar",
        id: "7",
        rating: 3000,
        cards: [
          Card(
              id: 0,
              term: "Central Processing Unit (CPU)",
              definition:
                  "Brain of the computer that performs instructions defined by software"),
          Card(
              id: 1,
              term: "Operating System (OS)",
              definition:
                  "Software used to control the computer and its peripheral equipment."),
          Card(
              id: 2,
              term: "Software",
              definition:
                  "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
          Card(
              id: 3,
              term: "Hardware",
              definition:
                  "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
          Card(
              id: 4,
              term: "Machine Language",
              definition: "Programs written in binary code"),
        ]),
    Deck(
        name: "Image Processing",
        description:
            "Some vocabulary terms and definitions related to Computer Science",
        author: "Omar",
        id: "8",
        rating: 3000,
        cards: [
          Card(
              id: 0,
              term: "Central Processing Unit (CPU)",
              definition:
                  "Brain of the computer that performs instructions defined by software"),
          Card(
              id: 1,
              term: "Operating System (OS)",
              definition:
                  "Software used to control the computer and its peripheral equipment."),
          Card(
              id: 2,
              term: "Software",
              definition:
                  "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
          Card(
              id: 3,
              term: "Hardware",
              definition:
                  "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
          Card(
              id: 4,
              term: "Machine Language",
              definition: "Programs written in binary code"),
        ]),
    Deck(
        name: "Artificial Intelligence",
        description:
            "Some vocabulary terms and definitions related to Computer Science",
        author: "Omar",
        id: "9",
        rating: 3000,
        cards: [
          Card(
              id: 0,
              term: "Central Processing Unit (CPU)",
              definition:
                  "Brain of the computer that performs instructions defined by software"),
          Card(
              id: 1,
              term: "Operating System (OS)",
              definition:
                  "Software used to control the computer and its peripheral equipment."),
          Card(
              id: 2,
              term: "Software",
              definition:
                  "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
          Card(
              id: 3,
              term: "Hardware",
              definition:
                  "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
          Card(
              id: 4,
              term: "Machine Language",
              definition: "Programs written in binary code"),
        ]),
    Deck(
        name: "Flutter",
        description:
            "Some vocabulary terms and definitions related to Computer Science",
        author: "Omar",
        id: "10",
        rating: 3000,
        cards: [
          Card(
              id: 0,
              term: "Central Processing Unit (CPU)",
              definition:
                  "Brain of the computer that performs instructions defined by software"),
          Card(
              id: 1,
              term: "Operating System (OS)",
              definition:
                  "Software used to control the computer and its peripheral equipment."),
          Card(
              id: 2,
              term: "Software",
              definition:
                  "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
          Card(
              id: 3,
              term: "Hardware",
              definition:
                  "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
          Card(
              id: 4,
              term: "Machine Language",
              definition: "Programs written in binary code"),
        ]),
  ];
  final List<Deck> topRatedDecks = [
    Deck(
        name: "Geography",
        description:
            "Some vocabulary terms and definitions related to meteorology",
        author: "Shehab",
        id: "5",
        rating: 4099,
        cards: [
          Card(
              id: 0,
              term: "Air Mass",
              definition:
                  "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
          Card(
              id: 1,
              term: "Continental Polar",
              definition: "cold, dry air mass that forms over land"),
          Card(
              id: 2,
              term: "Continental Tropical",
              definition: "warm, dry air mass that forms over land"),
          Card(
              id: 3,
              term: "Maritime Polar",
              definition: "cold, moist air mass that forms over cold oceans"),
          Card(
              id: 4,
              term: "Maritime Tropical",
              definition: "warm, moist air mass that is formed over water"),
          Card(
              id: 5,
              term: "Continental Arctic",
              definition: "very cold, very dry air mass"),
        ]),
    Deck(
        name: "Planets",
        description:
            "Some vocabulary terms and definitions related to astronomy",
        author: "Yasser",
        id: "6",
        rating: 2949,
        cards: [
          Card(
              id: 0,
              term: "Satellite",
              definition:
                  "An object that revolves around another object in space"),
          Card(
              id: 1,
              term: "Orbiter",
              definition:
                  "The main part of the space shuttle that has wings like an airplane."),
          Card(
              id: 2,
              term: "Astronaut milestones",
              definition:
                  "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
          Card(
              id: 3,
              term: "Revolution",
              definition: "The movement of an object around another object"),
          Card(
              id: 4,
              term: "Horizon",
              definition: "the line at which the sky and Earth appear to meet"),
        ]),
    Deck(
        name: "Machine Learning",
        description:
            "Some vocabulary terms and definitions related to Computer Science",
        author: "Omar",
        id: "7",
        rating: 3000,
        cards: [
          Card(
              id: 0,
              term: "Central Processing Unit (CPU)",
              definition:
                  "Brain of the computer that performs instructions defined by software"),
          Card(
              id: 1,
              term: "Operating System (OS)",
              definition:
                  "Software used to control the computer and its peripheral equipment."),
          Card(
              id: 2,
              term: "Software",
              definition:
                  "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
          Card(
              id: 3,
              term: "Hardware",
              definition:
                  "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
          Card(
              id: 4,
              term: "Machine Language",
              definition: "Programs written in binary code"),
        ]),
  ];
  final _tagCollection = FirebaseFirestore.instance.collection("tag");
  final _deckCollection = FirebaseFirestore.instance.collection("deck");

  Future<List<dynamic>> getData() async {
    QuerySnapshot querySnapshot = await _tagCollection.get();
    final data = querySnapshot.docs.map((doc) => doc.get("name")).toList();
    return data;
  }

  Deck deckByIDRecent(String id) {
    return recentDecks.where((element) => element.id == id).toList()[0];
  }

  Deck deckByIDPreference(String id) {
    return userPreferences.where((element) => element.id == id).toList()[0];
  }

  Deck deckByID(String id) {
    List<Deck> decks =
        recentDecks.where((element) => element.id == id).toList();
    if (decks.isNotEmpty) {
      return decks[0];
    }
    return userPreferences.where((element) => element.id == id).toList()[0];
  }

  Future<List<Map>> decksByQuery(String query) async {
    QuerySnapshot querySnapshot = await _deckCollection
        .where("name", isGreaterThanOrEqualTo: query)
        .get();
    final data = (querySnapshot.docs
        .map((doc) => {"id": doc.id, "name": doc.get("name")})).toList();
    return data;
  }

  List<Deck> deckByUserID(String id) {
    List<Deck> decks =
        recentDecks.where((element) => element.userID == id).toList();
    if (decks.isNotEmpty) {
      return decks;
    }
    return userPreferences.where((element) => element.userID == id).toList();
  }

  List<Deck> filter(List<Deck> deckList) {
    /// Sorting the cards by term.
    deckList.sort(((a, b) => a.deckName
        .toLowerCase()
        .trim()
        .compareTo(b.deckName.toLowerCase().trim())));
    return deckList;
  }

  int get totalLength => userPreferences.length + recentDecks.length;
}
