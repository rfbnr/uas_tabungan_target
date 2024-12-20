import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../../home/screens/home_screen.dart';
import '../bloc/auth_bloc.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
          child: Column(
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png',
                width: double.infinity,
                height: 100,
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'TABUNGAN TARGET',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              // Sign In Text
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Instruction Text
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Silahkan masukan Email dan Password!',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Email Input Field
              CustomTextField(
                controller: emailController,
                label: "Email",
                fillColor: Colors.grey[100]!,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),

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
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Lupa Password?',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.loginStatus == LoginStatus.loading) {
                    EasyLoading.dismiss();
                    EasyLoading.show(
                      status: "loading...",
                      dismissOnTap: false,
                      maskType: EasyLoadingMaskType.black,
                    );
                  } else if (state.loginStatus == LoginStatus.success) {
                    final message =
                        state.dataLogin?.message ?? "Berhasil Login";

                    EasyLoading.dismiss();
                    EasyLoading.showSuccess(message);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }),
                      (route) => false,
                    );
                  } else if (state.loginStatus == LoginStatus.failure) {
                    final error = state.error?.message ?? "Terjadi Kesalahan";
                    EasyLoading.dismiss();
                    EasyLoading.showError(error);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            UserLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar Sekarang',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
