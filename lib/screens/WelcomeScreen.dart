import 'package:flutter/material.dart';
import 'package:lh_cmru/screens/SigninScreen.dart';
import 'package:lh_cmru/widgets/CustomScaffold.dart';
import 'package:lh_cmru/widgets/WelcomeButton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // เพิ่มภาพที่นี่
                    Image.asset(
                      'assets/images/logo_wel.png',
                      height: 200,  // กำหนดขนาดความสูง
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome to\n Learn Hub CMRU\n',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF262626),
                            ),
                          ),
                          TextSpan(
                            text: '\n Please Sign in with your CMRU Google account.\n(xxxxxxxx@g.cmru.ac.th)',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF262626),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SigninScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
