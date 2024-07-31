import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true, bottom: false, left: true, right: true,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                effects: [FadeEffect(duration: 1300.ms)],
                child: const Text("Welcome!", style: TextStyle(fontFamily: "Poppins", fontSize: 24, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 20),

              Container(
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
                          // color: FitrahColor.darkBlue,
                          ),
                          child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.home);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage()));
                          },
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.green,
                          ),
                        ),
                        // child: MaterialButton(
                        //   child: BoxDecoration(
                        //     gradient: myGradient,
                        //     borderRadius: const BorderRadius.all(Radius.circular(80.0))
                        //   ),
                        //   onPressed: () => Navigator.pushNamed(context, AppRoutes.home))
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  } 
}