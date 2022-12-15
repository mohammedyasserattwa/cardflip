// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable

import 'package:cardflip/models/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:cardflip/screens/Login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../data/User.dart';
import '../widgets/Input.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  loginModel Object = loginModel(data: User());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Input.registerKey,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Images/backgrounds/loginpage.png'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 70),
                child: Text(
                  'Create\nAccount',
                  style: TextStyle(
                    color: Color(0xFF191C32),
                    fontFamily: 'Poppins',
                    fontSize: 40,
                  ),
                ),
              ),
              ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            children: [
                              Input(
                                  hintTextOne: "Username",
                                  icon: Icons.person_outline_outlined,
                                  obscureText: false,
                                  color: Color(0xFFF98800),
                                  validator: (val) {
                                    if (val != null && val.isNotEmpty) {
                                      return null;
                                    } else {
                                      return '* Required';
                                    }
                                  },
                                  Object: Object),
                              SizedBox(
                                height: 15,
                              ),
                              Input(
                                  hintTextOne: "Email",
                                  icon: Icons.email_rounded,
                                  obscureText: false,
                                  color: Color(0xFF5FC88F),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                    EmailValidator(
                                        errorText: "Enter valid email"),
                                  ]),
                                  Object: Object),
                              SizedBox(
                                height: 15,
                              ),
                              Input(
                                  hintTextOne: "Password",
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  color: Color.fromARGB(255, 184, 145, 229),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                    MinLengthValidator(6,
                                        errorText:
                                            "Password should be atleast 6 characters"),
                                    MaxLengthValidator(15,
                                        errorText:
                                            "Password should not be greater than 15 characters")
                                  ]),
                                  Object: Object),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 340,
                                height: 58,
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
                                  child: Center(
                                      child: const Text(
                                    'Register',
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Already have an account? "),
                                        TextSpan(
                                            text: "Sign In",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 240,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF78E7F5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                  child: Center(
                                      child: Row(
                                    children: [
                                      Image.network(
                                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                                          fit: BoxFit.cover),
                                      const Text('  Continue with Google',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
