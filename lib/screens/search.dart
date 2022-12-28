import 'package:cardflip/data/Repositories/search_provider.dart';
import 'package:cardflip/main.dart';
import 'package:cardflip/widgets/search_input_field.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  String? validator(String value) {
    if (value.isEmpty) {
      return "Please Enter a value to search";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
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
                    onTap: () => Navigator.pop(context),
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
                  )
                ],
              ),
              Consumer(builder: (context, ref, child) {
                final searchResult = ref.watch(SearchProvider);
                if (searchResult.isNotEmpty)
                  return Expanded(
                    child: NoGlowScroll(
                        child: ListView(
                      children: [Text(searchResult)],
                    )),
                  );
                return Expanded(
                    child: NoGlowScroll(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Recent Searches",
                              style: TextStyle(
                                  fontFamily: "PolySans_Median", fontSize: 24),
                            ),
                            GestureDetector(
                              onTap: () {
                                //TODO: Shared Preference Algorithm
                              },
                              child: const Text("Clear",
                                  style: TextStyle(
                                    fontFamily: "Poppins-Regular",
                                    fontSize: 16,
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
