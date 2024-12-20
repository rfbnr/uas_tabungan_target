import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/components/spaces.dart';
import '../../core/constants/colors.dart';
import '../auth/bloc/auth_bloc.dart';
import '../auth/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetUserLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile Saya",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpaceHeight(40),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.grey.withOpacity(0.6),
                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: AppColors.white,
                ),
              ),
            ),
            const SpaceHeight(60),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.grey2.withOpacity(0.4),
                borderRadius: BorderRadius.circular(18),
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  switch (state.status) {
                    case AuthStatus.failure:
                      // final error = state.error!;

                      return const Column(
                        children: [
                          DetailDataAccountWidget(
                            title: "Nama",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataAccountWidget(
                            title: "Email",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataAccountWidget(
                            title: "Nomor Handphone",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataAccountWidget(
                            title: "Nomor Polisi",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataAccountWidget(
                            title: "Role Akun",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                        ],
                      );

                    case AuthStatus.success:
                      final data = state.dataLogin!.data!.user!;

                      return Column(
                        children: [
                          DetailDataAccountWidget(
                            title: "Nama",
                            value: data.name ?? "-",
                          ),
                          const SpaceHeight(10),
                          DetailDataAccountWidget(
                            title: "Email",
                            value: data.email ?? "-",
                          ),
                          const SpaceHeight(10),
                        ],
                      );

                    default:
                      return const Column(
                        children: [
                          DetailDataAccountWidget(
                            title: "Nama",
                            value: "loading...",
                          ),
                          SpaceHeight(10),
                          DetailDataAccountWidget(
                            title: "Email",
                            value: "loading...",
                          ),
                          SpaceHeight(10),
                        ],
                      );
                  }
                },
              ),
            ),
            const SpaceHeight(40),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.logoutStatus == LogoutStatus.loading) {
                  EasyLoading.dismiss();
                  EasyLoading.show(
                    status: "loading...",
                    dismissOnTap: false,
                    maskType: EasyLoadingMaskType.black,
                  );
                } else if (state.logoutStatus == LogoutStatus.success) {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess("Berhasil Logout");

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }),
                    (route) => false,
                  );
                } else if (state.logoutStatus == LogoutStatus.failure) {
                  final error = state.error!;
                  EasyLoading.dismiss();
                  EasyLoading.showError(error.message!);
                }
              },
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(UserLogout());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DetailDataAccountWidget extends StatelessWidget {
  const DetailDataAccountWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
