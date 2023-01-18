import 'package:cardflip/screens/loading_screen.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

import '../models/deckModel.dart';

class SearchTag extends StatefulWidget {
  Function(String) addTagList;
  Function(String) removeTagList;
  SearchTag({super.key, required this.addTagList, required this.removeTagList});

  @override
  State<SearchTag> createState() => _SearchTagState();
}

class _SearchTagState extends State<SearchTag> {
  final _tagController = TextEditingController();

  late Future<Map<String, bool>> tagMap;
  late final active;
  int counter = 0;
  String search = "";
  //Map<String, bool> tagMap =
  //tags.asMap().map((index, key) => MapEntry(key, false));
  Future<List<dynamic>> getTags() {
    return DeckModel().getData();
  }

  @override
  void initState() {
    tagMap = getTags().then(
        (value) => value.asMap().map((index, key) => MapEntry(key, false)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: tagMap,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return const Text("Error while loading the tags");
          if (snapshot.hasData) {
            Map<String, bool> data = Map.from(snapshot.data!);
            if (search.isNotEmpty) {
              data.removeWhere((key, value) => !key
                  .trim()
                  .toLowerCase()
                  .contains(search.trim().toLowerCase()));
            } else {
              data = snapshot.data!;
            }

            final tags = data.keys.toList();
            if (counter++ == 0) active = data.values.toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  Card(
                    elevation: 0.0,
                    color: Color(0x1f1A0404),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "Images/icons/svg/search.svg",
                          ),
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              cursorColor: Colors.grey[600],
                              controller: _tagController,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PolySans_Neutral",
                                fontSize: 20,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  search = value;
                                });
                              },
                              decoration: InputDecoration.collapsed(
                                // border:,

                                hintText: "Search Tags",
                                hintStyle: TextStyle(
                                  color: Colors.grey[800],
                                  fontFamily: "PolySans_Neutral",
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: NoGlowScroll(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 750,
                            child: NoGlowScroll(
                              child: Scrollbar(
                                child: ListView(
                                  children: [
                                    for (int i = 0; i < data.length; i += 3)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                (i != tags.length - 1)
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (active[i] == false) {
                                                      widget
                                                          .addTagList(tags[i]);
                                                      active[i] = true;
                                                    } else {
                                                      widget.removeTagList(
                                                          tags[i]);
                                                      active[i] = false;
                                                    }
                                                  });
                                                },
                                                child: TagContainer(
                                                  tag: tags[i],
                                                  active: active[i],
                                                ),
                                              ),
                                              if (i + 1 < tags.length)
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!active[i + 1]) {
                                                        widget.addTagList(
                                                            tags[i + 1]);
                                                        active[i + 1] = true;
                                                      } else {
                                                        widget.removeTagList(
                                                            tags[i + 1]);
                                                        active[i + 1] = false;
                                                      }
                                                    });
                                                  },
                                                  child: TagContainer(
                                                    tag: tags[i + 1],
                                                    active: active[i + 1],
                                                  ),
                                                ),
                                              if (i + 2 < tags.length)
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (!active[i + 2]) {
                                                        widget.addTagList(
                                                            tags[i + 2]);
                                                        active[i + 2] = true;
                                                      } else {
                                                        widget.removeTagList(
                                                            tags[i - 2]);
                                                        active[i + 2] = false;
                                                      }
                                                    });
                                                  },
                                                  child: TagContainer(
                                                    tag: tags[i + 2],
                                                    active: active[i + 2],
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}

class TagContainer extends StatelessWidget {
  const TagContainer({Key? key, required this.tag, this.active = false})
      : super(key: key);
  final bool active;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: (active) ? Colors.white : Color(0x1f1A0404),
            borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.all(10),
        child: Text(tag));
  }
}
