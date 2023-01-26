import 'package:cardflip/data/category.dart';
import 'package:cardflip/data/tag.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/deck.dart';
import 'package:cardflip/data/card.dart';

class DeckModel {
  final List<Deck> recentDecks = [];
  final List<Deck> userPreferences = [];
  final List<Deck> topRatedDecks = [];
  final _tagCollection = FirebaseFirestore.instance.collection("tag");
  final _deckCollection = FirebaseFirestore.instance.collection("deck");
  final _reportCollection = FirebaseFirestore.instance.collection("reports");
  final _categoryCollection =
      FirebaseFirestore.instance.collection("categories");
  final UserModel userModel = UserModel();
  Future<List<dynamic>> getData() async {
    QuerySnapshot querySnapshot = await _tagCollection.get();
    final data = querySnapshot.docs
        .map((doc) => {"name": doc.get("name"), "id": doc.id})
        .toList();
    return data;
  }

  Future deleteDeck(String id) {
    return _deckCollection.doc(id).delete();
  }

  Future<List<Future<Deck>>> deckByTagID(String id) async {
    QuerySnapshot querySnapshot =
        await _deckCollection.where("tags", arrayContains: id).get();
    final data = querySnapshot.docs.map((doc) async {
      final deck = doc;
      List<Card> cards = [];
      final flashcards = deck.get("flashcards");
      for (int i = 0; i < flashcards.length; i++) {
        cards.add(Card.fromMap(flashcards[i]));
      }
      List<String> likes =
          (deck.get("likes") as List).map((e) => e as String).toList();
      return Deck(
        name: deck.get("name"),
        description: deck.get("description"),
        likes: likes,
        id: deck.id,
        userID: deck.get('userID'),
        cards: cards,
        tags: (deck.get("tags") as List).map((item) => item as String).toList(),
        user: await userModel.getUserByID(deck.get("userID")),
      );
    }).toList();

    return data;
  }

  Future addLike(String deckID, String userID) {
    return _deckCollection.doc(deckID).update({
      "likes": FieldValue.arrayUnion([userID])
    });
  }

  Future removeLike(String deckID, String userID) {
    return _deckCollection.doc(deckID).update({
      "likes": FieldValue.arrayRemove([userID])
    });
  }

  Future addReport(String deckID, String userID, String reporterID) {
    return _reportCollection.add({
      "deckID": deckID,
      "userID": userID,
      "reporterID": reporterID,
      "date": DateTime.now(),
    });
  }

  Future<List<String>> getReportsByUserID(String userID) async {
    QuerySnapshot querySnapshot =
        await _reportCollection.where("userID", isEqualTo: userID).get();
    final data =
        querySnapshot.docs.map((doc) => doc.get("deckID") as String).toList();
    return data;
  }

  Future<List<String>> getLikesByUserID(String userID) async {
    QuerySnapshot querySnapshot =
        await _deckCollection.where("likes", arrayContains: userID).get();
    final data = querySnapshot.docs.map((doc) => doc.id).toList();
    return data;
  }

  Future updateDeck(
      String title, String description, List<String> tags, String id) {
    return _deckCollection
        .doc(id)
        .update({"name": title, "description": description, "tags": tags});
  }

  Future addFlashcards(List<Map<String, String>> flashcards, String id) {
    return _deckCollection.doc(id).update({
      "flashcards": flashcards,
    });
  }

  Future createDeck(
      String title, String description, List<String> tags, String userID) {
    return _deckCollection.add({
      "name": title,
      "description": description,
      "tags": tags,
      "userID": userID,
      "rating": "0",
      "flashcards": [],
      "createdat": DateTime.now(),
      "leaderboard": [],
      "likes": []
    });
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
    List<String> likes =
        (deck.get("likes") as List).map((e) => e as String).toList();
    return Deck(
      name: deck.get("name"),
      description: deck.get("description"),
      likes: likes,
      id: deck.id,
      userID: deck.get('userID'),
      cards: cards,
      tags: (deck.get("tags") as List).map((item) => item as String).toList(),
      user: await userModel.getUserByID(deck.get("userID")),
    );
  }

  Future<List<Deck>> decksByQuery(String query) async {
    QuerySnapshot querySnapshot = await _deckCollection.get();
    final data = (querySnapshot.docs.map((doc) =>
        {"id": doc.id, "name": doc.get("name"), "data": doc.data()})).toList();
    List<Deck> result = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i]["name"]
          .trim()
          .toLowerCase()
          .contains(query.trim().toLowerCase())) {
        result.add(Deck.fromMap(
            data[i]["data"],
            await userModel.getUserByID(data[i]["data"]["userID"]),
            data[i]["id"]));
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
        "vector": "Images/vectors/categories/category_${doc.get("name")}.png",
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
        List<String> likes =
            (doc.get("likes") as List).map((e) => e as String).toList();
        data.add(Deck(
          name: doc.get("name"),
          description: doc.get("description"),
          likes: likes,
          id: doc.id,
          userID: doc.get('userID'),
          cards: cards,
          tags:
              (doc.get("tags") as List).map((item) => item as String).toList(),
          user: await userModel.getUserByID(doc.get("userID")),
        ));
      }
    }
    return data;
  }

  Future<List<Deck>> getUserPreference(List userTags) async {
    List<Deck> data = [];
    for (String tag in userTags) {
      QuerySnapshot querySnapshot = await _deckCollection
          .where(
            "tags",
            arrayContains: tag,
          )
          .get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        QueryDocumentSnapshot<Object?> doc = querySnapshot.docs[i];
        List<Card> cards = [];
        final flashcards = doc.get("flashcards");
        for (int i = 0; i < flashcards.length; i++) {
          cards.add(Card.fromMap(flashcards[i]));
        }
        data.removeWhere((element) => element.deckID == doc.id);
        List<String> likes =
            (doc.get("likes") as List).map((e) => e as String).toList();
        data.add(Deck(
          name: doc.get("name"),
          description: doc.get("description"),
          likes: likes,
          id: doc.id,
          userID: doc.get('userID'),
          cards: cards,
          tags:
              (doc.get("tags") as List).map((item) => item as String).toList(),
          user: await userModel.getUserByID(doc.get("userID")),
        ));
      }
    }

    return data;
  }

  Future<List<Tag>> tagsByQuery(String query) async {
    QuerySnapshot querySnapshot = await _tagCollection.get();
    final data = (querySnapshot.docs
        .map((doc) => Tag(tagID: doc.id, name: doc.get("name")))).toList();
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

  Future<List<Future<Deck>>> deckByUserID(String id) async {
    final decks = await _deckCollection.where("userID", isEqualTo: id).get();
    return decks.docs
        .map((e) async =>
            Deck.fromSnapshot(e, await userModel.getUserByID(e["userID"])))
        .toList();
  }

  Future<List<Future<Deck>>> getRecentlyAddedDecks(String id) async {
    final decks = await _deckCollection
        .where("userID", isEqualTo: id)
        .orderBy("createdat", descending: true)
        .limit(4)
        .get();
    final data = decks.docs
        .map((e) async =>
            Deck.fromSnapshot(e, await userModel.getUserByID(e["userID"])))
        .toList();
    return data;
  }

  Future<List<Deck>> sortDecksByDate() async {
    QuerySnapshot querySnapshot =
        await _deckCollection.orderBy("createdat", descending: true).get();
    final data = (querySnapshot.docs.map((doc) =>
        {"id": doc.id, "name": doc.get("name"), "data": doc.data()})).toList();
    List<Deck> result = [];
    for (int i = 0; i < data.length; i++) {
      result.add(Deck.fromMap(
          data[i]["data"],
          await userModel.getUserByID(data[i]["data"]["userID"]),
          data[i]["id"]));
    }
    return result;
  }

  Future<List<Deck>> sortDecksByUpvotes() async {
    QuerySnapshot querySnapshot =
        await _deckCollection.orderBy("rating", descending: true).get();
    final data = (querySnapshot.docs.map((doc) =>
        {"id": doc.id, "name": doc.get("name"), "data": doc.data()})).toList();
    List<Deck> result = [];
    for (int i = 0; i < data.length; i++) {
      result.add(Deck.fromMap(
          data[i]["data"],
          await userModel.getUserByID(data[i]["data"]["userID"]),
          data[i]["id"]));
    }
    return result;
  }

  Future<Map<String, dynamic>> getDeckByLeaderboardUserID(String id) async {
    final decks = await _deckCollection.where("leaderboard", arrayContainsAny: [
      {"rank": 1, "userID": id},
      {"rank": 2, "userID": id},
      {"rank": 3, "userID": id}
    ]).get();
    final result = decks.docs
        .map((e) async =>
            Deck.fromSnapshot(e, await userModel.getUserByID(e["userID"])))
        .toList();
    return {
      "data": result,
      "leaderboard": decks.docs.map((e) => e["leaderboard"]).toList()
    };
  }

  Future<List<Future<Deck>>> getTopRatedDecks(String userid) {
    return _deckCollection
        .where("userID", isEqualTo: userid)
        .orderBy("rating", descending: true)
        .limit(3)
        .get()
        .then((value) => value.docs
            .map((e) async =>
                Deck.fromSnapshot(e, await userModel.getUserByID(e["userID"])))
            .toList());
  }

  Future leaderboardUsers(String id) async {
    var querySnapshot = await _deckCollection.doc(id).get();

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

  List deckTerms(Deck deck) {
    List<String> terms = [];
    for (Card card in deck.cards) {
      terms.add(card.term);
    }
    return terms;
  }

  int get totalLength => userPreferences.length + recentDecks.length;
}
