import 'package:cardflip/data/Repositories/search_provider.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/search_history_data/history.dart';
import 'package:cardflip/widgets/search/search_input_field.dart';
import 'package:cardflip/widgets/search/search_results.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/deck_model.dart';

class Search extends ConsumerWidget {
  final DeckModel deck = DeckModel();

  Search({super.key});

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
                      Navigator.pushNamed(context, "/home");
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
