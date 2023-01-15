import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpConfirmScreen extends StatefulWidget {
  const OtpConfirmScreen({super.key});

  @override
  State<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen> {
  String completedPin = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/password.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text('OTP Verification',
                  style: customTextStyle(18, FontWeight.w600)),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 125),
              child: Text(
                'Please enter the OTP send to your number',
                style: customTextStyle(13, FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 75),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  outlineBorderRadius: 5,
                  style: customTextStyle(24, FontWeight.w600),
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Color(0xffF5F5F5),
                    borderColor: Colors.transparent,
                  ),
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) async {
                    setState(() {
                      completedPin = pin;
                    });
                  }),
            ),
            const SizedBox(height: 75),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              indent: 125,
              endIndent: 125,
            ),
            const SizedBox(height: 50),
            Text('Didn\'t receive an OTP?',
                style: customTextStyle(13, FontWeight.w500)),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Text(
                'Resend OTP',
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 125),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 1,
                    fixedSize: const Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: customTextStyle(15, FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
