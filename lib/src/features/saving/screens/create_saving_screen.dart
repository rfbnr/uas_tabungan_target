import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uas_tabungantarget/src/core/extension/int_currency_ext.dart';
import 'package:uas_tabungantarget/src/core/extension/string_currency_ext.dart';

import '../../../core/components/custom_text_field.dart';
import '../../../core/components/image_picker.dart';
import '../../../core/components/spaces.dart';
import '../../../data/datasources/saving_remote_datasource.dart';
import '../../../data/models/request/saving_request_model.dart';
import '../../home/screens/home_screen.dart';
import '../bloc/saving_bloc.dart';

class CreateSavingScreen extends StatelessWidget {
  const CreateSavingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavingBloc(
        savingRemoteDatasource: SavingRemoteDatasource(),
      ),
      child: const CreateSavingScreenView(),
    );
  }
}

class CreateSavingScreenView extends StatefulWidget {
  const CreateSavingScreenView({super.key});

  @override
  State<CreateSavingScreenView> createState() => _CreateSavingScreenViewState();
}

class _CreateSavingScreenViewState extends State<CreateSavingScreenView> {
  final nameController = TextEditingController();
  final targetController = TextEditingController();
  final nominalTabunganController = TextEditingController();

  XFile? imageFile;

  String selectedOption = "harian";

  String startDateSend = "";
  String endDateSend = "";

  String startDateView = "";
  String endDateView = "";

  @override
  void dispose() {
    nameController.dispose();
    targetController.dispose();
    nominalTabunganController.dispose();
    imageFile;
    super.dispose();
  }

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
                  if (file == null) {
                    return;
                  }

                  imageFile = file;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                controller: nameController,
                fillColor: Colors.white,
                label: "Nama Tabungan",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.list_alt),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: targetController,
                fillColor: Colors.white,
                label: "Target Tabungan",
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.track_changes),
                onChanged: (value) {
                  final int totalPriceValue = value.toIntegerFromText;

                  targetController.text = totalPriceValue.currencyFormatRp;
                  targetController.selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: targetController.text.length,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Text(
                    'Rencana Pengisian',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Center(
                child: ToggleButtons(
                  isSelected: [
                    selectedOption == "harian",
                    selectedOption == "mingguan",
                    selectedOption == "bulanan",
                  ],
                  onPressed: (index) {
                    setState(() {
                      selectedOption = index == 0
                          ? "harian"
                          : index == 1
                              ? "mingguan"
                              : "bulanan";
                    });
                  },
                  borderRadius: BorderRadius.circular(15),
                  selectedColor: Colors.white,
                  fillColor: Colors.greenAccent,
                  color: Colors.grey,
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 50),
                  children: [
                    Text(
                      'Harian',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Mingguan',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Bulanan',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: nominalTabunganController,
                fillColor: Colors.white,
                label: "Nominal Menabung",
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.attach_money),
                onChanged: (value) {
                  final int totalPriceValue = value.toIntegerFromText;

                  nominalTabunganController.text =
                      totalPriceValue.currencyFormatRp;
                  nominalTabunganController.selection =
                      TextSelection.fromPosition(
                    TextPosition(
                      offset: nominalTabunganController.text.length,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tanggal Mulai",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(12.0),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ).then(
                        (value) {
                          String formattedDateSend =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .format(value!);
                          String formattedDateView =
                              DateFormat('dd MMMM yyyy').format(value);

                          setState(() {
                            startDateSend = formattedDateSend;
                            startDateView = formattedDateView;
                          });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.today,
                            size: 20,
                            color: Colors.black54,
                          ),
                          const SpaceWidth(10),
                          Text(
                            startDateView.isEmpty
                                ? 'Tanggal Mulai'
                                : startDateView,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tanggal Berakhir",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(12.0),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ).then(
                        (value) {
                          String formattedDateSend =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .format(value!);
                          String formattedDateView =
                              DateFormat('dd MMMM yyyy').format(value);

                          setState(() {
                            endDateSend = formattedDateSend;
                            endDateView = formattedDateView;
                          });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.event,
                            size: 20,
                            color: Colors.black54,
                          ),
                          const SpaceWidth(10),
                          Text(
                            endDateView.isEmpty
                                ? 'Tanggal Berakhir'
                                : endDateView,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SpaceHeight(40),
              BlocListener<SavingBloc, SavingState>(
                listener: (context, state) {
                  if (state.status == SavingStatus.loading) {
                    EasyLoading.dismiss();
                    EasyLoading.show(
                      status: "loading...",
                      dismissOnTap: false,
                      maskType: EasyLoadingMaskType.black,
                    );
                  } else if (state.status == SavingStatus.success) {
                    final message =
                        state.result?.message ?? "Tabungan berhasil dibuat";

                    EasyLoading.dismiss();
                    EasyLoading.showSuccess(message);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }),
                      (route) => false,
                    );
                  } else if (state.status == SavingStatus.failure) {
                    final error = state.error?.message ?? "Terjadi Kesalahan";
                    EasyLoading.dismiss();
                    EasyLoading.showError(error);
                  }
                },
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameController.text;
                        final target = targetController.text;
                        final nominalTabungan = nominalTabunganController.text;

                        if (imageFile == null) {
                          EasyLoading.showError("Foto Tabungan harus diisi");
                          return;
                        }

                        if (name.isEmpty ||
                            target.isEmpty ||
                            nominalTabungan.isEmpty ||
                            startDateSend.isEmpty ||
                            endDateSend.isEmpty) {
                          EasyLoading.showError("Semua field harus diisi");
                          return;
                        }

                        context.read<SavingBloc>().add(
                              SavingCreateData(
                                body: SavingRequestModel(
                                  name: name,
                                  targetAmount: target.toIntegerFromText,
                                  nominalPerFrequency:
                                      nominalTabungan.toIntegerFromText,
                                  savingFrequency: selectedOption,
                                  startDate: startDateSend,
                                  endDate: endDateSend,
                                  image: imageFile,
                                ),
                              ),
                            );
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
              ),
              const SpaceHeight(90),
            ],
          ),
        ),
      ),
    );
  }
}
