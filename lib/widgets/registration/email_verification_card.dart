import 'dart:async';

import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/user.dart' as user_data;
import 'package:cardflip/helpers/loading_screen.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/widgets/registration/registration_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailVerificationCard extends ConsumerStatefulWidget {
  final double height, width;
  final UserModel model;
  final Function onBack;
  final bool check;
  final bool isBanned = false;
  final user_data.User user;
  const EmailVerificationCard(
      {super.key,
      required this.height,
      required this.width,
      required this.check,
      required this.model,
      required this.onBack,
      required this.user});

  @override
  ConsumerState<EmailVerificationCard> createState() =>
      _EmailVerificationCardState();
}

class _EmailVerificationCardState extends ConsumerState<EmailVerificationCard> {
  bool _isVerified = false;
  Future? _credentials;
  Timer? timer;

  // @override
  // void initState() {

  //   super.initState();
  // }

  Future sendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print("Error while sending:$e");
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      _isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.check) {
      if (counter++ == 0) {
        _credentials = FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: widget.user.email.trim(),
          password: widget.user.password.trim(),
        ).then((value) {
          sendEmail();
          if (!_isVerified) {
            timer = Timer.periodic(const Duration(seconds: 4), (timer) {
              checkEmailVerified();
            });
          }
        });
      }

      return FutureBuilder(
          future: _credentials,
          builder: (context, snapshot) {
            return RegistrationCard(
              cardHeight: widget.height,
              cardWidth: widget.width,
              model: widget.model,
              child: Column(
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
                  Center(
                    child: Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              style: TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'PolySans_Median',
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(text: "Verify Your\n"),
                                TextSpan(text: "Email Address")
                              ]),
                        )),
                  ),
                  Center(
                    child: Container(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: const TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'Poppins',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                const TextSpan(
                                    text: "Account activation link has been\n"),
                                TextSpan(
                                    text: "sent to the email address you\n"),
                                TextSpan(text: "${widget.user.email} \n"),
                              ]),
                        )),
                  ),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.only(
                            top: 120, left: 15, right: 15),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              style: TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'Poppins',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Please check the spam folder if\n"),
                                TextSpan(text: "the email was not sent.\n"),
                              ]),
                        )),
                  ),
                  if (snapshot.hasData || _isVerified)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 30, right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF191C32),
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return LoadingWidget();
                                  // return CircularProgressIndicator();
                                });
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: widget.user.email,
                                    password: widget.user.password)
                                .then((value) {
                              widget.user.setuserID(value.user!.uid);
                              ref.read(UserDataProvider.notifier).state =
                                  widget.user;
                              widget.model
                                  .save(value.user!, widget.user.toJSON());
                              Navigator.pushReplacementNamed(context, "/home");
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                                child: Text(
                              'Done, click to proceed',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          });
    }
    return RegistrationCard(
      cardHeight: widget.height,
      cardWidth: widget.width,
      model: widget.model,
      child: Container(),
    );
  }
}
