import 'package:cardflip/data/user.dart' as user_data;
import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/widgets/registration/registration_card.dart';
import 'package:cardflip/widgets/registration/search_tag_register.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';

class TagsRegister extends StatefulWidget {
  double height, width;
  UserModel model;
  Function onBack;
  Function onNext;
  user_data.User user;
  List<List<double>> animationParams;
  Duration duration;
  TagsRegister(
      {super.key,
      required this.user,
      required this.height,
      required this.width,
      required this.model,
      required this.onBack,
      required this.onNext,
      required this.animationParams,
      required this.duration});

  @override
  State<TagsRegister> createState() => _TagsRegisterState();
}

class _TagsRegisterState extends State<TagsRegister> {
  final List _tagList = [];

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
          begin: (widget.animationParams != null)
              ? widget.animationParams[2][0]
              : 0.0,
          end: (widget.animationParams != null)
              ? widget.animationParams[2][1]
              : 0.0),
      duration: widget.duration,
      builder: (context, double pos, __) => Transform(
        transform: Matrix4.identity()..translate(pos),
        child: RegistrationCard(
          cardWidth: widget.width,
          cardHeight: widget.height,
          model: widget.model,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      widget.onBack();
                    },
                    child: SvgPicture.asset(
                      "Images/icons/svg/arrow-left-s-line.svg",
                      color: const Color(0xFF191C32),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 40),
                    child: const Text(
                      'Pick your interests',
                      style: TextStyle(
                        color: Color(0xFF191C32),
                        fontFamily: 'PolySans_Median',
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: SearchTag(addTagList: (tag) {
                      setState(
                        () {
                          _tagList.add(tag);
                        },
                      );
                    }, removeTagList: (tag) {
                      setState(() {
                        _tagList.remove(tag);
                      });
                    })),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        // top: 55,
                        horizontal: 30,
                        vertical: 35),
                    child: ElevatedButton(
                      onPressed: () {
                        // print(_tagList);
                        widget.user.setUserTags(_tagList);
                        widget.onNext();
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF191C32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      child: const Center(
                          child: Text(
                        'Next',
                      )),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
