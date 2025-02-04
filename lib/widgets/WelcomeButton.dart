import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key, this.buttonText, this.onTap});

  final String? buttonText;
  final Widget? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (e)=> onTap!));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAF3),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child:  Text(
          buttonText!,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF262626)),
        ),
      ),
    );
  }
}
