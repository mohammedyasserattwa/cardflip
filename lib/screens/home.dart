// ignore_for_file: unnecessary_new

import "package:flutter/material.dart";
import '../models/homeModel.dart';
import '../data/dummy_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeModel model = new HomeModel(new DummyData());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Images/Home_Page_Background.png"),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 45, 0, 0),
            child: Stack(
              children: [
                Container(
                  child: Text(
                    "Explore",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      color: Color(0xff514F55),
                      fontSize: 36,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/search.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: Text(""))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 14, 0, 0),
            child: Text(
              "Welcome back, ${model.fname}",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
            child: Text(
              "Pick up where you left off",
              style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 19,
                color: Color(0xff212523),
              ),
            ),
          ),
          SizedBox(
            height: 130,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/homepage/13/1/1.png"),
                          fit: BoxFit.cover),
                    ),
                    width: 139,
                    height: 116.67,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Hello"),
                    )),
              ),
              Container(
                child: Text("Hello2"),
              )
            ]),
          )
        ],
      ),
    );
  }
}
