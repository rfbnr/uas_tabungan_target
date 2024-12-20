// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:uas_tabungantarget/screens/login_screen.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Set status bar style to light
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

//     // Navigate to LoginScreen after 5 seconds
//     Future.delayed(const Duration(seconds: 5)).then((value) {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//         (route) => false,
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.greenAccent,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Logo Image
//             Image.asset(
//               'assets/images/logo.png',
//               width: 100,
//               height: 100,
//             ),
//             const SizedBox(height: 20),

//             Text(
//               "TABUNGAN TARGET",
//               style: GoogleFonts.plusJakartaSans(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
