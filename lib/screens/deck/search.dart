import 'package:cardflip/data/Repositories/search_provider.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/search_history_data/history.dart';
import 'package:cardflip/main.dart';
import 'package:cardflip/widgets/search/search_input_field.dart';
import 'package:cardflip/widgets/search/search_results.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/deck_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends ConsumerWidget {
  DeckModel deck = DeckModel();
  String? validator(String value) {
    if (value.isEmpty) {
      return "Please Enter a value to search";
    }
    return null;
  }

  void filterPage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return FilterScreen();
        });
  }

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchHistory = ref.watch(HistoryProvider);
    final searchResult = ref.watch(SearchProvider);
    final submitted = ref.watch(SearchSubmitProvider);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/homepage.png"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(SearchSubmitProvider.notifier).state = false;
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
                      child: const Text(""),
                    ),
                  ),
                  Flexible(
                    child: SearchInputField(
                      hint: "Search here..",
                      controller: _searchController,
                    ),
                  ),
                  if (submitted)
                    GestureDetector(
                      onTap: () {
                        filterPage(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x1f1A0404),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          "Images/icons/svg/filter_search.svg",
                          width: 28.12,
                          height: 20.75,
                        ),
                      ),
                    ),
                ],
              ),
              if (submitted)
                Expanded(child: SearchResult(query: searchResult))
              else if (!submitted)
                FutureBuilder(
                    future: searchHistory,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String json = snapshot.data.toString();
                        if (json != "{}") {
                          dynamic data = History.fromJson(json);
                          data = data
                              .where((element) =>
                                  element.uid ==
                                  ref.watch(UserDataProvider)!.id)
                              .toList();
                          return Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20, top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Recent Searches",
                                        style: TextStyle(
                                            fontFamily: "PolySans_Median",
                                            fontSize: 24),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.remove("historyData3");
                                          ref
                                              .read(HistoryProvider.notifier)
                                              .state = Future.value("{}");
                                        },
                                        child: const Text("Clear",
                                            style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              fontSize: 16,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: NoGlowScroll(
                                      child: ListView.builder(
                                          itemCount: data.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                ref
                                                    .read(SearchSubmitProvider
                                                        .notifier)
                                                    .state = true;
                                                _searchController.text =
                                                    data[index].query;
                                                ref
                                                    .read(
                                                        SearchProvider.notifier)
                                                    .state = data[index].query;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        data[index].query,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "Poppins-Medium",
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SvgPicture.asset(
                                                          "Images/icons/svg/arrow-up-left.svg")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child: Text(snapshot.stackTrace.toString()));
                      }
                      return const Center(child: CircularProgressIndicator());
                    })
            ],
          ),
        ),
      ),
    );
  }
}

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  DeckModel deck = DeckModel();
  final _deckCollection = FirebaseFirestore.instance.collection("deck");
  final _activeFilterSelection = BoxDecoration(
    color: const Color(0x441A0404),
    borderRadius: BorderRadius.circular(12),
  );
  final _inactiveFilterSelection = BoxDecoration(
    color: const Color(0x081A0404),
    borderRadius: BorderRadius.circular(12),
  );
  List<bool> filters = [false, false, false];
  resetFilters() {
    filters = [false, false, false];
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        image: DecorationImage(
            image: AssetImage("Images/backgrounds/homepage.png"),
            fit: BoxFit.cover),
      ),
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Text(
                "Sort deck by:",
                style: TextStyle(
                  fontFamily: "PolySans_Neutral",
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff212523),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      resetFilters();
                      filters[0] = true;
                      Future<List<dynamic>> getData() async {
                        QuerySnapshot querySnapshot =
                            await _deckCollection.orderBy("rating").get();
                        final data = querySnapshot.docs
                            .map((doc) => {
                                  "name": doc.get("name"),
                                  "id": doc.id,
                                  "rating": doc.get("rating")
                                })
                            .toList();
                        return data;
                      }
                    });
                  },
                  child: Container(
                      decoration: filters[0]
                          ? _activeFilterSelection
                          : _inactiveFilterSelection,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Text("Most Upvotes")),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      resetFilters();
                      filters[1] = true;
                      dynamic sort = ref.watch(sortProvider);

                      ref.read(sortProvider.notifier).state =
                          deck.getdeckByID("0") as List<Map>;
                    });
                  },
                  child: Container(
                      decoration: filters[1]
                          ? _activeFilterSelection
                          : _inactiveFilterSelection,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Text("Date Updated")),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      resetFilters();
                      filters[2] = true;
                      deck.recentDecks;
                    });
                  },
                  child: Container(
                      decoration: filters[2]
                          ? _activeFilterSelection
                          : _inactiveFilterSelection,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: const Text("Date Created")),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        resetFilters();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          fontFamily: "PolySans_Neutral",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff212523),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          fontFamily: "PolySans_Neutral",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff212523),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
