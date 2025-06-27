import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tripiz_app/common/components/custom_button.dart';
import 'package:tripiz_app/common/components/custom_input_field.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/database/secure_storage_service.dart';
import 'package:tripiz_app/common/dio/dio_client.dart';
// import 'package:tripiz_app/common/models/user.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final DioClient _dioClient = DioClient.instance;

  void _performLogin() async {
    setState(() {
      _isLoading = true;
    });
    final String email = _emailController.value.text;
    final String password = _passwordController.value.text;
    try {
      final response = await _dioClient.dio.post(
        "/authenticate/login",
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        final data = response.data;

        // final secureStorage = SecureStorageService();
        // User user = User.fromJson(data["user"]);
        // await secureStorage.saveUsername(user.username!);
        // await secureStorage.saveUserId(user.id!);
        // await secureStorage.saveToken(data["token"]);
      }
    } catch (e) {
      throw Exception("erreur lors de la connexion : ${e.toString()}");
    }
    setState(() {
      _isLoading = false;
    });
    context.go("/app");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            hintText: "Enter Email",
            hintStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          CustomInputField(
            obscureText: true,
            hintText: "Enter Password",
            hintStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
            keyboardType: TextInputType.emailAddress,
            controller: _passwordController,
          ),
          const SizedBox(height: 20),
          CustomButton(
            isLoading: _isLoading,
            onPressed: () {
              _performLogin();
            },
            width: double.infinity,
            text: "Login",
            gradient: const LinearGradient(
              colors: [AppColors.red, AppColors.primary],
            ),
          ),
        ],
      ),
    );
  }
}
