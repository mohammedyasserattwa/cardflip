import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem(
      {Key? key,
      required this.name,
      required this.path,
      required this.isActive})
      : super(key: key);
  final String name;
  final String path;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          path,
          width: 24,
          height: 24,
          color: (isActive) ? Colors.white : const Color(0xffA8A8A8),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            color: (isActive) ? Colors.white : const Color(0xffA8A8A8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
