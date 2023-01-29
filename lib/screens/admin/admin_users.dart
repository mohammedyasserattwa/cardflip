//import 'dart:ffi';
// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

import 'package:cardflip/models/deck_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../../helpers/random_generator.dart';
import '../../models/admin_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  AdminModel model = AdminModel();

  DeckModel deckModel = DeckModel();

  RandomGenerator cardgenerator = RandomGenerator();
  String _filter = "all";

  BoxDecoration _isActive() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Color.fromARGB(100, 124, 120, 120),
    );
  }

  BoxDecoration _isNotActive() {
    return BoxDecoration();
  }

  @override
  Widget build(BuildContext context) {
    final userData = model.userDataList(filter: _filter);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/dashboardpage.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/settings");
                      },
                      child: SvgPicture.asset(
                        "Images/icons/svg/settings.svg",
                        width: 25,
                        height: 25,
                        color: Color(0xff8C9595),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "Images/avatars/logo/playstore (1) 1.png"),
                            fit: BoxFit.cover),
                      ),
                      width: 85,
                      height: 85,
                      child: Text("")),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      "Dashboard ",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Color(0xf0493C3F),
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/adminDeck");
                    },
                    child: Text(
                      "Decks",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Color.fromARGB(99, 98, 102, 100),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Users",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/adminReports");
                    },
                    child: Text(
                      "Reports",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Color.fromARGB(99, 98, 102, 100),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 31,
                  alignment: Alignment.center,
                  decoration: _filter == "all" ? _isActive() : _isNotActive(),
                  child: GestureDetector(
                    onTap: () {
                      if (_filter != "all") {
                        setState(() {
                          _filter = "all";
                        });
                      }
                    },
                    child: Text(
                      "All",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 31,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration:
                      _filter == "banned" ? _isActive() : _isNotActive(),
                  child: GestureDetector(
                    onTap: () {
                      if (_filter != "banned") {
                        setState(() {
                          _filter = "banned";
                        });
                      }
                    },
                    child: Text(
                      "Banned",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 31,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration:
                      _filter == "normal" ? _isActive() : _isNotActive(),
                  child: GestureDetector(
                    onTap: () {
                      if (_filter != "normal") {
                        setState(() {
                          _filter = "normal";
                        });
                      }
                    },
                    child: Text(
                      "Normal",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            FutureBuilder(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: NoGlowScroll(
                        child: ListView(
                          children: [
                            for (var i = 0; i < snapshot.data!.length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                            "Images/avatars/${snapshot.data![i]["profileIcon"]}.svg",
                                            width: 50,
                                            height: 50),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data![i]["fname"]} ${snapshot.data![i]["lname"]}",
                                              style: TextStyle(
                                                fontFamily: "PolySans_Slim",
                                                color: Color(0xf0493C3F),
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "@${snapshot.data![i]["username"]}",
                                              style: TextStyle(
                                                fontFamily: "PolySans_Slim",
                                                color: Color(0xf0493C3F),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                if (await InternetConnectionChecker()
                                                    .hasConnection) {
                                                  if (snapshot.data![i]
                                                          ["banned"] ==
                                                      true) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Center(
                                                          child: Container(
                                                            width: 300,
                                                            height: 200,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "Images/backgrounds/homepage.png"),
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  "Confirm Unbanning!",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "PolySans_Median",
                                                                    color: Color
                                                                        .fromARGB(
                                                                            239,
                                                                            105,
                                                                            0,
                                                                            0),
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Are you sure you want to unban this user?",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "PolySans_Slim",
                                                                    color: Color
                                                                        .fromARGB(
                                                                            239,
                                                                            105,
                                                                            0,
                                                                            0),
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    ButtonBar(
                                                                        children: [
                                                                          TextButton(
                                                                            child:
                                                                                Text("Cancel"),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          TextButton(
                                                                            child:
                                                                                Text("Yes"),
                                                                            onPressed:
                                                                                () {
                                                                              model.unbanUser(snapshot.data![i]["id"]);
                                                                              Navigator.of(context).pop();
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return Center(
                                                                                    child: Container(
                                                                                      width: 300,
                                                                                      height: 200,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        image: DecorationImage(image: AssetImage("Images/backgrounds/homepage.png"), fit: BoxFit.cover),
                                                                                      ),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          SizedBox(height: 10),
                                                                                          Text(
                                                                                            "Unbanned!",
                                                                                            style: TextStyle(
                                                                                              fontFamily: "PolySans_Median",
                                                                                              color: Color.fromARGB(239, 105, 0, 0),
                                                                                              fontSize: 20,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            "User Unbanned Successfully",
                                                                                            style: TextStyle(
                                                                                              fontFamily: "PolySans_Slim",
                                                                                              color: Color.fromARGB(239, 105, 0, 0),
                                                                                              fontSize: 20,
                                                                                            ),
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                            children: [
                                                                                              TextButton(
                                                                                                child: Text("Close"),
                                                                                                onPressed: () {
                                                                                                  setState(() {});
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                          ),
                                                                        ]),
                                                                  ],
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
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                            child: Container(
                                                              width: 300,
                                                              height: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        "Images/backgrounds/homepage.png"),
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    "Confirm Banning!",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "PolySans_Median",
                                                                      color: Color
                                                                          .fromARGB(
                                                                              239,
                                                                              105,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Are you sure you want to ban this user?",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "PolySans_Slim",
                                                                      color: Color
                                                                          .fromARGB(
                                                                              239,
                                                                              105,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      ButtonBar(
                                                                          children: [
                                                                            TextButton(
                                                                              child: Text("Cancel"),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: Text("Yes"),
                                                                              onPressed: () {
                                                                                model.banUser(snapshot.data![i]["id"]);
                                                                                Navigator.of(context).pop();
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return Center(
                                                                                      child: Container(
                                                                                        width: 300,
                                                                                        height: 200,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          image: DecorationImage(image: AssetImage("Images/backgrounds/homepage.png"), fit: BoxFit.cover),
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                          children: [
                                                                                            SizedBox(height: 10),
                                                                                            Text(
                                                                                              "Banned!",
                                                                                              style: TextStyle(
                                                                                                fontFamily: "PolySans_Median",
                                                                                                color: Color.fromARGB(239, 105, 0, 0),
                                                                                                fontSize: 20,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              "User Banned Successfully",
                                                                                              style: TextStyle(
                                                                                                fontFamily: "PolySans_Slim",
                                                                                                color: Color.fromARGB(239, 105, 0, 0),
                                                                                                fontSize: 20,
                                                                                              ),
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                              children: [
                                                                                                TextButton(
                                                                                                  child: Text("Close"),
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(context).pop();
                                                                                                    setState(() {});
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                            ),
                                                                          ]),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  }
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Center(
                                                        child: Container(
                                                          width: 300,
                                                          height: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "Images/backgrounds/homepage.png"),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                "Error!",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "PolySans_Median",
                                                                  color: Color
                                                                      .fromARGB(
                                                                          239,
                                                                          105,
                                                                          0,
                                                                          0),
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Connection Error. Please check your internet connection.",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "PolySans_Slim",
                                                                  color: Color
                                                                      .fromARGB(
                                                                          239,
                                                                          105,
                                                                          0,
                                                                          0),
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  TextButton(
                                                                    child: Text(
                                                                        "Close"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                                setState(() {});
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(snapshot
                                                                        .data![i]
                                                                    [
                                                                    "banned"] ==
                                                                false
                                                            ? "Images/icons/ban.png"
                                                            : "Images/icons/unban.png"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  width: 35,
                                                  height: 35,
                                                  child: Text("")),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/othersProfile',
                                                    arguments: {
                                                      "id": (snapshot.data![i]
                                                          ["id"]),
                                                    });
                                                print(snapshot.data![i]["id"]);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "Images/icons/arrow-right-s-line.png"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  width: 35,
                                                  height: 35,
                                                  child: Text("")),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
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
                  if (snapshot.hasError) {
                    return Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xff484848),
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "PolySans_Neutral"),
                                                           "Something went wrong.");
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
