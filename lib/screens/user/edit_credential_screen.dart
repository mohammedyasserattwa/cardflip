import 'dart:async';

import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/helpers/loading_screen.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

class EditCredentials extends ConsumerStatefulWidget {
  const EditCredentials({super.key});

  @override
  ConsumerState<EditCredentials> createState() => _EditCredentialsState();
}

class _EditCredentialsState extends ConsumerState<EditCredentials> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final UserModel userModel = UserModel();
  List<IconData> resultIcons = [Icons.email, Icons.check];
  List<String> resultText = [
    "An email has been sent to your email address",
    "Successfully Verified! The email address has been updated successfully"
  ];
  bool _isVerified = false;
  late Timer? timer;
  bool _sentVerification = false;
  final _userCollection = FirebaseFirestore.instance.collection("user");

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
    // if (_isVerified == true) {
    setState(() {
      _isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (_isVerified == true) timer?.cancel();
    });
    // }
  }

  initTimer() {
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    if (_sentVerification) timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(UserDataProvider);
    _emailController.text = user!.email;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Images/backgrounds/homepage.png"),
            fit: BoxFit.cover),
      ),
      child: FutureBuilder(
          future: userModel.emailList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:  Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 20),
                        child: SvgPicture.asset("Images/icons/svg/arrow-left-s-line.svg")
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0, top: 20),
                      child: Text(
                        "Edit Credentials",
                        style: TextStyle(
                          fontFamily: "PolySans_Median",
                          color: Color(0xff514F55),
                          fontSize: 36,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                        key: _formKey,
                        child: Expanded(
                          child: NoGlowScroll(
                            child: ListView(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                          fontFamily: 'PolySans_Neutral',
                                          fontSize: 24,
                                          color:
                                              Color.fromARGB(255, 49, 49, 49),
                                        ),
                                      ),
                                      Text(
                                        'Please Verify the mail by clicking on the button on the right.',
                                        style: TextStyle(
                                          fontFamily: 'PolySans_Neutral',
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 49, 49, 49),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 30.0, right: 30),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                93, 167, 167, 167),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (_isVerified == false &&
                                          _sentVerification == true)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: const Color.fromARGB(
                                                  93, 167, 167, 167)),
                                          child:
                                              const CircularProgressIndicator(
                                            color:
                                                Color.fromARGB(255, 49, 49, 49),
                                          ),
                                        )
                                      else
                                        GestureDetector(
                                          onTap: () {
                                            if (!_sentVerification &&
                                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                                    .hasMatch(_emailController
                                                        .text) &&
                                                _emailController.text !=
                                                    user.email &&
                                                !snapshot.data!.contains(
                                                    _emailController.text)) {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: user.email,
                                                      password: user.password)
                                                  .then((value) {
                                                userModel
                                                    .editCredentials(
                                                        _emailController.text,
                                                        user.password)
                                                    .then((value) {
                                                  // FirebaseAuth.instance
                                                  initTimer();
                                                  sendEmail().then((value) {
                                                    setState(() {
                                                      user.email =
                                                          _emailController.text;
                                                      ref
                                                          .read(UserDataProvider
                                                              .notifier)
                                                          .state = user;
                                                      _userCollection
                                                          .doc(user.id)
                                                          .update({
                                                        "email":
                                                            _emailController
                                                                .text,
                                                      });
                                                      _emailController.text =
                                                          user.email;
                                                      _sentVerification = true;
                                                    });
                                                  });
                                                }).onError((error, stackTrace) {
                                                  print(error.toString());
                                                });
                                              });
                                            } else if (_emailController.text ==
                                                user.email) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Please enter a new email address")));
                                            } else if (!RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                                .hasMatch(
                                                    _emailController.text)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Please enter a valid email address")));
                                            } else if (snapshot.data!.contains(
                                                _emailController.text)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Email already exists")));
                                            }
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: (_isVerified)
                                                    ? Color.fromARGB(
                                                        255, 130, 207, 133)
                                                    : const Color.fromARGB(
                                                        93, 167, 167, 167)),
                                            child: Icon(
                                              resultIcons[
                                                  (_isVerified) ? 1 : 0],
                                              color: const Color.fromARGB(
                                                  255, 49, 49, 49),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: _sentVerification,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 30, top: 5),
                                    child: Text(
                                      resultText[_isVerified ? 1 : 0],
                                      style: const TextStyle(
                                        fontFamily: 'PolySans_Neutral',
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 49, 49, 49),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 30, top: 20),
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      fontFamily: 'PolySans_Neutral',
                                      fontSize: 24,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 30.0, right: 30),
                                  child: Text(
                                    "Enter your current password to change your password",
                                    style: TextStyle(
                                      fontFamily: 'PolySans_Neutral',
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 30.0, right: 30),
                                  child: TextField(
                                    controller: _oldPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          93, 167, 167, 167),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 30.0, right: 30),
                                  child: Text(
                                    "Enter your new password",
                                    style: TextStyle(
                                      fontFamily: 'PolySans_Neutral',
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 30.0, right: 30),
                                  child: TextField(
                                    controller: _newPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          93, 167, 167, 167),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_oldPasswordController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please enter your current password")));
                                      } else if (_newPasswordController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please enter your new password")));
                                      } else if (_newPasswordController
                                              .text.length <
                                          6) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Password must be at least 6 characters")));
                                      } else if (_oldPasswordController.text ==
                                          _newPasswordController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "New password cannot be the same as the old password")));
                                      } else if (_oldPasswordController.text !=
                                          user.password) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Incorrect password")));
                                      } else if (_oldPasswordController.text ==
                                              user.password &&
                                          _newPasswordController.text !=
                                              user.password &&
                                          _newPasswordController.text != "" &&
                                          _oldPasswordController.text != "") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return LoadingWidget();
                                            });
                                        FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: user.email,
                                                password: user.password)
                                            .then((value) {
                                          user.password =
                                              _newPasswordController.text;
                                          ref
                                              .read(UserDataProvider.notifier)
                                              .state = user;

                                          userModel
                                              .editCredentials(
                                                  user.email, user.password)
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Credentials Updated")));
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        });
                                      }
                                      // if (_oldPasswordController.text == user.password &&
                                      //     _newPasswordController.text != user.password &&
                                      //     _newPasswordController.text != "" &&
                                      //     _oldPasswordController.text != "") {
                                      //   user.password =
                                      //       _newPasswordController.text;
                                      //   ref
                                      //       .read(UserDataProvider.notifier)
                                      //       .state = user;
                                      //   userModel
                                      //       .editCredentials(
                                      //           user.email, user.password)
                                      //       .then((value) {
                                      //     ScaffoldMessenger.of(context)
                                      //         .showSnackBar(const SnackBar(
                                      //             content: Text(
                                      //                 "Credentials Updated")));
                                      //     Navigator.pop(context);
                                      //     Navigator.pop(context);
                                      //   });
                                      // }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color:
                                                Colors.grey.withOpacity(0.30)),
                                        width: 85,
                                        height: 45,
                                        child: const Text("Done",
                                            style: TextStyle(
                                                color: Color(0xFF191C32),
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const LoadingWidget();
          }),
    ));
  }
}
