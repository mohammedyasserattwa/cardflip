// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable, no_leading_underscores_for_local_identifiers, prefer_const_declarations

import 'dart:math';

import 'package:cardflip/models/loginModel.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:cardflip/screens/Login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
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
  final _tagController = TextEditingController();
  // final _CategoryController = TextEditingController();

  final _duration = const Duration(milliseconds: 250);
  final _keyParams = {
    "Email": GlobalKey<FormState>(),
    "Personal": GlobalKey<FormState>(),
    "Category": GlobalKey<FormState>(),
    "Icon": GlobalKey<FormState>(),
  };
  late List<List<double>> _animationParams;
  late String currentIcon;

  void renderAnimation(int card, double start, double end) {
    _animationParams[card] = [start, end];
  }

  @override
  void initState() {
    currentIcon = Random().nextInt(18).toString();
    _animationParams = [
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0]
    ]; // 0:Email - 1:Personal - 4:Profile Icon - 2:Category - 3:Auth
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _cardWidth = 343;
    final double _cardHeight = 580.97;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Images/backgrounds/login_page_2.png'),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 40, bottom: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "Images/icons/svg/arrow-left-s-line.svg",
                color: Color(0xFF191C32),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
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
                          cardHeight: _cardHeight,
                          cardWidth: _cardWidth,
                          model: model,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                    padding: EdgeInsets.only(top: 30),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
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
                                    padding: EdgeInsets.only(
                                        top: 15, left: 15, right: 15),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Color(0xFF191C32),
                                              fontFamily: 'Poppins',
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "Account activation link has been\n"),
                                            TextSpan(
                                                text:
                                                    "sent to the email address you\n"),
                                            TextSpan(text: "provided. \n"),
                                          ]),
                                    )),
                              ),
                              Center(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: 120, left: 15, right: 15),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Color(0xFF191C32),
                                              fontFamily: 'Poppins',
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "Please check the spam folder if\n"),
                                            TextSpan(
                                                text:
                                                    "the email was not sent.\n"),
                                          ]),
                                    )),
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
                                              builder: (context) => Login()));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF191C32),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Center(
                                        child: const Text(
                                      'Verify',
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: (_animationParams != null)
                                  ? _animationParams[2][0]
                                  : 0.0,
                              end: (_animationParams != null)
                                  ? _animationParams[2][1]
                                  : 0.0),
                          duration: _duration,
                          builder: (context, double pos, __) => Transform(
                            transform: Matrix4.identity()..translate(pos),
                            child: RegistrationCard(
                              cardWidth: _cardWidth,
                              cardHeight: _cardHeight,
                              model: model,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          renderAnimation(4, 1000, 0);
                                          setState(() {});
                                        },
                                        child: SvgPicture.asset(
                                          "Images/icons/svg/arrow-left-s-line.svg",
                                          color: Color(0xFF191C32),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Card(
                                          elevation: 0.0,
                                          color: Color(0x1f1A0404),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Colors.transparent,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "Images/icons/svg/search.svg",
                                                ),
                                                Flexible(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    cursorColor:
                                                        Colors.grey[600],
                                                    controller: _tagController,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "PolySans_Neutral",
                                                      fontSize: 20,
                                                    ),
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      // border:,

                                                      hintText: "Search Tags",
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontFamily:
                                                            "PolySans_Neutral",
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView(
                                      children: [],
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 85,
                                          left: 30,
                                          right: 30,
                                          bottom: 30),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // if (Input.registerKey.currentState!
                                          //     .validate()) {
                                          renderAnimation(2, 0, 1000);
                                          setState(() {});
                                          // }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF191C32),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
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
                                  ]),
                            ),
                          ),
                        ),
                        TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: (_animationParams != null)
                                  ? _animationParams[4][0]
                                  : 0.0,
                              end: (_animationParams != null)
                                  ? _animationParams[4][1]
                                  : 0.0),
                          duration: _duration,
                          builder: (context, double pos, __) => Transform(
                            transform: Matrix4.identity()..translate(pos),
                            child: RegistrationCard(
                              cardWidth: _cardWidth,
                              cardHeight: _cardHeight,
                              model: model,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            renderAnimation(1, 1000, 0);
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                            "Images/icons/svg/arrow-left-s-line.svg",
                                            color: Color(0xFF191C32),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
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
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          children: [
                                            SvgPicture.asset(
                                              "Images/avatars/$currentIcon.svg",
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF191C32),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(Icons.upload,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        radius: 75,
                                      ),
                                      SizedBox(
                                        height: 275,
                                        child: NoGlowScroll(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Scrollbar(
                                              child: ListView(
                                                children: [
                                                  for (int i = 0;
                                                      i < 18;
                                                      i += 3)
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  currentIcon =
                                                                      i.toString();
                                                                });
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white60,
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "Images/avatars/$i.svg",
                                                                ),
                                                                radius: 35,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  currentIcon =
                                                                      (i + 1)
                                                                          .toString();
                                                                });
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white60,
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "Images/avatars/${i + 1}.svg",
                                                                ),
                                                                radius: 35,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  currentIcon =
                                                                      (i + 2)
                                                                          .toString();
                                                                });
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white60,
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "Images/avatars/${i + 2}.svg",
                                                                ),
                                                                radius: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
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
                                            // if () {
                                            //   // renderAnimation("Category", 0, 0);
                                            renderAnimation(4, 0, 1000);
                                            setState(() {});
                                            // }
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: (_animationParams != null)
                                  ? _animationParams[1][0]
                                  : 0.0,
                              end: (_animationParams != null)
                                  ? _animationParams[1][1]
                                  : 0.0),
                          duration: _duration,
                          builder: (context, double pos, __) => Transform(
                            transform: Matrix4.identity()..translate(pos),
                            child: RegistrationCard(
                              cardWidth: _cardWidth,
                              cardHeight: _cardHeight,
                              model: model,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        renderAnimation(0, 1000, 0);
                                        setState(() {});
                                      },
                                      child: SvgPicture.asset(
                                        "Images/icons/svg/arrow-left-s-line.svg",
                                        color: Color(0xFF191C32),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Text(
                                      'Create \nAccount',
                                      style: TextStyle(
                                        color: Color(0xFF191C32),
                                        fontFamily: 'PolySans_Median',
                                        fontSize: 48,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Column(
                                    children: [
                                      Form(
                                        key: _keyParams["Personal"],
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30, left: 30, right: 30),
                                              child: Input(
                                                hintTextOne: "First Name",
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15, left: 30, right: 30),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_keyParams["Personal"]!
                                                      .currentState!
                                                      .validate()) {
                                                    // renderAnimation("Category", 0, 0);
                                                    renderAnimation(1, 0, 1000);
                                                    setState(() {});
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
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: Center(
                                                      child: const Text(
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
                        TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: (_animationParams != null)
                                  ? _animationParams[0][0]
                                  : 0.0,
                              end: (_animationParams != null)
                                  ? _animationParams[0][1]
                                  : 0.0),
                          duration: _duration,
                          builder: (context, double pos, __) => Transform(
                            transform: Matrix4.identity()..translate(pos),
                            child: RegistrationCard(
                              cardWidth: _cardWidth,
                              cardHeight: _cardHeight,
                              model: model,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        'Create\nAccount',
                                        style: TextStyle(
                                          color: Color(0xFF191C32),
                                          fontFamily: 'PolySans_Median',
                                          fontSize: 48,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _keyParams["Email"],
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 30),
                                            child: Input(
                                              controller: _usernameController,
                                              hintTextOne: "Username",
                                              icon:
                                                  Icons.person_outline_outlined,
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
                                                if (RegExp(r'\s')
                                                    .hasMatch(value)) {
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
                                                top: 45, left: 30, right: 30),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_keyParams["Email"]!
                                                    .currentState!
                                                    .validate()) {
                                                  renderAnimation(0, 0, 1000);
                                                  setState(() {});
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                          ),
                        )
                      ],
                    )),
                  ]),
            ],
          ),
        ],
      ),
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
