import 'package:cardflip/widgets/search_input_field.dart';
import "package:flutter/material.dart";

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
    return Container(
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
                          image:
                              AssetImage("Images/icons/arrow-left-s-line.png"),
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
                      validator: validator,
                      onChanged: (value) {}),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
