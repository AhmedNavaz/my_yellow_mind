import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/constants/style.dart';

class OtpSendScreen extends StatefulWidget {
  const OtpSendScreen({super.key});

  @override
  State<OtpSendScreen> createState() => _OtpSendScreenState();
}

class _OtpSendScreenState extends State<OtpSendScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  String countryCode = '+92';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 302,
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
                child: Text('OTP VERIFICATION',
                    style: customTextStyle(18, FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: countryCode,
                        hintStyle: customTextStyle(13, FontWeight.w500),
                        suffixIcon: const RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 17.5,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              countryCode = '+${country.phoneCode}';
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Enter your mobile number',
                        hintStyle: customTextStyle(13, FontWeight.w500),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 125),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, OtpConfirmRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 1,
                          fixedSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          'Send',
                          style: customTextStyle(15, FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
