// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:uas_tabungantarget/screens/home_screen.dart';
// import 'package:uas_tabungantarget/screens/register_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.greenAccent,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
//           child: Column(
//             children: [
//               // Logo
//               Image.asset(
//                 'assets/images/logo.png',
//                 width: double.infinity,
//                 height: 100,
//               ),
//               const SizedBox(height: 24),

//               // Title
//               Text(
//                 'TABUNGAN TARGET',
//                 style: GoogleFonts.plusJakartaSans(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black54,
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Sign In Text
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Sign In',
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // Instruction Text
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Silahkan masukan Email dan Password!',
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Email Label
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Email',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),

//               // Email Input Field
//               TextField(
//                 showCursor: true,
//                 cursorColor: Colors.pinkAccent,
//                 decoration: InputDecoration(
//                   hintText: 'Email',
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide.none,
//                   ),
//                   hintStyle: TextStyle(
//                     color: Colors.grey[500],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 14),

//               // Password Label
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Password',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),

//               // Password Input Field
//               TextField(
//                 showCursor: true,
//                 cursorColor: Colors.pinkAccent,
//                 obscureText: !_isPasswordVisible,
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide.none,
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isPasswordVisible = !_isPasswordVisible;
//                       });
//                     },
//                   ),
//                   hintStyle: TextStyle(
//                     color: Colors.grey[500],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   'Lupa Password?',
//                   style: GoogleFonts.plusJakartaSans(
//                       fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const HomeScreen()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pinkAccent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     elevation: 5,
//                   ),
//                   child: Text(
//                     'LOGIN',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Belum punya akun?',
//                     style: GoogleFonts.plusJakartaSans(
//                         fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const RegisterScreen()));
//                     },
//                     child: const Text(
//                       'Daftar Sekarang',
//                       style: TextStyle(
//                         color: Colors.pink,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
