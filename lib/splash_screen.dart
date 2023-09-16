import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3C5FF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
            Center(child: Text('QUIZ APP', style: GoogleFonts.merriweather(color: Colors.purpleAccent.shade700, fontSize: 50, fontWeight: FontWeight.bold),)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              child: Divider(color: Colors.purpleAccent.shade700, thickness: 5),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
            Lottie.asset(
              "animations/quiz.json",
              height: 300,
              repeat: true
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent.shade700,
                minimumSize: const Size(280, 50),
              ),
                onPressed: (){
                  Navigator.push(context, PageTransition(child: const HomeScreen(), type: PageTransitionType.rightToLeft));
                },
                child: const Text("Let's start!")
            )

          ],
        ),
      ),
    );
  }
}
