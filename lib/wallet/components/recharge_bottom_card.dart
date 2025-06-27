import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/common/components/custom_button.dart';
import 'package:tripiz_app/common/components/custom_input_field.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';
import 'package:tripiz_app/wallet/cubits/recharge-request/recharge_cubit.dart';
import 'package:tripiz_app/wallet/models/recharge_request.dart';
import 'package:tripiz_app/wallet/services/recharge_service.dart';

class RechargeBottomCard extends StatefulWidget {
  final String walletId;

  const RechargeBottomCard({super.key, required this.walletId});

  @override
  State<RechargeBottomCard> createState() => _RechargeBottomCardState();
}

class _RechargeBottomCardState extends State<RechargeBottomCard> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RechargeCubit(),
      child: BlocConsumer<RechargeCubit, RechargeState>(
        listener: (context, state) {
          if (state is RechargeFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is RechargeSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Recharge réussie !')));
          }
        },
        builder: (context, state) {
          return Column(
            spacing: 10,
            children: [
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    labelText: "Numéro payeur",
                    hintText: "+237XXXXXXXXX",
                  ),
                  Text(
                    "Ce numéro correspond à celui qui sera débité (MOMO/OM)",
                    style: TextStyle(
                      color: AppColors.border,
                      fontSize: FontSizes.small,
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    labelText: "Montant de la recharge",
                    hintText: "5000",
                  ),
                  Text(
                    "Le montant qui sera débité du compte mobile",
                    style: TextStyle(
                      color: AppColors.border,
                      fontSize: FontSizes.small,
                    ),
                  ),
                ],
              ),
              CustomButton(
                text: "Recharger",
                backgroundColor: AppColors.secondary,
                isLoading: state is RechargeLoading,
                onPressed:
                    state is RechargeLoading
                        ? null
                        : () {
                          final request = RechargeRequest(
                            walletId: widget.walletId,
                            amount: double.parse(_amountController.text),
                            phone: _phoneController.text,
                            channel: "cm.mobile",
                          );
                          context.read<RechargeCubit>().performRecharge(
                            request,
                          );
                        },
              ),
            ],
          );
        },
      ),
    );
  }
}
