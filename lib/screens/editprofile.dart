// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String currentIcon;
  @override
  void initState() {
    currentIcon = Random().nextInt(18).toString();
    super.initState();
  }

  TextEditingController ControllerFirstNameData = TextEditingController();
  TextEditingController ControllerLastNameData = TextEditingController();
  TextEditingController ControllerUsernameData = TextEditingController();

  final firstNameKey = GlobalKey<FormState>();
  final lastNameKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Images/backgrounds/homepage.png'),
            fit: BoxFit.cover),
      ),
      child: NoGlowScroll(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 25),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "Images/icons/arrow-left-s-line.png"),
                                fit: BoxFit.cover),
                          ),
                          width: 40,
                          height: 40,
                          child: const Text(""))),
                ),
                Center(
                  child: Text('Edit Profile',
                      style: TextStyle(
                          color: Color(0xFF191C32),
                          fontFamily: 'Poppins',
                          fontSize: 40,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(children: [
                  CircleAvatar(
                    backgroundColor: Colors.white60,
                    radius: 75,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        SvgPicture.asset(
                          "Images/avatars/$currentIcon.svg",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF191C32),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.upload, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 210,
                    child: NoGlowScroll(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Scrollbar(
                          child: ListView(
                            children: [
                              for (int i = 0; i < 18; i += 3)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentIcon = i.toString();
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white60,
                                            radius: 35,
                                            child: SvgPicture.asset(
                                              "Images/avatars/$i.svg",
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentIcon = (i + 1).toString();
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white60,
                                            radius: 35,
                                            child: SvgPicture.asset(
                                              "Images/avatars/${i + 1}.svg",
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentIcon = (i + 2).toString();
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white60,
                                            radius: 35,
                                            child: SvgPicture.asset(
                                              "Images/avatars/${i + 2}.svg",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
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
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    'First Name:',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 30.0, right: 30),
                  child: TextField(
                    controller: ControllerFirstNameData,
                    key: firstNameKey,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    'Last Name:',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 30.0, right: 30),
                  child: TextField(
                    key: lastNameKey,
                    controller: ControllerLastNameData,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    'Username:',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 30.0, right: 30),
                  child: TextField(
                    key: usernameKey,
                    controller: ControllerUsernameData,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () {
                        if (ControllerFirstNameData.text.isEmpty ||
                            ControllerLastNameData.text.isEmpty ||
                            ControllerUsernameData.text.isEmpty)
                          print('Please enter a text into the fields');
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(0.30)),
                          width: 100,
                          height: 45,
                          child: const Text("Done",
                              style: TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)))),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
//first name last name username

