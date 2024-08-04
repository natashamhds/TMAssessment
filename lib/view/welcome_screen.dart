import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_moving_background/flutter_moving_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tm_assessment/constant/routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildUi();
  }

  Widget buildUi() {
    return MovingBackground(
      circles: const [
        MovingCircle(color: Colors.deepPurpleAccent),
        MovingCircle(color: Colors.deepOrangeAccent),
        MovingCircle(color: Colors.lightBlueAccent),
        MovingCircle(color: Colors.black54),
        ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: true, bottom: false, left: true, right: true,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _text(),
      
                _button()
              ],
            ),
          ),
        ),
      ),
    );
  } 

  Widget _text() {
    return Column(
      children: [
        Animate(
          effects: [FadeEffect(duration: 1300.ms)],
          child: Text("Welcome!", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(height: 10),

          Animate(
          effects: [FadeEffect(duration: 1300.ms)],
          child: Text("By: Nur Natasha", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w500))),
          ),

          const SizedBox(height: 20),
      ],
    );
  }

  Widget _button() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 15,
          color: Colors.black.withOpacity(0.1),
          )),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                  },
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.green,
                  ))));
  }
}