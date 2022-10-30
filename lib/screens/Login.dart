// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names, avoid_types_as_parameter_names, library_private_types_in_public_api, file_names, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, unrelated_type_equality_checks

import 'package:cardflip/main.dart';
import 'package:cardflip/screens/home.dart';
import 'package:cardflip/screens/register.dart';
import 'package:flutter/material.dart';
import '../data/User.dart';
import '../models/LoginModel.dart';
import '../widgets/Input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  loginModel Object = loginModel(User());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Input.loginKey,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Images/backgrounds/loginpage.png'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  'Welcome\nBack',
                  style: TextStyle(
                    color: Color(0xFF191C32),
                    fontFamily: 'Poppins',
                    fontSize: 38,
                  ),
                ),
              ),
              ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            children: [
                              Input(
                                  hintTextOne: "Email or Username",
                                  icon: Icons.person_outline_outlined,
                                  obscureText: false,
                                  color: Color(0xFFF98800),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please enter a valid email address or username";
                                    } else {
                                      return null;
                                    }
                                  },
                                  Object: Object),
                              SizedBox(
                                height: 30,
                              ),
                              Input(
                                  hintTextOne: "Password",
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  color: Color.fromARGB(255, 184, 145, 229),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please enter a minimum 8 characters";
                                    } else {
                                      return null;
                                    }
                                  },
                                  Object: Object),
                              SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                width: 340,
                                height: 58,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (Input.loginKey.currentState!
                                        .validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
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
                                height: 30,
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
                                      Image.network(
                                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                                          fit: BoxFit.cover),
                                      const Text('  Continue with Google',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  )),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Don't have an account? "),
                                        TextSpan(
                                            text: "Sign up",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
