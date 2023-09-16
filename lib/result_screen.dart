import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/quiz_model.dart';

class ResultScreen extends StatelessWidget {
  int totalR;
  ResultScreen({super.key, required this.totalR});

  QuizModel quizModel = QuizModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3C5FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text('Result'),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent.shade700,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
      ),
      body: totalR >= 6 ?
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Lottie.asset(
                  "animations/congratsboom.json",
                  height: 180,
                  repeat: true,
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        "animations/congratulations.json",
                        height: 180,
                        repeat: true,
                        reverse: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text('Congratulations',style: GoogleFonts.tiroGurmukhi(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 20)),
                    Text('You have Scored $totalR out of ${quizModel.quizData.length}!', style: GoogleFonts.tiroGurmukhi(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 22)),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          :
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(height: MediaQuery.sizeOf(context).height * 0.24,),
                Center(
                  child: Lottie.asset(
                    "animations/sadlywalking.json",
                    height: 220,
                    repeat: true,
                  ),
                ),
                // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                Text('Better Luck next time!',style: GoogleFonts.tiroGurmukhi(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 20)),
                Text('You have Scored $totalR out of ${quizModel.quizData.length}!', style: GoogleFonts.tiroGurmukhi(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 22)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
