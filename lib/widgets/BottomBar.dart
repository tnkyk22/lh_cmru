import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lh_cmru/screens/HomeScreen.dart';
import 'package:lh_cmru/screens/ProfileScreen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon:
                    const Icon(Icons.menu_book, color: Colors.amber, size: 35),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              Text(
                'HOME',
                style: GoogleFonts.pragatiNarrow(
                    color: Colors.amber, fontSize: 16),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.assistant_photo_rounded,
                    color: Colors.amber, size: 35),
                onPressed: () {
                  // Handle favorite icon tap
                },
              ),
              Text(
                'REPORT',
                style: GoogleFonts.pragatiNarrow(
                    color: Colors.amber, fontSize: 16),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.face, color: Colors.amber, size: 35),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              Text(
                'ME',
                style: GoogleFonts.pragatiNarrow(
                    color: Colors.amber, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
