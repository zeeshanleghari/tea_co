import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tea_co/Screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      body: Stack(
        children: [
          // Top Right Radial Background Accent
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primaryColor.withOpacity(0.15),
                    primaryColor.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 800.ms),

          // Bottom Left Radial Background Accent
          Positioned(
            bottom: 50,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primaryColor.withOpacity(0.12),
                    primaryColor.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 800.ms),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Brand Tag Header
                  Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          "TEA CO.",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.5,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: -0.5, end: 0, curve: Curves.easeOut),

                  const Spacer(),

                  // Animated Center Hero Image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                            width: 270,
                            height: 270,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryColor.withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                          )
                          .animate()
                          .scale(
                            duration: 700.ms,
                            begin: const Offset(0.7, 0.7),
                            curve: Curves.easeOutBack,
                          )
                          .fadeIn(duration: 600.ms),

                      Container(
                            width: 235,
                            height: 235,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(0.05),
                            ),
                          )
                          .animate()
                          .scale(
                            delay: 100.ms,
                            duration: 700.ms,
                            begin: const Offset(0.7, 0.7),
                            curve: Curves.easeOutBack,
                          )
                          .fadeIn(duration: 600.ms),

                      Container(
                            width: 195,
                            height: 195,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.14),
                                  blurRadius: 45,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Image.asset(
                                "lib/assets/coffee.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                          .animate()
                          .scale(
                            delay: 200.ms,
                            duration: 700.ms,
                            begin: const Offset(0.7, 0.7),
                            curve: Curves.easeOutBack,
                          )
                          .fadeIn(duration: 600.ms),
                    ],
                  ),

                  const Spacer(),

                  // Bottom Text and Loader
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 32,
                                height: 1.2,
                                color: Color(0xFF1B262C),
                                fontFamily: 'Roboto',
                              ),
                              children: [
                                TextSpan(
                                  text: "Sip the Fine\n",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                TextSpan(
                                  text: "Organic Blends",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

                      const SizedBox(height: 14),

                      const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Handcrafted organic tea and coffee flavors delivered fresh for your perfect mood.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.6,
                                color: Color(0xFF8D99AE),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            primaryColor.withOpacity(0.6),
                          ),
                        ),
                      ).animate().fadeIn(delay: 700.ms, duration: 500.ms),

                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
