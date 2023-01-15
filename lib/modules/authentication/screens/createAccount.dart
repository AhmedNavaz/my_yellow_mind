import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/style.dart';
import '../provider/authProvider.dart';
import '../widgets/customTextField.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // text field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.3,
              padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/auth_back.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 20),
                child: Text('Welcome',
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    CustomTextFieldWidget(
                      textController: _emailController,
                      title: 'Email',
                      hintText: 'Enter your email address',
                      obscure: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }

                        if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldWidget(
                      textController: _passwordController,
                      title: 'Password',
                      hintText: 'Enter your Password',
                      obscure: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldWidget(
                      textController: _confirmPasswordController,
                      title: 'Confirm Password',
                      hintText: 'Confirm your Password',
                      obscure: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: customTextStyle(10, FontWeight.w500,
                              color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: customTextStyle(
                            10,
                            FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(Uri.parse(""));
                            },
                        ),
                        TextSpan(
                          text: ' and ',
                          style: customTextStyle(10, FontWeight.w500,
                              color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: customTextStyle(
                            10,
                            FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, PrivacyPolicyRoute);
                            },
                        ),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          UIBlock.block(context);
                          Provider.of<AuthProvider>(context, listen: false)
                              .signUp(
                            '',
                            _emailController.text,
                            _passwordController.text,
                          )
                              .then((value) {
                            if (value) {
                              UIBlock.unblock(context);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, WelcomScreenRoute, (route) => false);
                            } else {
                              UIBlock.unblock(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Something went wrong, please try again'),
                                ),
                              );
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        fixedSize: const Size(116, 33),
                      ),
                      child: Text('Sign up',
                          style: customTextStyle(16, FontWeight.w500)),
                    ),
                    const SizedBox(height: 30),
                    Row(children: [
                      const Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "OR",
                          style: customTextStyle(13, FontWeight.w500),
                        ),
                      ),
                      const Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      )),
                    ]),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            UIBlock.block(context);
                            Provider.of<AuthProvider>(context, listen: false)
                                .googleLogin()
                                .then((value) {
                              UIBlock.unblock(context);
                              if (value == 'new') {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    WelcomScreenRoute, (route) => false);
                              } else if (value == 'success') {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, HomeScreenRoute, (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Something went wrong, please try again'),
                                  ),
                                );
                              }
                            });
                          },
                          child: Image.asset(
                            'assets/images/google.png',
                          ),
                        ),
                        // const SizedBox(width: 30),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Image.asset(
                        //     'assets/images/twitter.png',
                        //   ),
                        // ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            UIBlock.block(context);
                            Provider.of<AuthProvider>(context, listen: false)
                                .facebookLogin()
                                .then((value) {
                              UIBlock.unblock(context);
                              if (value == 'new') {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    WelcomScreenRoute, (route) => false);
                              } else if (value == 'success') {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, HomeScreenRoute, (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Something went wrong, please try again'),
                                  ),
                                );
                              }
                            });
                          },
                          child: Image.asset(
                            'assets/images/facebook.png',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                              fontSize: 17, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: 'Have an account? ',
                            ),
                            TextSpan(
                                text: 'Log in',
                                style: const TextStyle(
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, LoginRoute);
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
