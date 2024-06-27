import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compass_test/controllers/compass_controller.dart';
import 'package:provider/provider.dart';
import 'package:sprung/sprung.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompassController compassController =
        context.watch<CompassController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.0,
            colors: [
              Color.fromARGB(255, 125, 205, 234),
              Color.fromARGB(255, 79, 143, 240),
            ],
          ),
        ),
        child: SizedBox.expand(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background
              Image.asset(
                'assets/images/bg.png',
                height: screenHeight,
                width: screenWidth,
                opacity: const AlwaysStoppedAnimation(0.1),
              ),
              // Compass Dial Background
              Image.asset(
                'assets/images/dial.png',
                height: screenHeight,
                width: screenWidth,
              ),
              // Compass Dial (Ticks)
              AnimatedRotation(
                duration: const Duration(milliseconds: 1000),
                curve: Sprung.criticallyDamped,
                turns: -(compassController.compassHeading ?? 0) / 360,
                child: Image.asset(
                  'assets/images/ticks.png',
                  height: screenHeight,
                  width: screenWidth,
                ),
              ),
              // Compass Dial (Pointer)
              Image.asset(
                'assets/images/pointer.png',
                height: screenHeight,
                width: screenWidth,
              ),
              // Compass Display (Text)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      '${compassController.compassHeading?.round()}°',
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                    Text(
                      '${compassController.compassDirection}',
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xCC4C4C4C),
                      ),
                    ),
                  ],
                ),
              ),
              // Compass Display (Inner Shadow)
              Image.asset(
                'assets/images/shadow.png',
                height: screenHeight,
                width: screenWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
