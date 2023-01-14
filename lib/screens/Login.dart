// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names, avoid_types_as_parameter_names, library_private_types_in_public_api, file_names, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, unrelated_type_equality_checks, unnecessary_string_interpolations

import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/User.dart' as user_data;
import 'package:cardflip/main.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/loginModel.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/screens/home.dart';
import 'package:cardflip/screens/loading_screen.dart';
import 'package:cardflip/screens/register.dart';
import 'package:cardflip/widgets/Input.dart';
import 'package:cardflip/widgets/custom_check_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late final _firebaseAuth;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isChecked = false;
  UserModel userModel = UserModel();
  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    super.initState();
  }

  Future signIn() async {
    bool result = true;
    if (result) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return LoadingWidget();
            });

        final credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        DeckModel deckModel = DeckModel();
        userModel.userData.then((user) {
          deckModel.getUserPreference(user.get("tags")).then((value) {
            ref.read(UserDataProvider.notifier).state =
                user_data.User.fromSnapshot(user, _emailController.text,
                    _passwordController.text, userModel.id, value);
            if (user.get("role") == 'learner') {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (user.get("role") == 'admin') {
            Navigator.pushReplacementNamed(context, '/admin');
          }
          });
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          print("User not found");
          Navigator.pop(context);
        } else if (e.code == "wrong-password") {
          print("Password is wrong");
          Navigator.pop(context);
        } else {
          print("no Internet");
          Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: _key,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/backgrounds/loginpage.png'),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
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
                                    color: Color.fromARGB(255, 184, 145, 229),
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
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        CustomCheckbox(
                                          isChecked: _isChecked,
                                          onChange: (isChecked) {
                                            print(isChecked);
                                          },
                                          size: 25,
                                          selectedColor: Colors.white,
                                          selectedIconColor: Color(0xFF191C32),
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
                                                fontFamily: "PolySans_Median")),
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
                                        if (_key.currentState!.validate()) {
                                          signIn();
                                          // Navigator.of(context)
                                          //     .pushReplacementNamed('/home');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF191C32),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
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
                                      onPressed: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 240,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF78E7F5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Image.asset('Images/icons/google.png',
                                              fit: BoxFit.cover),
                                          const Text('  Continue with Google',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      )),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/register");
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
          ),
        ),
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
