// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable, no_leading_underscores_for_local_identifiers, prefer_const_declarations

import 'package:cardflip/models/loginModel.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:cardflip/screens/Login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../data/User.dart';
import '../widgets/Input.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserModel model = UserModel();
  final _fnamecontroller = TextEditingController();
  final _lnamecontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double _cardWidth = 343;
    final double _cardHeight = 511.97;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Images/backgrounds/loginpage.png'),
            fit: BoxFit.cover),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Stack(
              children: [
                CardWidget.emptyCard(
                  image: model.getImages[0],
                  updateParent: () {},
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CardWidget.emptyCard(
                        updateParent: () {}, image: model.getImages[1]),
                  ],
                ),
                RegistrationCard(
                  cardWidth: _cardWidth,
                  cardHeight: _cardHeight,
                  model: model,
                  child: const Text("last registration"),
                ),
                RegistrationCard(
                  cardWidth: _cardWidth,
                  cardHeight: _cardHeight,
                  model: model,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30, top: 40),
                        child: Text(
                          'Personal Information',
                          style: TextStyle(
                            color: Color(0xFF191C32),
                            fontFamily: 'Poppins',
                            fontSize: 40,
                          ),
                        ),
                      ),
                      Form(
                        key: Input.registerKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 30, right: 30),
                              child: Input(
                                hintTextOne: "First Name",
                                icon: Icons.person_sharp,
                                obscureText: false,
                                color: Color(0xFFF98800),
                                controller: _fnamecontroller,
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
                                controller: _lnamecontroller,
                                hintTextOne: "Last Name",
                                icon: Icons.person_sharp,
                                obscureText: false,
                                color: Color(0xFFF98800),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: RegistrationCard(
                          cardWidth: _cardWidth,
                          cardHeight: _cardHeight,
                          model: model,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 30, top: 40),
                                  child: Text(
                                    'Create\nAccount',
                                    style: TextStyle(
                                      color: Color(0xFF191C32),
                                      fontFamily: 'Poppins',
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                Form(
                                  key: Input.registerKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, left: 30, right: 30),
                                        child: Input(
                                          controller: _usernameController,
                                          hintTextOne: "Username",
                                          icon: Icons.person_outline_outlined,
                                          obscureText: false,
                                          color: Color(0xFFF98800),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a username';
                                            }
                                            if (value.length < 5 ||
                                                value.length > 15) {
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
                                          controller: _emailController,
                                          hintTextOne: "Email",
                                          icon: Icons.email_rounded,
                                          obscureText: false,
                                          color: Color(0xFF5FC88F),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter an email';
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
                                          controller: _passwordController,
                                          hintTextOne: "Password",
                                          icon: Icons.lock_outline,
                                          obscureText: true,
                                          color: Color.fromARGB(
                                              255, 184, 145, 229),
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
                                            top: 15, left: 30, right: 30),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (Input.registerKey.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF191C32),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Center(
                                                child: const Text(
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
                      )
                    ],
                  ),
                ),
              ],
            )),
          ]),
    )));

    // Form(
    //   key: Input.registerKey,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //           image: AssetImage('Images/backgrounds/loginpage.png'),
    //           fit: BoxFit.cover),
    //     ),
    //     child: Scaffold(
    //       backgroundColor: Colors.transparent,
    //       appBar: AppBar(
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //       ),
    //       body: Stack(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(left: 35, top: 70),
    //             child: Text(
    //               'Create\nAccount',
    //               style: TextStyle(
    //                 color: Color(0xFF191C32),
    //                 fontFamily: 'Poppins',
    //                 fontSize: 40,
    //               ),
    //             ),
    //           ),
    //           ListView(
    //             children: [
    //               Container(
    //                 padding: EdgeInsets.only(
    //                     top: MediaQuery.of(context).size.height * 0.24),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                       margin: EdgeInsets.only(left: 25, right: 25),
    //                       child: Column(
    //                         children: [
    //                           Input(
    //                               hintTextOne: "Username",
    //                               icon: Icons.person_outline_outlined,
    //                               obscureText: false,
    //                               color: Color(0xFFF98800),
    //                               validator: (val) {
    //                                 if (val != null && val.isNotEmpty) {
    //                                   return null;
    //                                 } else {
    //                                   return '* Required';
    //                                 }
    //                               },
    //                               Object: Object),
    //                           SizedBox(
    //                             height: 15,
    //                           ),
    //                           Input(
    //                               hintTextOne: "Email",
    //                               icon: Icons.email_rounded,
    //                               obscureText: false,
    //                               color: Color(0xFF5FC88F),
    //                               validator: MultiValidator([
    //                                 RequiredValidator(errorText: "* Required"),
    //                                 EmailValidator(
    //                                     errorText: "Enter valid email"),
    //                               ]),
    //                               Object: Object),
    //                           SizedBox(
    //                             height: 15,
    //                           ),
    //                           Input(
    //                               hintTextOne: "Password",
    //                               icon: Icons.lock_outline,
    //                               obscureText: true,
    //                               color: Color.fromARGB(255, 184, 145, 229),
    //                               validator: MultiValidator([
    //                                 RequiredValidator(errorText: "* Required"),
    //                                 MinLengthValidator(6,
    //                                     errorText:
    //                                         "Password should be atleast 6 characters"),
    //                                 MaxLengthValidator(15,
    //                                     errorText:
    //                                         "Password should not be greater than 15 characters")
    //                               ]),
    //                               Object: Object),
    //                           SizedBox(
    //                             height: 30,
    //                           ),
    //                           SizedBox(
    //                             width: 340,
    //                             height: 58,
    //                             child: ElevatedButton(
    //                               onPressed: () {
    //                                 if (Input.registerKey.currentState!
    //                                     .validate()) {
    //                                   Navigator.push(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                           builder: (context) => Login()));
    //                                 }
    //                               },
    //                               style: ElevatedButton.styleFrom(
    //                                 backgroundColor: Color(0xFF191C32),
    //                                 shape: RoundedRectangleBorder(
    //                                     borderRadius:
    //                                         BorderRadius.circular(30.0)),
    //                               ),
    //                               child: Center(
    //                                   child: const Text(
    //                                 'Register',
    //                               )),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 20,
    //                           ),
    //                           TextButton(
    //                             onPressed: () {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) => Login()));
    //                             },
    //                             child: RichText(
    //                               text: TextSpan(
    //                                   style: const TextStyle(
    //                                     color: Colors.black,
    //                                     decoration: TextDecoration.underline,
    //                                   ),
    //                                   children: <TextSpan>[
    //                                     TextSpan(
    //                                         text: "Already have an account? "),
    //                                     TextSpan(
    //                                         text: "Sign In",
    //                                         style: const TextStyle(
    //                                             fontWeight: FontWeight.bold)),
    //                                   ]),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 30,
    //                           ),
    //                           SizedBox(
    //                             width: 240,
    //                             height: 40,
    //                             child: ElevatedButton(
    //                               onPressed: () {},
    //                               style: ElevatedButton.styleFrom(
    //                                 backgroundColor: Color(0xFF78E7F5),
    //                                 shape: RoundedRectangleBorder(
    //                                     borderRadius:
    //                                         BorderRadius.circular(30.0)),
    //                               ),
    //                               child: Center(
    //                                   child: Row(
    //                                 children: [
    //                                   Image.network(
    //                                       'http://pngimg.com/uploads/google/google_PNG19635.png',
    //                                       fit: BoxFit.cover),
    //                                   const Text('  Continue with Google',
    //                                       style:
    //                                           TextStyle(color: Colors.black)),
    //                                 ],
    //                               )),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class RegistrationCard extends StatelessWidget {
  const RegistrationCard({
    Key? key,
    required double cardWidth,
    required double cardHeight,
    required this.model,
    required this.child,
  })  : _cardWidth = cardWidth,
        _cardHeight = cardHeight,
        super(key: key);

  final double _cardWidth;
  final double _cardHeight;
  final UserModel model;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Container(
            width: (MediaQuery.of(context).size.height > 652)
                ? _cardWidth
                : _cardWidth - 50,
            height: (MediaQuery.of(context).size.height > 751)
                ? _cardHeight
                : (MediaQuery.of(context).size.height > 652)
                    ? _cardHeight - 100
                    : _cardHeight - 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(model.getImages[2]), fit: BoxFit.fill),
            ),
            child: child)
      ],
    );
  }
}
