import 'package:flutter/material.dart';
import 'package:tripiz_app/common/components/custom_button.dart';
import 'package:tripiz_app/common/components/custom_input_field.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_weights.dart';
import 'package:tripiz_app/profile/components/avatar_modifier.dart';

class SetProfileInfosScreen extends StatelessWidget {
  const SetProfileInfosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Modifier le profil"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [AppColors.primary, AppColors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 110),
                child: const Center(child: AvatarModifier()),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    InfosTile(
                      type: TextInputType.name,
                      icon: Icons.person_outline,
                      label: "Nom",
                      value: "Franck Sean",
                      explanation:
                          "Le nom qui apparaîtra lorsque vous contriburez à une campagne ou lorsque vous en créerez une  ",
                    ),
                    InfosTile(
                      type: TextInputType.emailAddress,
                      icon: Icons.mail_outline,
                      label: "Adresse e-mail",
                      value: "seandjissou@gmail.com",
                      explanation:
                          "L’adresse email via laquelle vous serez potentiellement contacté",
                    ),
                    InfosTile(
                      type: TextInputType.phone,
                      icon: Icons.phone_outlined,
                      label: "Numéro de téléphone",
                      value: "+237 675 32 18 36",
                      explanation:
                          "Numéro de téléphone via lequel vous serez potentiellement contacté",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfosTile extends StatelessWidget {
  const InfosTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.explanation,
    required this.type,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final String explanation;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(fontWeight: FontWeights.bold),
                        ),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 16,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomInputField(),
                                    const SizedBox(height: 10),
                                    CustomButton(text: "Valider"),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.border_color_outlined,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  explanation,
                  softWrap: true,
                  style: const TextStyle(fontSize: 12, color: AppColors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
