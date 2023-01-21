import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class SearchPeopleItem extends StatelessWidget {
  const SearchPeopleItem({
    Key? key,
    required this.person,
  }) : super(key: key);

  final dynamic person;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/othersProfile', arguments: {
          "id": person["id"],
        });
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("Images/avatars/${person["profileIcon"]}.svg",
                    height: 47.4, width: 47.4),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person["fname"] + " " + person["lname"],
                      style: const TextStyle(
                        fontFamily: "PolySans_Neutral",
                        fontSize: 20,
                        color: Color(0xff212523),
                      ),
                    ),
                    Text(
                      "@${person["username"]}",
                      style: const TextStyle(
                        fontFamily: "Poppins-Light",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff212523),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
