// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable, no_leading_underscores_for_local_identifiers, prefer_const_declarations

import 'dart:math';

import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/loginModel.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/screens/loading_screen.dart';
import 'package:cardflip/widgets/card_widget.dart';
import 'package:cardflip/widgets/email_info_card.dart';
import 'package:cardflip/widgets/email_verification_card.dart';
import 'package:cardflip/widgets/personal_information_card.dart';
import 'package:cardflip/widgets/profile_icon_card.dart';
import 'package:cardflip/widgets/tags_register_card.dart';
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

  // final _CategoryController = TextEditingController();

  final _duration = const Duration(milliseconds: 250);
  final _keyParams = {
    "Email": GlobalKey<FormState>(),
    "Personal": GlobalKey<FormState>(),
    "Category": GlobalKey<FormState>(),
    "Icon": GlobalKey<FormState>(),
  };
  Map<String, bool> _pages = {
    "email": false,
    "name": false,
    "icon": false,
    "tags": false,
    "verify": false
  };
  late List<List<double>> _animationParams;
  late String currentIcon;
  late User newUser;

  void renderAnimation(int card, double start, double end) {
    _animationParams[card] = [start, end];
  }

  _changePage(String page) {
    _pages.forEach((key, value) {
      _pages[key] = false;
    });
    _pages[page] = true;
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
    newUser = User.New();
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
                        //OPTIMIZE: EMPTY CARDS
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

                        //OPTIMIZE: EMAIL VERIFICATION
                        EmailVerificationCard(
                            user: newUser,
                            height: _cardHeight,
                            width: _cardWidth,
                            check: _pages["email"]!,
                            model: model,
                            onBack: () {
                              renderAnimation(2, 1000, 0);
                              _changePage("tags");
                              setState(() {});
                            }),

                        //OPTIMIZE: TAGS
                        TagsRegister(
                          user: newUser,
                          height: _cardHeight,
                          width: _cardWidth,
                          model: model,
                          onBack: () {
                            renderAnimation(4, 1000, 0);
                            setState(() {});
                          },
                          onNext: () {
                            renderAnimation(2, 0, 1000);
                            _changePage("email");
                            setState(() {});
                          },
                          animationParams: _animationParams,
                          duration: _duration,
                        ),

                        //OPTIMIZE: PROFILE ICON
                        ProfileIconCard(
                            user: newUser,
                            height: _cardHeight,
                            width: _cardWidth,
                            model: model,
                            onBack: () {
                              renderAnimation(1, 1000, 0);
                              setState(() {});
                            },
                            onNext: () {
                              renderAnimation(4, 0, 1000);
                              setState(() {});
                            },
                            animationParams: _animationParams,
                            duration: _duration),

                        //OPTIMIZE: PERSONAL INFORMATION
                        PersonalCard(
                            height: _cardHeight,
                            width: _cardWidth,
                            model: model,
                            onBack: () {
                              renderAnimation(0, 1000, 0);
                              setState(() {});
                            },
                            onNext: () {
                              renderAnimation(1, 0, 1000);
                              newUser.setfname(_fnamecontroller.text);
                              newUser.setlname(_lnamecontroller.text);
                              setState(() {});
                            },
                            animationParams: _animationParams,
                            duration: _duration,
                            formKey: _keyParams["Personal"]!,
                            fnamecontroller: _fnamecontroller,
                            lnamecontroller: _lnamecontroller),
                        //OPTIMIZE: EMAIL INFO
                        EmailInfoCard(
                            height: _cardHeight,
                            width: _cardWidth,
                            model: model,
                            onNext: () {
                              renderAnimation(0, 0, 1000);
                              newUser.setEmail(_emailController.text);
                              newUser.setPassword(_passwordController.text);
                              newUser.setUsername(_usernameController.text);
                              setState(() {});
                            },
                            animationParams: _animationParams,
                            duration: _duration,
                            formKey: _keyParams["Email"]!,
                            usernameController: _usernameController,
                            emailController: _emailController,
                            passwordController: _passwordController)
                      ],
                    )),
                  ]),
            ],
          ),
        ],
      ),
    )));
  }
}
