// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print

import 'dart:math';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cardflip/models/user_model.dart';
import "dart:developer" as developer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late String currentIcon;
  @override
  void initState() {
    currentIcon = Random().nextInt(18).toString();
    super.initState();
  }

  UserModel model = UserModel();
  TextEditingController ControllerFirstNameData = TextEditingController();
  TextEditingController ControllerLastNameData = TextEditingController();
  TextEditingController ControllerUsernameData = TextEditingController();

  final firstNameKey = GlobalKey<FormState>();
  final lastNameKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormState>();
  final _userCollection = FirebaseFirestore.instance.collection("user");
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(UserDataProvider);
    if (counter++ == 0) {
      ControllerFirstNameData.text = userData!.fname;
      ControllerLastNameData.text = userData.lname;
      ControllerUsernameData.text = userData.username;
      currentIcon = userData.icon;
    }
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
                  padding: EdgeInsets.only(top: 25, left: 15),
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
                          width: 45,
                          height: 45,
                          child: const Text(""))),
                ),
                Center(
                  child: Text('Edit Profile',
                      style: TextStyle(
                          color: Color(0xBF000000),
                          fontFamily: 'PolySans_Median',
                          fontSize: 42,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(children: [
                    CircleAvatar(
                      backgroundColor: Colors.white60,
                      radius: 65,
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
                                  child:
                                      Icon(Icons.upload, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                                                currentIcon =
                                                    (i + 1).toString();
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
                                                currentIcon =
                                                    (i + 2).toString();
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    'First Name',
                    style: TextStyle(
                      fontFamily: 'PolySans_Neutral',
                      fontSize: 24,
                      color: Color.fromARGB(255, 49, 49, 49),
                    ),
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
                      fillColor: Color.fromARGB(93, 167, 167, 167),
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
                    'Last Name',
                    style: TextStyle(
                      fontFamily: 'PolySans_Neutral',
                      fontSize: 24,
                      color: Color.fromARGB(255, 49, 49, 49),
                    ),
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
                      fillColor: Color.fromARGB(93, 167, 167, 167),
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
                    'Username',
                    style: TextStyle(
                      fontFamily: 'PolySans_Neutral',
                      fontSize: 24,
                      color: Color.fromARGB(255, 49, 49, 49),
                    ),
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
                      fillColor: Color.fromARGB(93, 167, 167, 167),
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
                  padding: EdgeInsets.only(bottom: 20, top: 15),
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () async {
                        if (ControllerFirstNameData.text != userData!.fname ||
                            ControllerLastNameData.text != userData.lname ||
                            ControllerUsernameData.text != userData.username ||
                            currentIcon != userData.profileIcon) {
                          if (ControllerFirstNameData.text.isNotEmpty &&
                              ControllerLastNameData.text.isNotEmpty &&
                              ControllerUsernameData.text.isNotEmpty) {
                            _userCollection.doc(userData.id).update({
                              "fname": ControllerFirstNameData.text,
                              "lname": ControllerLastNameData.text,
                              "username": ControllerUsernameData.text,
                              "profileIcon": currentIcon
                            }).then((value) {
                              ref
                                  .read(UserDataProvider.notifier)
                                  .state!
                                  .firstname = ControllerFirstNameData.text;
                              ref
                                  .read(UserDataProvider.notifier)
                                  .state!
                                  .lastname = ControllerLastNameData.text;
                              ref
                                  .read(UserDataProvider.notifier)
                                  .state!
                                  .username = ControllerUsernameData.text;
                              ref
                                  .read(UserDataProvider.notifier)
                                  .state!
                                  .profileIcon = currentIcon;

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Container(
                                        width: 300,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Images/backgrounds/homepage.png"),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            DefaultTextStyle(
                                              style: TextStyle(
                                                fontFamily: 'PolySans_Neutral',
                                                fontSize: 24,
                                                color: Color.fromARGB(
                                                    255, 49, 49, 49),
                                              ),
                                              child: Text(
                                                "Profile Updated",
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, "/home",
                                                          arguments: {
                                                        "nav": 2,
                                                      });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Colors.grey
                                                            .withOpacity(0.30)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: DefaultTextStyle(
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PolySans_Neutral',
                                                        fontSize: 25,
                                                        color: Color.fromARGB(
                                                            255, 49, 49, 49),
                                                      ),
                                                      child: Text(
                                                        "Ok",
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            });
                            // Navigator.pushNamed(context, "/home");
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("Please fill in all fields"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"))
                                    ],
                                  );
                                });
                          }
                        }
                        // await _userCollection.doc(userData!.id).update({
                        //   "fname": ControllerFirstNameData.text,
                        //   "lname": ControllerLastNameData.text,
                        //   "username": ControllerUsernameData.text,
                        //   "profileIcon": currentIcon
                        // });
                        // Navigator.pushNamed(context, "/home");
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(0.30)),
                          width: 85,
                          height: 45,
                          child: const Text("Done",
                              style: TextStyle(
                                  color: Color(0xFF191C32),
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)))),
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

