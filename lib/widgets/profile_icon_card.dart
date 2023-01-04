import 'dart:math';

import 'package:cardflip/data/User.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/widgets/registration_card.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

class ProfileIconCard extends StatefulWidget {
  double height, width;
  UserModel model;
  Function onBack;
  Function onNext;
  List<List<double>> animationParams;
  Duration duration;
  User user;
  ProfileIconCard(
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
  State<ProfileIconCard> createState() => _ProfileIconCardState();
}

class _ProfileIconCardState extends State<ProfileIconCard> {
  late String currentIcon;
  @override
  void initState() {
    currentIcon = Random().nextInt(18).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
          begin: (widget.animationParams != null)
              ? widget.animationParams[4][0]
              : 0.0,
          end: (widget.animationParams != null)
              ? widget.animationParams[4][1]
              : 0.0),
      duration: widget.duration,
      builder: (context, double pos, __) => Transform(
        transform: Matrix4.identity()..translate(pos),
        child: RegistrationCard(
          cardWidth: widget.width,
          cardHeight: widget.height,
          model: widget.model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onBack();
                      },
                      child: SvgPicture.asset(
                        "Images/icons/svg/arrow-left-s-line.svg",
                        color: const Color(0xFF191C32),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: const Text(
                        'Pick your profile picture',
                        style: TextStyle(
                          color: Color(0xFF191C32),
                          fontFamily: 'PolySans_Median',
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white60,
                    radius: 75,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        SvgPicture.asset(
                          "Images/avatars/$currentIcon.svg",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF191C32),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.upload, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 275,
                    child: NoGlowScroll(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Scrollbar(
                          child: ListView(
                            children: [
                              for (int i = 0; i < 18; i += 3)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentIcon = i.toString();
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white60,
                                            radius: 35,
                                            child: SvgPicture.asset(
                                              "Images/avatars/$i.svg",
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentIcon = (i + 1).toString();
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white60,
                                            radius: 35,
                                            child: SvgPicture.asset(
                                              "Images/avatars/${i + 1}.svg",
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentIcon = (i + 2).toString();
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white60,
                                            radius: 35,
                                            child: SvgPicture.asset(
                                              "Images/avatars/${i + 2}.svg",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.user.seticon(currentIcon);
                        widget.onNext();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF191C32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                            child: Text(
                          'Next',
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
