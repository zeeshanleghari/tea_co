import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_co/Screen/splash_screen.dart';

Future<void> main() async {

  await Supabase.initialize(
    url: 'https://idstlgqiychntfalgruh.supabase.co',
    anonKey: 'sb_publishable_6gKXWsoCm8D5CCUbYIpORg_PJcYzjAT',
  );
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
