import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_tabungantarget/src/core/extension/int_currency_ext.dart';
import 'package:uas_tabungantarget/src/core/extension/string_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/variables.dart';
import '../../../data/datasources/saving_remote_datasource.dart';
import '../../../data/models/response/savings_response_model.dart';
import '../../profile/profile_screen.dart';
import '../../saving/bloc/saving_bloc.dart';
import '../../saving/screens/achieved_saving_screen.dart';
import '../../saving/screens/create_saving_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavingBloc(
        savingRemoteDatasource: SavingRemoteDatasource(),
      )..add(
          const SavingLoadByStatus(status: "berlangsung"),
        ),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with image and decoration
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: Colors.greenAccent,
                ),
                child: SafeArea(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Menu title
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Profile',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Menu buttons (Tercapai and Tambahkan)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AchievedSavingScreen(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/tercapai.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tercapai',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 80,
                              color: Colors.greenAccent,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateSavingScreen(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/tambah.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tambahkan',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // "Sedang Berlangsung" section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Text(
                  'Sedang Berlangsung',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Card for ongoing item
              BlocConsumer<SavingBloc, SavingState>(
                listener: (context, state) {
                  if (state.updateStatus == UpdateStatus.success) {
                    final message = state.result?.message ?? "Success";

                    EasyLoading.dismiss();
                    EasyLoading.showSuccess(
                      message,
                      duration: const Duration(seconds: 4),
                    );

                    context.read<SavingBloc>().add(
                          const SavingLoadByStatus(status: "berlangsung"),
                        );
                  } else if (state.updateStatus == UpdateStatus.failure) {
                    final message = state.error?.message ?? "An error occured";

                    EasyLoading.dismiss();
                    EasyLoading.showError(
                      message,
                      duration: const Duration(seconds: 4),
                    );
                  } else if (state.updateStatus == UpdateStatus.loading) {
                    Navigator.pop(context);

                    EasyLoading.dismiss();
                    EasyLoading.show(
                      status: 'loading...',
                      dismissOnTap: false,
                      maskType: EasyLoadingMaskType.black,
                    );
                  }
                },
                builder: (context, state) {
                  switch (state.status) {
                    case SavingStatus.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case SavingStatus.failure:
                      final message =
                          state.error?.message ?? "An error occured";
                      return Center(
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      );

                    case SavingStatus.success:
                      final datas = state.savings;

                      return datas.isEmpty
                          ? const Center(
                              child: Text(
                                "Tiada data tabungan",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: datas.length,
                              padding: EdgeInsets.zero,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SpaceHeight(6);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final data = datas[index];

                                return SavingOngoingCardWidget(
                                  data: data,
                                );
                              },
                            );

                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SavingOngoingCardWidget extends StatelessWidget {
  const SavingOngoingCardWidget({
    super.key,
    required this.data,
  });

  final SavingsResultResponseModel data;

  @override
  Widget build(BuildContext context) {
    final formatterFrequency = data.savingFrequency == "harian"
        ? "Perhari"
        : data.savingFrequency == "mingguan"
            ? "Perminggu"
            : "Perbulan";

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.greenAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column for text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data.targetAmount?.currencyFormatRp ?? "Rp 0",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            data.nominalPerFrequency?.currencyFormatRp ??
                                "Rp 0",
                          ),
                          const SizedBox(width: 5),
                          Text(
                            formatterFrequency,
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 1,
                        endIndent: 150,
                      ),
                      Row(
                        children: [
                          const Text('Estimasi :'),
                          const SizedBox(width: 5),
                          Text(
                            "${data.remainingDays ?? "-"}",
                          ),
                          const SizedBox(width: 5),
                          const Text('Hari Lagi'),
                        ],
                      ),
                    ],
                  ),
                ),
                // Right grey container
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "${Variables.imageBaseUrl}${data.image}",
                    width: 150,
                    height: 130,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
            const SpaceHeight(10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Terkumpul"),
                      Text(
                        data.currentSavings?.currencyFormatRp ?? "Rp 0",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Kurang"),
                      Text(
                        data.remainingAmount?.currencyFormatRp ?? "Rp 0",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SpaceHeight(20),
            Button.filled(
              height: 40,
              label: "Tabung Sekarang",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext _) {
                    TextEditingController nominalController =
                        TextEditingController();

                    return BlocProvider.value(
                      value: BlocProvider.of<SavingBloc>(
                        context,
                      ),
                      child: AlertDialog(
                        title: const Text("Tambah Nominal"),
                        content: TextField(
                          controller: nominalController,
                          onChanged: (value) {
                            final int totalPriceValue = value.toIntegerFromText;

                            nominalController.text =
                                totalPriceValue.currencyFormatRp;
                            nominalController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                offset: nominalController.text.length,
                              ),
                            );
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Masukkan nominal tabungan",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Batal"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              context.read<SavingBloc>().add(
                                    SavingUpdateAmount(
                                      id: data.id ?? 0,
                                      amount: nominalController
                                          .text.toIntegerFromText,
                                    ),
                                  );
                            },
                            child: const Text(
                              "Simpan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
