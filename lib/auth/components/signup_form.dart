import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tripiz_app/common/components/custom_button.dart';
import 'package:tripiz_app/common/components/custom_input_field.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/database/secure_storage_service.dart';
import 'package:tripiz_app/common/dio/dio_client.dart';
import 'package:tripiz_app/common/models/user.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final DioClient _dioClient = DioClient.instance;

  void _performSignup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _dioClient.dio.post(
        "/authenticate/register",
        data: {
          "firstname": _firstNameController.text,
          "lastname": _lastNameController.text,
          "username": _usernameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "role": "USER",
        },
      );

      if (response.statusCode == 200) {
        context.go("/auth");
      }
    } catch (e) {
      print("Erreur lors de l'inscription : $e");
      // Ajouter une gestion d'erreur visuelle
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            hintText: "Prénom",
            controller: _firstNameController,
            keyboardType: TextInputType.name,
            hintStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          CustomInputField(
            hintText: "Nom",
            controller: _lastNameController,
            keyboardType: TextInputType.name,
            hintStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          CustomInputField(
            hintText: "Nom d'utilisateur",
            controller: _usernameController,
            keyboardType: TextInputType.text,
            hintStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          CustomInputField(
            hintText: "Email",
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          CustomInputField(
            obscureText: true,
            hintText: "Mot de passe",
            controller: _passwordController,
            hintStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            isLoading: _isLoading,
            onPressed: _performSignup,
            width: double.infinity,
            text: "S'inscrire",
            gradient: const LinearGradient(
              colors: [AppColors.red, AppColors.primary],
            ),
          ),
        ],
      ),
    );
  }
}
