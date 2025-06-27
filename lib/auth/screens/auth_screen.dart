import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripiz_app/auth/components/login_form.dart';
import 'package:tripiz_app/auth/components/signup_form.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginScreen = true;

  void _toggleForm() {
    setState(() {
      _isLoginScreen = !_isLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset("assets/images/login-top-banner.svg"),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      !_isLoginScreen
                          ? "Lets subscribe first !"
                          : "Welcome Back !",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: FontSizes.upperExtra,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Affichage conditionnel des formulaires
                    _isLoginScreen ? const LoginForm() : const SignupForm(),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _toggleForm();
                      },
                      child: Text(
                        _isLoginScreen
                            ? "Je n'ai pas encore de compte"
                            : "J'ai déjà un compte",
                        style: const TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
