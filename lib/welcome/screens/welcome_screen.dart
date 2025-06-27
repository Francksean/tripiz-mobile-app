import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';
import 'package:tripiz_app/common/cubits/location/location_cubit.dart';
import 'package:tripiz_app/common/cubits/location/location_state.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    LocationState state = context.read<LocationCubit>().state;
    if (state is LocationLoadedState) {
      Future.delayed(const Duration(seconds: 1), () {
        if (context.mounted) context.go("/onboarding");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationLoadedState) {
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) context.go("/onboarding");
            });
          }
        },
        child: Container(
          width: double.infinity,
          color: AppColors.primary,
          child: Center(
            child: Text(
              "Tripiz",
              style: TextStyle(
                fontSize: FontSizes.upperExtra,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
