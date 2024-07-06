import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/screens/auth/signin_screen.dart';
import 'package:sleepwell/screens/auth/signup_screen.dart';
import 'package:sleepwell/widget/regsterbutton.dart';

class welcome extends StatelessWidget {
  static String RouteScreen = 'Welcoming_screen';
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromARGB(255, 0, 74, 173);
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004AAD), Color(0xFF040E3B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 250,
                width: double.infinity,
                child: Image(
                  image: AssetImage('assets/logo2.png'),
                ),
              ),
              const Center(
                child: Text(
                  'Welcome to SleepWell',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Get ready to unlock better sleep and wake up refreshed \n \n Let's embark on this journey together!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              regsterbutton(
                color: Color(0xffd5defe),
                title: 'SIGN UP',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                  // );
                   Get.offAll(const SignUpScreen());
                },
              ),
              const SizedBox(
                height: 2,
              ),
              regsterbutton(
                color: Color(0xffd5defe),
                title: 'SIGN IN',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SignInScreen()),
                  // );
                   Get.offAll(const SignInScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
