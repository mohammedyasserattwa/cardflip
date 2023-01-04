import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/screens/loading_screen.dart';
import 'package:cardflip/widgets/Input.dart';
import 'package:cardflip/widgets/registration_card.dart';
import "package:flutter/material.dart";

class EmailInfoCard extends StatelessWidget {
  double height, width;
  UserModel model;
  Function onNext;
  List<List<double>> animationParams;
  Duration duration;
  GlobalKey<FormState> formKey;
  TextEditingController usernameController; //_keyParams["Personal"]
  TextEditingController emailController; //_keyParams["Personal"]
  TextEditingController passwordController; //_keyParams["Personal"]

  EmailInfoCard({
    required this.height,
    required this.width,
    required this.model,
    required this.onNext,
    required this.animationParams,
    required this.duration,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });
  // List<Future<bool>> validator(username, email) {
  //   return [model.checkEmail(email),model.checkUsername(username)];
  // }
  Future<Map<String, List>> getData() async {
    List<dynamic> usernameList = await model.usernameList();
    List<dynamic> emailList = await model.emailList();
    return {"username": usernameList, "emailList": emailList};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TweenAnimationBuilder(
              tween: Tween<double>(
                  begin:
                      (animationParams != null) ? animationParams[0][0] : 0.0,
                  end: (animationParams != null) ? animationParams[0][1] : 0.0),
              duration: duration,
              builder: (context, double pos, __) => Transform(
                transform: Matrix4.identity()..translate(pos),
                child: RegistrationCard(
                  cardWidth: width,
                  cardHeight: height,
                  model: model,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 40),
                          child: const Text(
                            'Create\nAccount',
                            style: TextStyle(
                              color: Color(0xFF191C32),
                              fontFamily: 'PolySans_Median',
                              fontSize: 48,
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Input(
                                  controller: usernameController,
                                  hintTextOne: "Username",
                                  icon: Icons.person_outline_outlined,
                                  obscureText: false,
                                  color: const Color(0xFFF98800),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a username';
                                    }
                                    if (snapshot.data!["username"]!
                                        .contains(value)) {
                                      return "Username taken";
                                    }
                                    if (value.length < 5 || value.length > 15) {
                                      return 'Username must be between 5-15 characters';
                                    }
                                    if (RegExp(r'\s').hasMatch(value)) {
                                      return 'Cannot contain spaces';
                                    }
                                    if (!RegExp(r'^[a-zA-Z0-9]+$')
                                        .hasMatch(value)) {
                                      return 'Cannot contain special characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 30, right: 30),
                                child: Input(
                                  controller: emailController,
                                  hintTextOne: "Email",
                                  icon: Icons.email_rounded,
                                  obscureText: false,
                                  color: const Color(0xFF5FC88F),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    if (snapshot.data!["emailList"]!
                                        .contains(value)) {
                                      return "Email taken";
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 30, right: 30),
                                child: Input(
                                  controller: passwordController,
                                  hintTextOne: "Password",
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  color:
                                      const Color.fromARGB(255, 184, 145, 229),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    if (value.length < 8) {
                                      return 'Your password must be at least 8 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 45, left: 30, right: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      // renderAnimation(0, 0, 1000);
                                      // setState(() {});
                                      onNext();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF191C32),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
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
                        )
                      ]),
                ),
              ),
            );
          }
          return LoadingWidget();
        });
  }
}
