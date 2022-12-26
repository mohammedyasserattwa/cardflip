import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class SearchInputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType type;
  final Function(String) validator;
  final Function(String) onChanged;
  const SearchInputField(
      {super.key,
      required this.hint,
      required this.controller,
      this.type = TextInputType.text,
      required this.validator,
      required this.onChanged});

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  late Color _currentColor;
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
      color: Color(0x3f1A0404),
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
                child: TextFormField(
                  cursorColor: Colors.grey[600],
                  cursorHeight: 30,
                  onChanged: (value) {
                    widget.onChanged(value);
                    setState(() {
                      if (!widget.validator(value) || value.isEmpty) {
                        _currentColor = Colors.red;
                      } else {
                        _currentColor = Colors.transparent;
                      }
                    });
                  },
                  controller: widget.controller,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: "bold",
                    fontSize: 20,
                  ),
                  decoration: InputDecoration.collapsed(
                    // border:,

                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: "bold",
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
