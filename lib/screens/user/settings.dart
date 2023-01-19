import 'package:cardflip/models/user_model.dart';
import "package:flutter/material.dart";

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = UserModel();
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Images/backgrounds/homepage.png"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    userModel.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/", ModalRoute.withName('/'));
                  },
                  child: Container(
                    child: const Text("Sign out"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
