import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/widgets/input.dart';
import 'package:cardflip/widgets/registration/registration_card.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

class PersonalCard extends StatelessWidget {
  double height, width;
  UserModel model;
  Function onBack;
  Function onNext;
  List<List<double>> animationParams;
  Duration duration;
  GlobalKey<FormState> formKey;
  TextEditingController fnamecontroller; //_keyParams["Personal"]
  TextEditingController lnamecontroller; //_keyParams["Personal"]

  PersonalCard({
    required this.height,
    required this.width,
    required this.model,
    required this.onBack,
    required this.onNext,
    required this.animationParams,
    required this.duration,
    required this.formKey,
    required this.fnamecontroller,
    required this.lnamecontroller,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
          begin: (animationParams != null) ? animationParams[1][0] : 0.0,
          end: (animationParams != null) ? animationParams[1][1] : 0.0),
      duration: duration,
      builder: (context, double pos, __) => Transform(
        transform: Matrix4.identity()..translate(pos),
        child: RegistrationCard(
          cardWidth: width,
          cardHeight: height,
          model: model,
          child: NoGlowScroll(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onBack();
                        },
                        child: SvgPicture.asset(
                          "Images/icons/svg/arrow-left-s-line.svg",
                          color: const Color(0xFF191C32),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: const Text(
                    'Create \nAccount',
                    style: TextStyle(
                      color: Color(0xFF191C32),
                      fontFamily: 'PolySans_Median',
                      fontSize: 48,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 30, right: 30),
                            child: Input(
                              hintTextOne: "First Name",
                              obscureText: false,
                              color: const Color(0xFFF98800),
                              controller: fnamecontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 30, right: 30),
                            child: Input(
                              controller: lnamecontroller,
                              hintTextOne: "Last Name",
                              obscureText: false,
                              color: const Color(0xFFF98800),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 30, right: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // renderAnimation("Category", 0, 0);

                                  onNext();
                                }
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
