// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:uas_tabungantarget/screens/tambah_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minHeight: MediaQuery.of(context).size.height,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header with image and decoration
//               Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/logo.png'),
//                     fit: BoxFit.contain,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                   color: Colors.greenAccent,
//                 ),
//               ),
//               const SizedBox(height: 15),

//               // Menu title
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
//                 child: Text(
//                   'Menu',
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 14),

//               // Menu buttons (Tercapai and Tambahkan)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 14),
//                 child: SizedBox(
//                   height: 120,
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.pink.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                           color: Colors.white,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 print('ke halaman Tercapai');
//                               },
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/tercapai.png',
//                                     width: 70,
//                                     height: 70,
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     'Tercapai',
//                                     style: GoogleFonts.plusJakartaSans(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 2,
//                               height: 80,
//                               color: Colors.greenAccent,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => TambahScreen()));
//                               },
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/tambah.png',
//                                     width: 70,
//                                     height: 70,
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     'Tambahkan',
//                                     style: GoogleFonts.plusJakartaSans(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // "Sedang Berlangsung" section
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//                 child: Text(
//                   'Sedang Berlangsung',
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 14),

//               // Card for ongoing item
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: Container(
//                   width: double.infinity,
//                   height: 220,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.greenAccent,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Column for text content
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Iphone X',
//                                 style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 'Rp. 5.000.000',
//                                 style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   Text('Rp. 100.000'),
//                                   const SizedBox(width: 5),
//                                   Text('Perhari')
//                                 ],
//                               ),
//                               const Divider(
//                                 color: Colors.grey,
//                                 thickness: 2,
//                                 indent: 1,
//                                 endIndent: 150,
//                               ),
//                               Row(
//                                 children: [
//                                   Text('Estimasi :'),
//                                   const SizedBox(width: 5),
//                                   Text('300 Hari Lagi')
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Right grey container
//                         Container(
//                           width: 150,
//                           height: 130,
//                           decoration: BoxDecoration(
//                             color: Colors.grey, // Grey color
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       // Floating action button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               TextEditingController nominalController = TextEditingController();
//               return AlertDialog(
//                 title: Text("Tambah Nominal"),
//                 content: TextField(
//                   controller: nominalController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: "Masukkan nominal tabungan",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close dialog
//                     },
//                     child: Text("Batal"),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       print("Nominal Tersimpan: ${nominalController.text}");
//                       Navigator.of(context).pop(); // Close dialog
//                     },
//                     child: Text(
//                       "Simpan",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
