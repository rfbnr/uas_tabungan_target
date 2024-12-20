import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/bloc/auth_bloc.dart';
import '../auth/screens/login_screen.dart';
import '../home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          Timer(const Duration(seconds: 4), () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }), (route) => false);
          });
        } else if (state.status == AuthStatus.failure) {
          Timer(const Duration(seconds: 4), () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }), (route) => false);
          });
        }
        // else {
        //   Timer(const Duration(seconds: 4), () {
        //     Navigator.pushAndRemoveUntil(context,
        //         MaterialPageRoute(builder: (context) {
        //       return const LoginScreen();
        //     }), (route) => false);
        //   });
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo Image
              Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                "TABUNGAN TARGET",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
