import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/image_picker.dart';

class CreateSavingScreen extends StatefulWidget {
  const CreateSavingScreen({super.key});

  @override
  State<CreateSavingScreen> createState() => _CreateSavingScreenState();
}

class _CreateSavingScreenState extends State<CreateSavingScreen> {
  String selectedOption = "Harian";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Yuk, Mau nabung apa nih ?',
          style: GoogleFonts.plusJakartaSans(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerWidget(
                label: "Foto Tabungan",
                onChanged: (file) {
                  print(file);
                },
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print('tambah gambar dari galeri atau kamera');
                            },
                            child: Image.asset(
                              'assets/images/add.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Nama Tabungan',
                        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: const Icon(Icons.list_alt)),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Target Tabungan',
                        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: const Icon(Icons.track_changes)),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Text(
                    'Rencana Pengisian',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Center(
                child: ToggleButtons(
                  isSelected: [
                    selectedOption == "Harian",
                    selectedOption == "Mingguan"
                  ],
                  onPressed: (index) {
                    setState(() {
                      selectedOption = index == 0 ? "Harian" : "Mingguan";
                    });
                  },
                  borderRadius: BorderRadius.circular(15),
                  selectedColor: Colors.white,
                  fillColor: Colors.greenAccent,
                  color: Colors.grey,
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 50),
                  children: [
                    Text('Harian',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Mingguan',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Nominal Tabungan',
                        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: const Icon(Icons.attach_money)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'SIMPAN TABUNGAN',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
