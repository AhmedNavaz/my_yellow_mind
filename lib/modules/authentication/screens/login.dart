import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../../constants/style.dart';
import '../provider/authProvider.dart';
import '../widgets/customTextField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // text field controllers
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height:
                  size.height < 800 ? size.height * 0.33 : size.height * 0.3,
              padding: EdgeInsets.only(
                  top: size.height < 800 ? 75 : 100, left: 30, right: 30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/auth_back.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1347495868/photo/smiling-african-american-man-wearing-glasses.jpg?b=1&s=170667a&w=0&k=20&c=CVpXibLIGjpa2_sFFgt_ejrz06ULDMZy0ylqK-VnZRU='),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height < 800 ? 30 : 50),
                    child: Text('Welcome back',
                        style: customTextStyle(18, FontWeight.w600,
                            color: Colors.white)),
                  ),
                  Text('Pleas enter your details',
                      style: customTextStyle(11, FontWeight.w300,
                          color: Colors.white)),
                ],
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
                    // const SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: rememberMe,
                    //       onChanged: (bool? value) {
                    //         setState(() {
                    //           rememberMe = value!;
                    //         });
                    //       },
                    //       checkColor: primaryColor,
                    //       activeColor: Colors.white,
                    //     ),
                    //     Text('Remember me',
                    //         style: customTextStyle(13, FontWeight.w500)),
                    //   ],
                    // ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            UIBlock.block(context);
                            Provider.of<AuthProvider>(context, listen: false)
                                .login(
                              _emailController.text,
                              _passwordController.text,
                            )
                                .then((value) {
                              if (value) {
                                UIBlock.unblock(context);
                                Navigator.pushNamed(context, HomeScreenRoute);
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
                        child: Text('Login',
                            style: customTextStyle(16, FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(height: 50),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                                fontSize: 17, color: Colors.black),
                            children: [
                              const TextSpan(
                                text: 'Not have an account? ',
                              ),
                              TextSpan(
                                  text: 'Signup',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(
                                          context, CreateAccountRoute);
                                    }),
                            ],
                          ),
                        ),
                      ),
                    )
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
