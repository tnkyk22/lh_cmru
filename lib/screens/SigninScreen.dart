import 'package:flutter/material.dart';
import 'package:lh_cmru/screens/ForgetPassword.dart';
import 'package:lh_cmru/widgets/CustomScaffold.dart';
import 'package:lh_cmru/screens/HomeScreen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_signin.png',
                width: 450,
                height: 192,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 50, 25, 50),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAF3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formSignInKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: const Text(
                                  'Hello,',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Color(0xFFFFCC04),
                                  ),
                                ),
                              ), // ระยะห่างระหว่างกล่อง
                              Container(
                                child: const Text(
                                  'welcome!',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF262626),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter Email',
                              labelStyle: const TextStyle(color: Color(0xFF262626)),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFFFFCC04)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFFFFCC04)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFFFFCC04)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Color(0xFF262626)),
                              hintText: 'Enter Password',
                              hintStyle: const TextStyle(
                                color: Colors.black26,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFFFFCC04)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFFFFCC04)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFFFFCC04)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPassword = value ?? false;
                                      });
                                    },
                                    activeColor: const Color(0xFFFED326),
                                  ),
                                  const Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Color(0xFF262626),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPasswordScreen()),
                                  );
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    color: Color(0xFFFFCC04),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFCC04),
                                foregroundColor: const Color(0xFF262626),
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)
                              ),
                              onPressed: () {
                                if (_formSignInKey.currentState!.validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomeScreen()),
                                  );
                                } else if (!rememberPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Center(
                                        child: Text(
                                            'Please agree to the processing of personal data.',
                                            style: TextStyle(
                                              color: Color(0xFFFFCC04)
                                            )),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
