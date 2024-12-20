import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/request/register_request_model.dart';
import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'DAFTAR AKUN',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Silahkan Daftar',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 5),
              // Subtitle
              Text(
                'Silahkan lengkapi data diri di bawah ini!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              // Nama Lengkap
              CustomTextField(
                controller: namaController,
                label: "Nama Lengkap",
                fillColor: Colors.grey[100]!,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              // Email
              CustomTextField(
                controller: emailController,
                label: "Email",
                fillColor: Colors.grey[100]!,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              // Password
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final showPassword = state.showPassword;

                  return CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    fillColor: Colors.grey[100]!,
                    obscureText: showPassword!,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.grey,
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              VisibilityPassword(showPassword),
                            );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              // Konfirmasi Password
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final showPassword = state.showConfirmPassword;

                  return CustomTextField(
                    controller: confirmPasswordController,
                    label: "Konfirmasi Password",
                    fillColor: Colors.grey[100]!,
                    obscureText: showPassword!,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.grey,
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              VisibilityConfirmPassword(showPassword),
                            );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              // Tombol Daftar
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.registerStatus == RegisterStatus.loading) {
                    EasyLoading.dismiss();
                    EasyLoading.show(
                      status: "loading...",
                      dismissOnTap: false,
                      maskType: EasyLoadingMaskType.black,
                    );
                  } else if (state.registerStatus == RegisterStatus.success) {
                    final message =
                        state.dataLogin?.message ?? "Berhasil Registrasi";

                    EasyLoading.dismiss();
                    EasyLoading.showSuccess(message);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }),
                      (route) => false,
                    );
                  } else if (state.registerStatus == RegisterStatus.failure) {
                    final error = state.error?.message ?? "Terjadi Kesalahan";

                    EasyLoading.dismiss();
                    EasyLoading.showError(
                      error,
                      duration: const Duration(seconds: 4),
                    );
                  }
                },
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final nama = namaController.text;
                        final password = passwordController.text;
                        final confirmPassword = confirmPasswordController.text;

                        if (email.isEmpty ||
                            nama.isEmpty ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          EasyLoading.showError("Data tidak boleh kosong");
                          return;
                        }

                        if (password != confirmPassword) {
                          EasyLoading.showError("Password tidak sama");
                          return;
                        }

                        final body = RegisterRequestModel(
                          email: email,
                          password: password,
                          name: nama,
                        );

                        context.read<AuthBloc>().add(
                              UserRegister(
                                bodyRequestRegister: body,
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
                        'Daftar',
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
            ],
          ),
        ),
      ),
    );
  }
}
