import 'package:cardflip/data/Leaderboard.dart';
import 'package:cardflip/data/category.dart';
import 'package:cardflip/data/tag.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/deck.dart';
import 'package:cardflip/data/card.dart';
import '../data/User.dart';

class DeckModel {
  // final List<Deck> recentDecks = [
  //   Deck(
  //       name: "Meteorology",
  //       description:
  //           "Some vocabulary terms and definitions related to meteorology",
  //       author: "Lara",
  //       id: "1",
  //       rating: 4099,
  //       tags: [
  //         Tag(name: "math", tagID: "1"),
  //       ],
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Air Mass",
  //             definition:
  //                 "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
  //         Card(
  //             id: '1',
  //             term: "Continental Polar",
  //             definition: "cold, dry air mass that forms over land"),
  //         Card(
  //             id: '2',
  //             term: "Continental Tropical",
  //             definition: "warm, dry air mass that forms over land"),
  //         Card(
  //             id: '3',
  //             term: "Maritime Polar",
  //             definition: "cold, moist air mass that forms over cold oceans"),
  //         Card(
  //             id: '4',
  //             term: "Maritime Tropical",
  //             definition: "warm, moist air mass that is formed over water"),
  //         Card(
  //             id: '5',
  //             term: "Continental Arctic",
  //             definition: "very cold, very dry air mass"),
  //       ]),
  //   Deck(
  //       name: "Astronomy",
  //       description:
  //           "Some vocabulary terms and definitions related to astronomy",
  //       author: "Yasser",
  //       id: "2",
  //       rating: 2949,
  //       tags: [
  //         Tag(name: "math", tagID: "1"),
  //       ],
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Satellite",
  //             definition:
  //                 "An object that revolves around another object in space"),
  //         Card(
  //             id: '1',
  //             term: "Orbiter",
  //             definition:
  //                 "The main part of the space shuttle that has wings like an airplane."),
  //         Card(
  //             id: '2',
  //             term: "Astronaut milestones",
  //             definition:
  //                 "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
  //         Card(
  //             id: '3',
  //             term: "Revolution",
  //             definition: "The movement of an object around another object"),
  //         Card(
  //             id: '4',
  //             term: "Horizon",
  //             definition: "the line at which the sky and Earth appear to meet"),
  //       ]),
  //   Deck(
  //       name: "Computer Science",
  //       description:
  //           "Some vocabulary terms and definitions related to Computer Science",
  //       tags: [
  //         Tag(name: "math", tagID: "1"),
  //       ],
  //       author: "Omar",
  //       id: "3",
  //       userID: "01f4bll5",
  //       rating: 3000,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Central Processing Unit (CPU)",
  //             definition:
  //                 "Brain of the computer that performs instructions defined by software"),
  //         Card(
  //             id: '1',
  //             term: "Operating System (OS)",
  //             definition:
  //                 "Software used to control the computer and its peripheral equipment."),
  //         Card(
  //             id: '2',
  //             term: "Software",
  //             definition:
  //                 "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
  //         Card(
  //             id: '3',
  //             term: "Hardware",
  //             definition:
  //                 "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
  //         Card(
  //             id: '4',
  //             term: "Machine Language",
  //             definition: "Programs written in binary code"),
  //       ])
  // ];
  // final List<Deck> userPreferences = [
  //   Deck(
  //       name: "Geography",
  //       description:
  //           "Some vocabulary terms and definitions related to meteorology",
  //       author: "Shehab",
  //       id: "5",
  //       rating: 4099,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Air Mass",
  //             definition:
  //                 "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
  //         Card(
  //             id: '1',
  //             term: "Continental Polar",
  //             definition: "cold, dry air mass that forms over land"),
  //         Card(
  //             id: '2',
  //             term: "Continental Tropical",
  //             definition: "warm, dry air mass that forms over land"),
  //         Card(
  //             id: '3',
  //             term: "Maritime Polar",
  //             definition: "cold, moist air mass that forms over cold oceans"),
  //         Card(
  //             id: '4',
  //             term: "Maritime Tropical",
  //             definition: "warm, moist air mass that is formed over water"),
  //         Card(
  //             id: '5',
  //             term: "Continental Arctic",
  //             definition: "very cold, very dry air mass"),
  //       ]),
  //   Deck(
  //       name: "Planets",
  //       description:
  //           "Some vocabulary terms and definitions related to astronomy",
  //       author: "Yasser",
  //       id: "6",
  //       rating: 2949,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Satellite",
  //             definition:
  //                 "An object that revolves around another object in space"),
  //         Card(
  //             id: '1',
  //             term: "Orbiter",
  //             definition:
  //                 "The main part of the space shuttle that has wings like an airplane."),
  //         Card(
  //             id: '2',
  //             term: "Astronaut milestones",
  //             definition:
  //                 "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
  //         Card(
  //             id: '3',
  //             term: "Revolution",
  //             definition: "The movement of an object around another object"),
  //         Card(
  //             id: '4',
  //             term: "Horizon",
  //             definition: "the line at which the sky and Earth appear to meet"),
  //       ]),
  //   Deck(
  //       name: "Machine Learning",
  //       description:
  //           "Some vocabulary terms and definitions related to Computer Science",
  //       author: "Omar",
  //       id: "7",
  //       rating: 3000,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Central Processing Unit (CPU)",
  //             definition:
  //                 "Brain of the computer that performs instructions defined by software"),
  //         Card(
  //             id: '1',
  //             term: "Operating System (OS)",
  //             definition:
  //                 "Software used to control the computer and its peripheral equipment."),
  //         Card(
  //             id: '2',
  //             term: "Software",
  //             definition:
  //                 "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
  //         Card(
  //             id: '3',
  //             term: "Hardware",
  //             definition:
  //                 "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
  //         Card(
  //             id: '4',
  //             term: "Machine Language",
  //             definition: "Programs written in binary code"),
  //       ]),
  //   Deck(
  //       name: "Image Processing",
  //       description:
  //           "Some vocabulary terms and definitions related to Computer Science",
  //       author: "Omar",
  //       id: "8",
  //       rating: 3000,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Central Processing Unit (CPU)",
  //             definition:
  //                 "Brain of the computer that performs instructions defined by software"),
  //         Card(
  //             id: '1',
  //             term: "Operating System (OS)",
  //             definition:
  //                 "Software used to control the computer and its peripheral equipment."),
  //         Card(
  //             id: '2',
  //             term: "Software",
  //             definition:
  //                 "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
  //         Card(
  //             id: '3',
  //             term: "Hardware",
  //             definition:
  //                 "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
  //         Card(
  //             id: '4',
  //             term: "Machine Language",
  //             definition: "Programs written in binary code"),
  //       ]),
  //   Deck(
  //       name: "Artificial Intelligence",
  //       description:
  //           "Some vocabulary terms and definitions related to Computer Science",
  //       author: "Omar",
  //       id: "9",
  //       rating: 3000,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Central Processing Unit (CPU)",
  //             definition:
  //                 "Brain of the computer that performs instructions defined by software"),
  //         Card(
  //             id: '1',
  //             term: "Operating System (OS)",
  //             definition:
  //                 "Software used to control the computer and its peripheral equipment."),
  //         Card(
  //             id: '2',
  //             term: "Software",
  //             definition:
  //                 "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
  //         Card(
  //             id: '3',
  //             term: "Hardware",
  //             definition:
  //                 "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
  //         Card(
  //             id: '4',
  //             term: "Machine Language",
  //             definition: "Programs written in binary code"),
  //       ]),
  //   Deck(
  //       name: "Flutter",
  //       description:
  //           "Some vocabulary terms and definitions related to Computer Science",
  //       author: "Omar",
  //       id: "10",
  //       rating: 3000,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Central Processing Unit (CPU)",
  //             definition:
  //                 "Brain of the computer that performs instructions defined by software"),
  //         Card(
  //             id: '1',
  //             term: "Operating System (OS)",
  //             definition:
  //                 "Software used to control the computer and its peripheral equipment."),
  //         Card(
  //             id: '2',
  //             term: "Software",
  //             definition:
  //                 "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
  //         Card(
  //             id: '3',
  //             term: "Hardware",
  //             definition:
  //                 "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
  //         Card(
  //             id: '4',
  //             term: "Machine Language",
  //             definition: "Programs written in binary code"),
  //       ]),
  // ];
  // final List<Deck> topRatedDecks = [
  //   Deck(
  //       name: "Geography",
  //       description:
  //           "Some vocabulary terms and definitions related to meteorology",
  //       author: "Shehab",
  //       id: "5",
  //       rating: 4099,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Air Mass",
  //             definition:
  //                 "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
  //         Card(
  //             id: '1',
  //             term: "Continental Polar",
  //             definition: "cold, dry air mass that forms over land"),
  //         Card(
  //             id: '2',
  //             term: "Continental Tropical",
  //             definition: "warm, dry air mass that forms over land"),
  //         Card(
  //             id: '3',
  //             term: "Maritime Polar",
  //             definition: "cold, moist air mass that forms over cold oceans"),
  //         Card(
  //             id: '4',
  //             term: "Maritime Tropical",
  //             definition: "warm, moist air mass that is formed over water"),
  //         Card(
  //             id: '5',
  //             term: "Continental Arctic",
  //             definition: "very cold, very dry air mass"),
  //       ]),
  //   Deck(
  //       name: "Planets",
  //       description:
  //           "Some vocabulary terms and definitions related to astronomy",
  //       author: "Yasser",
  //       id: "6",
  //       rating: 2949,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Satellite",
  //             definition:
  //                 "An object that revolves around another object in space"),
  //         Card(
  //             id: '1',
  //             term: "Orbiter",
  //             definition:
  //                 "The main part of the space shuttle that has wings like an airplane."),
  //         Card(
  //             id: '2',
  //             term: "Astronaut milestones",
  //             definition:
  //                 "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
  //         Card(
  //             id: '3',
  //             term: "Revolution",
  //             definition: "The movement of an object around another object"),
  //         Card(
  //             id: '4',
  //             term: "Horizon",
  //             definition: "the line at which the sky and Earth appear to meet"),
  //       ]),
  //   Deck(
  //       name: "Machine Learning",
  //       description:
  //           "Some vocabulary terms and definitions related to Computer Science",
  //       author: "Omar",
  //       id: "7",
  //       rating: 3000,
  //       cards: [
  //         Card(
  //             id: '0',
  //             term: "Central Processing Unit (CPU)",
  //             definition:
  //                 "Brain of the computer that performs instructions defined by software"),
  //         Card(
  //             id: '1',
  //             term: "Operating System (OS)",
  //             definition:
  //                 "Software used to control the computer and its peripheral equipment."),
  //         Card(
  //             id: '2',
  //             term: "Software",
  //             definition:
  //                 "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
  //         Card(
  //             id: '3',
  //             term: "Hardware",
  //             definition:
  //                 "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
  //         Card(
  //             id: '4',
  //             term: "Machine Language",
  //             definition: "Programs written in binary code"),
  //       ]),
  // ];
  final List<Deck> recentDecks = [];
  final List<Deck> userPreferences = [];
  final List<Deck> topRatedDecks = [];
  final _tagCollection = FirebaseFirestore.instance.collection("tag");
  final _deckCollection = FirebaseFirestore.instance.collection("deck");
  final _categoryCollection =
      FirebaseFirestore.instance.collection("categories");
  final UserModel userModel = UserModel();
  Future<List<dynamic>> getData() async {
    QuerySnapshot querySnapshot = await _tagCollection.get();
    final data = querySnapshot.docs.map((doc) => doc.get("name")).toList();
    return data;
  }

  List<Deck> deckByTagID(String id) {
    return recentDecks
        .where((element) => element.tags.where((e) => e.tagID == id).isNotEmpty)
        .toList();
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

  Future<Deck> getdeckByID(String id) async {
    final deck = await _deckCollection.doc(id).get();
    List<Card> cards = [];
    final flashcards = deck.get("flashcards");
    for (int i = 0; i < flashcards.length; i++) {
      cards.add(Card.fromMap(flashcards[i]));
    }
    return Deck(
      name: deck.get("name"),
      description: deck.get("description"),
      rating: double.parse(deck.get('rating')),
      id: deck.id,
      userID: deck.get('userID'),
      cards: cards,
      user: await userModel.getUserByID(deck.get("userID")),
    );
  }

  Future<List<Map>> decksByQuery(String query) async {
    QuerySnapshot querySnapshot = await _deckCollection.get();
    final data = (querySnapshot.docs
        .map((doc) => {"id": doc.id, "name": doc.get("name")})).toList();
    List<Map> result = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i]["name"]
          .trim()
          .toLowerCase()
          .contains(query.trim().toLowerCase())) {
        result.add(data[i]);
      }
    }
    return result;
  }

  Future<List<Category>> getCategories() async {
    QuerySnapshot categories = await _categoryCollection.get();
    return categories.docs.map((doc) {
      final decks = <Deck>[];
      for (int i = 0; i < doc["decks"].length; i++) {
        getdeckByID(doc["decks"][i]).then((value) => decks.add(value));
      }

      return Category.fromSnapshot({
        "id": doc.id,
        "name": doc.get("name"),
        "decks": decks,
        "vector": "Images/vectors/category_${doc.get("name")}.png",
        "background":
            "Images/backgrounds/category_screen/category_${doc.get("name")}.png"
      });
    }).toList();
  }

  Future<List<Deck>> getDecksByIDs(List<String> deckIDs) async {
    QuerySnapshot querySnapshot = await _deckCollection.get();
    List<Deck> data = [];
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      QueryDocumentSnapshot<Object?> doc = querySnapshot.docs[i];
      List<Card> cards = [];
      final flashcards = doc.get("flashcards");
      for (int i = 0; i < flashcards.length; i++) {
        cards.add(Card.fromMap(flashcards[i]));
      }
      if (deckIDs.contains(doc.id)) {
        data.add(Deck(
          name: doc.get("name"),
          description: doc.get("description"),
          rating: double.parse(doc.get('rating')),
          id: doc.id,
          userID: doc.get('userID'),
          cards: cards,
          user: await userModel.getUserByID(doc.get("userID")),
        ));
      }
    }
    return data;
  }

  Future<List<Deck>> getUserPreference(List userTags) async {
    QuerySnapshot querySnapshot = await _deckCollection.get();

    List<Deck> data = [];
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      QueryDocumentSnapshot<Object?> doc = querySnapshot.docs[i];
      if (userTags
          .toSet()
          .intersection(doc.get("tags").toSet())
          .toList()
          .isNotEmpty) {
        if (data.length < 6) {
          List<Card> cards = [];
          final flashcards = doc.get("flashcards");
          for (int i = 0; i < flashcards.length; i++) {
            cards.add(Card.fromMap(flashcards[i]));
          }
          data.add(Deck(
            name: doc.get("name"),
            description: doc.get("description"),
            rating: double.parse(doc.get('rating')),
            id: doc.id,
            userID: doc.get('userID'),
            cards: cards,
            user: await userModel.getUserByID(doc.get("userID")),
            // tags:
          ));
        }
      }
    }
    return data;
  }

  Future<List<Tag>> tagsByQuery(String query) async {
    QuerySnapshot querySnapshot = await _tagCollection.get();
    final data = (querySnapshot.docs
        .map((doc) => Tag(tagID: doc.id, name: doc.get("name")))).toList();
    List<Tag> result = [];
    List<Tag> temp = List.from(data);

    for (int i = 0; i < temp.length; i++) {
      if (!(data[data.indexOf(temp[i])]
          .name
          .toLowerCase()
          .trim()
          .contains(query.toLowerCase().trim()))) {
        data.remove(temp[i]);
      }
    }
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

  Future leaderboardUsers(String id) async {
    var querySnapshot = await _deckCollection.doc("bvIbRB1Du66aBA8gjeOY").get();

    Map<dynamic, dynamic> data = querySnapshot.data() as Map<dynamic, dynamic>;
    return ((data["leaderboard"] != null) ? data["leaderboard"] : []);
  }

  List<Deck> filter(List<Deck> deckList) {
    /// Sorting the cards by term.
    deckList.sort(((a, b) => a.deckName
        .toLowerCase()
        .trim()
        .compareTo(b.deckName.toLowerCase().trim())));
    return deckList;
  }

  List deckTerms(String id) {
    List<String> terms = [];
    for (Card card in deckByID(id).cards) {
      terms.add(card.term);
    }
    return terms;
  }

  int get totalLength => userPreferences.length + recentDecks.length;
}
