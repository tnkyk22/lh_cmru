import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lh_cmru/screens/WelcomeScreen.dart';
import 'package:lh_cmru/services/api_service.dart';
import 'package:lh_cmru/services/share_pref_service.dart';
import 'package:lh_cmru/widgets/BottomBar.dart';
import 'package:lh_cmru/widgets/ProfileMenu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiService apiService = ApiService();
  SharePrefService sharePrefService = SharePrefService();
  Map<String, dynamic> profile = {};

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  Future<void> getProfile() async {
    try {
      final res = await apiService.get('/users/me');
      setState(() {
        profile = res.data;
      });
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _changePassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    try {
      if (_newPasswordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')),
        );
        return;
      }
      await apiService.changePassword(
        _newPasswordController.text,
      );
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
      Navigator.pop(context); // Close the dialog
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to change password: $e')),
      );
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

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
              Text(
                profile['UserName'] ?? 'Name',
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
                title: profile['UserName'] ?? 'Name',
                icon: Icons.face_outlined,
                onPressed: () {
                  print('Name');
                },
              ),
              ProfileMenu(
                title: profile['Email'] ?? 'Email',
                icon: Icons.email_outlined,
                onPressed: () {
                  print('Email');
                },
              ),
              ProfileMenu(
                title: 'Password',
                icon: Icons.password_rounded,
                onPressed: () {
                  // change password dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Change Password",
                          style: GoogleFonts.urbanist(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _newPasswordController,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                labelStyle: GoogleFonts.pragatiNarrow(
                                  color: const Color(0xFF262626),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: GoogleFonts.pragatiNarrow(
                                  color: const Color(0xFF262626),
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
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
                              _changePassword();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xfffcdf59), // สีปุ่ม Sign Out
                            ),
                            child: Text(
                              "CHANGE",
                              style: GoogleFonts.urbanist(
                                color: const Color(0xFF262626),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ProfileMenu(
                title: profile['Faculty']?['Name'] ?? 'Faculty',
                icon: Icons.emoji_flags_rounded,
                onPressed: () {
                  print('Faculty');
                },
              ),
              ProfileMenu(
                title: profile['Department']?['Name'] ?? 'Department',
                icon: Icons.hub_outlined,
                onPressed: () {
                  print('Department');
                },
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 12),
              SizedBox(
                width: 160,
                child: ElevatedButton(
                  onPressed: () async {
                    await sharePrefService.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfffcdf59),
                  ),
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.pragatiNarrow(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: const Color(0xFF262626),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
