import 'package:cardflip/data/Repositories/search_provider.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchInputField extends ConsumerStatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType type;
  const SearchInputField(
      {super.key,
      required this.hint,
      required this.controller,
      this.type = TextInputType.text});

  @override
  ConsumerState<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends ConsumerState<SearchInputField> {
  late Color _currentColor;
  bool resetButton = false;
  @override
  void initState() {
    _currentColor = Colors.transparent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final backgroundColor = .opacity(0.5);
    return Card(
      elevation: 0.0,
      color: Color(0x1f1A0404),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: _currentColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "Images/icons/svg/search.svg",
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                      // TODO: Shared Preference Algorithm
                    }
                  },
                  child: TextField(
                    cursorColor: Colors.grey[600],
                    cursorHeight: 30,
                    onChanged: (value) {
                      setState(() {
                        ref.read(SearchProvider.notifier).state =
                            widget.controller.text;
                        if (value.isNotEmpty) {
                          resetButton = true;
                          _currentColor = Colors.transparent;
                        } else {
                          resetButton = false;
                          _currentColor = Colors.red;
                        }
                      });
                    },
                    controller: widget.controller,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: "PolySans_Neutral",
                      fontSize: 20,
                    ),
                    decoration: InputDecoration.collapsed(
                      // border:,
                
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: "PolySans_Neutral",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: resetButton,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.controller.clear();
                      resetButton = false;
                    });
                  },
                  icon: Icon(Icons.close)),
            )
          ],
        ),
      ),
    );
  }
}
