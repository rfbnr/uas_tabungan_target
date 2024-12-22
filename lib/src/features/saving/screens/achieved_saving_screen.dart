import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uas_tabungantarget/src/core/extension/int_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/variables.dart';
import '../../../data/datasources/saving_remote_datasource.dart';
import '../../../data/models/response/savings_response_model.dart';
import '../bloc/saving_bloc.dart';

class AchievedSavingScreen extends StatelessWidget {
  const AchievedSavingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavingBloc(
        savingRemoteDatasource: SavingRemoteDatasource(),
      )..add(const SavingLoadByStatus(status: "tercapai")),
      child: const AchievedSavingScreenView(),
    );
  }
}

class AchievedSavingScreenView extends StatelessWidget {
  const AchievedSavingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabungan Tercapai"),
      ),
      body: BlocBuilder<SavingBloc, SavingState>(
        builder: (context, state) {
          switch (state.status) {
            case SavingStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case SavingStatus.failure:
              final message = state.error?.message ?? "An error occured";
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
                      separatorBuilder: (BuildContext context, int index) {
                        return const SpaceHeight(6);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final data = datas[index];

                        return SavingAchievedCardWidget(
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
    );
  }
}

class SavingAchievedCardWidget extends StatelessWidget {
  const SavingAchievedCardWidget({
    super.key,
    required this.data,
  });

  final SavingsResultResponseModel data;

  @override
  Widget build(BuildContext context) {
    String formattedDateAchieved = DateFormat('dd MMMM yyyy')
        .format(data.targetAchievedDate ?? DateTime.now());

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
            Center(
              child: Text(
                "Selamat Tabungan Anda Telah Tercapai",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 1,
              // endIndent: 150,
            ),
            const SpaceHeight(20),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Target Tabungan"),
                          Text(
                            data.targetAmount?.currencyFormatRp ?? "Rp 0",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Terkumpul",
                          ),
                          const SizedBox(width: 5),
                          Text(
                            data.currentSavings?.currencyFormatRp ?? "Rp 0",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
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
            const SpaceHeight(18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tanggal Tercapai",
                    ),
                    const SizedBox(width: 5),
                    Text(
                      formattedDateAchieved,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                BlocListener<SavingBloc, SavingState>(
                  listener: (context, state) {
                    if (state.updateStatus == UpdateStatus.success) {
                      final message = state.result?.message ?? "Success";

                      EasyLoading.dismiss();
                      EasyLoading.showSuccess(
                        message,
                        duration: const Duration(seconds: 4),
                      );

                      context.read<SavingBloc>().add(
                            const SavingLoadByStatus(status: "tercapai"),
                          );
                    } else if (state.updateStatus == UpdateStatus.failure) {
                      final message =
                          state.error?.message ?? "An error occured";

                      EasyLoading.dismiss();
                      EasyLoading.showError(
                        message,
                        duration: const Duration(seconds: 4),
                      );
                    } else if (state.updateStatus == UpdateStatus.loading) {
                      EasyLoading.dismiss();
                      EasyLoading.show(
                        status: 'loading...',
                        dismissOnTap: false,
                        maskType: EasyLoadingMaskType.black,
                      );
                    }
                  },
                  child: data.isWithdrawn == 1
                      ? Button.outlined(
                          width: MediaQuery.sizeOf(context).width * 0.35,
                          height: 40,
                          label: "Sudah Ditarik",
                          fontSize: 12,
                          onPressed: () {},
                        )
                      : Button.filled(
                          width: MediaQuery.sizeOf(context).width * 0.35,
                          height: 40,
                          label: "Tarik Tabungan",
                          fontSize: 12,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value: BlocProvider.of<SavingBloc>(context),
                                  child: AlertDialog(
                                    title: const Text("Tarik Tabungan"),
                                    content: const Text(
                                      "Apakah Anda yakin ingin menarik tabungan ini?",
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button.outlined(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.28,
                                            height: 35,
                                            label: "Batal",
                                            fontSize: 12,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          Button.filled(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.28,
                                            height: 35,
                                            label: "Tarik",
                                            fontSize: 12,
                                            onPressed: () {
                                              context.read<SavingBloc>().add(
                                                    SavingWithdrawAmount(
                                                      id: data.id ?? 0,
                                                    ),
                                                  );

                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
