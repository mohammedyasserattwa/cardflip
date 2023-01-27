// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names, avoid_types_as_parameter_names, library_private_types_in_public_api, file_names, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, unrelated_type_equality_checks, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/user_decks.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/user.dart' as user_data;
import 'package:cardflip/helpers/loading_screen.dart';
import 'package:cardflip/main.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/screens/home.dart';
import 'package:cardflip/screens/user/register.dart';
import 'package:cardflip/widgets/input.dart';
import 'package:cardflip/widgets/custom_check_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final storage = FlutterSecureStorage();
  final _firebaseAuth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMeCheckBox = false;
  UserModel userModel = UserModel();

  Future<List<Map>> getSavedUsers() async {
    Map savedUsers = await storage.readAll();
    List<Map> result = [];
    for (String user in savedUsers.keys) {
      result.add({
        "data": await userModel.getUserByID(user),
        "password": savedUsers[user]
      });
    }
    return result;
  }

  Future saveUserInVault(String email, String password) async {
    await storage.write(key: "${userModel.id}", value: password);
  }

  Future checkEmailVerification() {
    return _firebaseAuth.currentUser!.reload().then((value) {
      if (_firebaseAuth.currentUser!.emailVerified) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future signIn(String email, String password) async {
    bool result = true;
    if (result) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return LoadingWidget();
            });

        await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        DeckModel deckModel = DeckModel();
        userModel.userData.then((user) {
          if (user.get("role") == 'admin') {
            ref.read(UserDataProvider.notifier).state =
                user_data.User.fromSnapshot(
                    user, email, password, userModel.id, []);
            if (_rememberMeCheckBox) {
              saveUserInVault(_emailController.text, _passwordController.text)
                  .then((value) =>
                      Navigator.pushReplacementNamed(context, '/adminDeck'));
            } else {
              Navigator.pushReplacementNamed(context, '/adminDeck');
            }
          } else if (user.get("role") == 'learner') {
            if (user.get("banned") == false) {
              checkEmailVerification().then((isVerified) {
                if (isVerified) {
                  deckModel.getUserPreference(user.get("tags")).then((value) {
                    ref.read(FavouritesProvider.notifier).state =
                        (user['favourites'] as List)
                            .map((item) => item as String)
                            .toList();
                    ref.read(UserDataProvider.notifier).state =
                        user_data.User.fromSnapshot(
                            user, email, password, userModel.id, value);
                    deckModel.getReportsByUserID(userModel.id).then((reports) {
                      ref.read(ReportProvider.notifier).state = reports;
                      deckModel.getLikesByUserID(userModel.id).then((likes) {
                        ref.read(RatingProvider.notifier).state = likes;
                        if (_rememberMeCheckBox) {
                          saveUserInVault(_emailController.text,
                                  _passwordController.text)
                              .then((value) => Navigator.pushReplacementNamed(
                                  context, '/home'));
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/home", (route) => true);
                        }
                      });
                    });
                  });
                } else {
                  Navigator.pushNamed(context, "/verifyEmail");
                }
              });
            } else {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:
                                AssetImage("Images/backgrounds/homepage.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 10),
                          DefaultTextStyle(
                            style: TextStyle(
                              fontFamily: "PolySans_Median",
                              color: Color.fromARGB(239, 105, 0, 0),
                              fontSize: 20,
                            ),
                            child: Text(
                              "You have been banned",
                            ),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                              fontFamily: "PolySans_Slim",
                              color: Color.fromARGB(239, 105, 0, 0),
                              fontSize: 15,
                            ),
                            child: Text(
                              "The account you are trying to access has been banned",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.withOpacity(0.30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontFamily: 'PolySans_Neutral',
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                    ),
                                    child: Text(
                                      "Ok",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        });
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == "user-not-found") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("Images/backgrounds/homepage.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 10),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: "PolySans_Median",
                          color: Color.fromARGB(239, 105, 0, 0),
                          fontSize: 20,
                        ),
                        child: Text(
                          "User Not Found",
                        ),
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: "PolySans_Slim",
                          color: Color.fromARGB(239, 105, 0, 0),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        child: Text(
                          "Email not registered. Please register to continue",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.withOpacity(0.30)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  fontFamily: 'PolySans_Neutral',
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 49, 49, 49),
                                ),
                                child: Text(
                                  "Ok",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (e.code == "wrong-password" || e.code == "invalid-email") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("Images/backgrounds/homepage.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 10),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: "PolySans_Median",
                          color: Color.fromARGB(239, 105, 0, 0),
                          fontSize: 20,
                        ),
                        child: Text(
                          "Incorrect Email or Password",
                        ),
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: "PolySans_Slim",
                          color: Color.fromARGB(239, 105, 0, 0),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        child: Text(
                          "Please check your username and password and try again",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.withOpacity(0.30)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  fontFamily: 'PolySans_Neutral',
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 49, 49, 49),
                                ),
                                child: Text(
                                  "Ok",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("Images/backgrounds/homepage.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 10),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontFamily: "PolySans_Median",
                            color: Color.fromARGB(239, 105, 0, 0),
                            fontSize: 20,
                          ),
                          child: AutoSizeText(
                            textAlign: TextAlign.center,
                            "Error connecting to the internet",
                            maxLines: 3,
                          ),
                        ),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontFamily: "PolySans_Slim",
                            color: Color.fromARGB(239, 105, 0, 0),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                          child: AutoSizeText(
                            textAlign: TextAlign.center,
                            "Please check your internet connection and try again",
                            maxLines: 3,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.withOpacity(0.30)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontFamily: 'PolySans_Neutral',
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 49, 49, 49),
                                  ),
                                  child: Text(
                                    "Ok",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int counter = 0;
  bool _anotherUser = false;
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Images/backgrounds/loginpage.png'),
              fit: BoxFit.cover),
        ),
        child: FutureBuilder(
            future: getSavedUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xff484848),
                        fontSize: 20,
                        fontFamily: "PolySans_Neutral"),
                    "Something went wrong.");
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty && !_anotherUser) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'PolySans_Median',
                                  fontSize: 38,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Pick one of the accounts below to login, or login with another account',
                                style: TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'PolySans_Normal',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => signIn(
                                snapshot.data![index]["data"]["email"],
                                snapshot.data![index]["password"],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xb394D1D9),
                                    border: Border.all(
                                      color: Color(0xFF191C32),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          "Images/avatars/${snapshot.data![index]["data"]["profileIcon"]}.svg",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text(
                                          ReCase(snapshot.data![index]["data"]
                                                      ["fname"] +
                                                  " " +
                                                  snapshot.data![index]["data"]
                                                      ["lname"])
                                              .titleCase,
                                          style: TextStyle(
                                            color: Color(0xFF191C32),
                                            fontFamily: 'PolySans_Normal',
                                            fontSize: 18,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xFF191C32),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _anotherUser = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF191C32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Login with another account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'PolySans_Normal',
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 185),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 20),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: Color(0xFF191C32),
                              fontFamily: 'PolySans_Median',
                              fontSize: 48,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 25, right: 25, bottom: 15),
                                    child: Column(
                                      children: [
                                        Input(
                                          hintTextOne: "Email or Username",
                                          icon: Icons.person_outline_outlined,
                                          obscureText: false,
                                          controller: _emailController,
                                          color: Color(0xFFF98800),
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Please enter your email or username";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Input(
                                          hintTextOne: "Password",
                                          icon: Icons.lock_outline,
                                          obscureText: true,
                                          color: Color.fromARGB(
                                              255, 184, 145, 229),
                                          controller: _passwordController,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Please enter a valid password.";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              CustomCheckbox(
                                                isChecked: _rememberMeCheckBox,
                                                onChange: (isChecked) {
                                                  setState(() {
                                                    _rememberMeCheckBox =
                                                        isChecked;
                                                  });
                                                },
                                                size: 25,
                                                selectedColor: Color.fromARGB(
                                                    204, 255, 255, 255),
                                                selectedIconColor:
                                                    Color(0xFF191C32),
                                                iconSize: 19,
                                                borderColor: Color(0xFF191C32),
                                                checkIcon: Icon(Icons.check),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Remember me",
                                                  style: TextStyle(
                                                      color: Color(0xFF191C32),
                                                      fontFamily:
                                                          "PolySans_Median")),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        SizedBox(
                                          width: 340,
                                          height: 58,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (key.currentState!
                                                  .validate()) {
                                                signIn(_emailController.text,
                                                    _passwordController.text);
                                                // Navigator.of(context)
                                                //     .pushReplacementNamed('/home');
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xFF191C32),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                            ),
                                            child: Center(
                                                child: const Text(
                                              'Login',
                                            )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              if (_emailController
                                                  .text.isNotEmpty) {
                                                userModel
                                                    .resetPassword(
                                                        _emailController.text,
                                                        context)
                                                    .then((value) => {
                                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                              content: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins"),
                                                                  "A mail has been sent to your email address.")))
                                                        });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        duration: Duration(
                                                            seconds: 3),
                                                        content: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins"),
                                                            "Please enter your email in the field above in order to send a mail.")));
                                              }
                                            },
                                            child: Text(
                                              'Forgot Password?',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            )),
                                        if (snapshot.data!.isNotEmpty)
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _anotherUser = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xFF78E7F5),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                            ),
                                            child: SizedBox(
                                              width: 240,
                                              height: 40,
                                              child: Center(
                                                  child: const Text(
                                                      ' View Saved Users',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black))),
                                            ),
                                          ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/register");
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          "Don't have an account? "),
                                                  TextSpan(
                                                      text: "Sign up",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: LoadingWidget(
                  transparent: true,
                ),
              );
            }),
      ),
    );
  }
}

// if (val == Object.email ||
//                                         val == Object.fname)
//if (val == Object.password)

// else if (val != (Object.email) ||
//                                         val != (Object.fname)) {
//                                       return "Wrong email address or Username";
//                                     }
//  else if (val != Object.password) {
//                                       return "wrong password";
//                                     }
