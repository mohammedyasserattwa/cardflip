import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/loginpage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: const VerifyWidget(),
      ),
    );
  }
}

class VerifyWidget extends StatefulWidget {
  const VerifyWidget({super.key});

  @override
  State<VerifyWidget> createState() => _VerifyWidgetState();
}

class _VerifyWidgetState extends State<VerifyWidget> {
  bool _isVerified = false;

  @override
  void initState() {
    sendEmail().then((value) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
        if (_isVerified) {
          timer.cancel();
        }
      });
    });
    super.initState();
  }

  Future sendEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  checkEmailVerified() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _isVerified = user.emailVerified;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Verify your email"),
              const SizedBox(height: 20),
              if (_isVerified)
                const Text("Email verified")
              else
                const Text("Email not verified"),
              const SizedBox(height: 20),
              if (_isVerified)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/home", (route) => true);
                  },
                  child: const Text("Proceed to the application"),
                )
            ])));
  }
}
