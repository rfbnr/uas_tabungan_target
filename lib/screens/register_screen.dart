// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.greenAccent,
//         title: const Text(
//           'DAFTAR AKUN',
//           textAlign: TextAlign.center,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title
//               Text(
//                 'Silahkan Daftar',
//                 style: GoogleFonts.plusJakartaSans(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green[800],
//                 ),
//               ),
//               const SizedBox(height: 5),
//               // Subtitle
//               Text(
//                 'Silahkan lengkapi data diri di bawah ini!',
//                 style: GoogleFonts.plusJakartaSans(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Nama Lengkap
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Nama Lengkap',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   TextField(
//                     showCursor: true,
//                     cursorColor: Colors.pink,
//                     decoration: InputDecoration(
//                       hintText: 'Masukkan nama lengkap',
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                       hintStyle: TextStyle(
//                         color: Colors.grey[500],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               // Email
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Email',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   TextField(
//                     showCursor: true,
//                     cursorColor: Colors.pink,
//                     decoration: InputDecoration(
//                       hintText: 'Masukkan email',
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                       hintStyle: TextStyle(
//                         color: Colors.grey[500],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               // Password
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Password',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   TextField(
//                     showCursor: true,
//                     cursorColor: Colors.pink,
//                     obscureText: !_isPasswordVisible,
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         },
//                       ),
//                       hintStyle: TextStyle(
//                         color: Colors.grey[500],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               // Konfirmasi Password
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Konfirmasi Password',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   TextField(
//                     showCursor: true,
//                     cursorColor: Colors.pink,
//                     obscureText: !_isConfirmPasswordVisible,
//                     decoration: InputDecoration(
//                       hintText: 'Konfirmasi Password',
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isConfirmPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isConfirmPasswordVisible =
//                                 !_isConfirmPasswordVisible;
//                           });
//                         },
//                       ),
//                       hintStyle: TextStyle(
//                         color: Colors.grey[500],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               // Tombol Daftar
//               Center(
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Tambahkan logika registrasi di sini
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pinkAccent,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Text(
//                       'Daftar',
//                       style: GoogleFonts.plusJakartaSans(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
