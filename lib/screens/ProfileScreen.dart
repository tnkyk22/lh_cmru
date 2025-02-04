import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lh_cmru/screens/SigninScreen.dart';
import 'package:lh_cmru/widgets/BottomBar.dart';
import 'package:lh_cmru/widgets/ProfileMenu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage('assets/images/profile.jpg'),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[300],
                      ),
                      child: const Icon(Icons.camera_alt_rounded,
                          size: 20, color: Colors.grey),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text('#U0001',
                  style: GoogleFonts.urbanist(
                      fontSize: 16, color: Colors.grey[500])),
              Text(
                'Tanakorn Yodkham',
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xFF262626),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 160,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfffcdf59),
                  ),
                  child: Text(
                    'My Documents',
                    style: GoogleFonts.pragatiNarrow(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: const Color(0xFF262626),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              //Menu
              ProfileMenu(
                title: 'Tanakorn Yodkham',
                icon: Icons.face_outlined,
                onPressed: () {
                  print('Name');
                },
              ),
              ProfileMenu(
                title: 'xxxxxxxxx@g.cmru.ac.th',
                icon: Icons.email_outlined,
                onPressed: () {
                  print('Email');
                },
              ),
              ProfileMenu(
                title: 'Password',
                icon: Icons.password_rounded,
                onPressed: () {
                  print('Password');
                },
              ),
              ProfileMenu(
                title: 'Faculty',
                icon: Icons.emoji_flags_rounded,
                onPressed: () {
                  print('Faculty');
                },
              ),
              ProfileMenu(
                title: 'Department',
                icon: Icons.hub_outlined,
                onPressed: () {
                  print('Department');
                },
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 12),
              ProfileMenu(
                title: 'SIGN OUT',
                icon: Icons.exit_to_app_rounded,
                textColor: Colors.amber,
                endIcon: false,
                onPressed: () {
                  // แสดง Popup Dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Confirm Sign out",
                          style: GoogleFonts.urbanist(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        content:
                            Text("Are you sure you want to sign out?",
                            style: GoogleFonts.pragatiNarrow(
                              fontSize: 16,
                              color: const Color(0xFF262626),
                            ),),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // ปิด Popup เมื่อกด Cancel
                            },
                            child: Text(
                              "CANCEL",
                              style: GoogleFonts.urbanist(
                                color: const Color(0xFF262626),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // ปิด Popup
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninScreen(),
                                ),
                              ); // ไปหน้าลงชื่อเข้าใช้
                            },
                            child: Text(
                              "SIGN OUT",
                              style: GoogleFonts.urbanist(
                                color: const Color(0xFF262626),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xfffcdf59), // สีปุ่ม Sign Out
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
