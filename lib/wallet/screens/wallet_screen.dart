import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/common/components/custom_bottom_sheet.dart';
import 'package:tripiz_app/common/components/custom_button.dart';
import 'package:tripiz_app/common/components/custom_input_field.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';
import 'package:tripiz_app/common/utils/custom_date_utils.dart';
import 'package:tripiz_app/wallet/components/recharge_bottom_card.dart';
import 'package:tripiz_app/wallet/components/transaction_unit_card.dart';
import 'package:tripiz_app/wallet/components/tranx_type_choice_chip.dart';
import 'package:tripiz_app/wallet/cubits/wallet/wallet_cubit.dart';
import 'package:tripiz_app/wallet/enum/transaction_type.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String selectedLabel = "Tous";
  final String _timeSpanSelcted = "Cette semaine";
  final List<String> _weekBorders =
      CustomDateUtils.getCurrentWeekRangeWithYear();

  @override
  void initState() {
    super.initState();
    WalletCubit walletCubit = context.read<WalletCubit>();
    walletCubit.loadWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: kToolbarHeight + 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          CustomInputField(
            fillColor: AppColors.background,
            borderRadius: BorderRadius.all(Radius.circular(99)),
            hintText: "Rechercher",
            hintStyle: TextStyle(color: AppColors.border),
            suffixIcon: Icon(Icons.search, color: AppColors.border),
            isBordered: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              TranxTypeChoiceChip(
                label: "Tous",
                isSelected: selectedLabel == "Tous",
                onSelected: () {
                  setState(() => selectedLabel = "Tous");
                  context.read<WalletCubit>().sortTransactionsByType(null);
                },
              ),
              TranxTypeChoiceChip(
                label: "Dépenses",
                isSelected: selectedLabel == "Dépenses",
                onSelected: () {
                  setState(() => selectedLabel = "Dépenses");
                  context.read<WalletCubit>().sortTransactionsByType(
                    TransactionType.SPENDING,
                  );
                  print("111111111111111111111111");
                },
              ),
              TranxTypeChoiceChip(
                label: "Recharges",
                isSelected: selectedLabel == "Recharges",
                onSelected: () {
                  setState(() => selectedLabel = "Recharges");
                  context.read<WalletCubit>().sortTransactionsByType(
                    TransactionType.RECHARGE,
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5,
                children: [
                  Text(
                    "Solde Disponible",
                    style: TextStyle(
                      fontSize: FontSizes.large,
                      color: AppColors.vantablack,
                    ),
                  ),
                  BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) {
                      if (state is WalletLoading) {
                        return CircularProgressIndicator();
                      } else if (state is WalletError) {
                        return Text(state.message);
                      } else if (state is WalletLoaded) {
                        return Text(
                          "${state.wallet.balance} Fcfa",
                          style: TextStyle(
                            fontSize: FontSizes.upperExtra,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
              CustomButton(
                onPressed: () {
                  //TODO : implements the actual function
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CustomBottomSheet(
                        child: RechargeBottomCard(
                          walletId: "94f94902-c724-47ca-85d7-529af32b4a64",
                        ),
                      );
                    },
                  );
                },
                text: "Recharger",
                prefixIcon: Icon(Icons.add, color: AppColors.white),
                backgroundColor: AppColors.secondary,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: DropdownButton(
                  underline: Container(),
                  value: _timeSpanSelcted,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      _timeSpanSelcted == value;
                    });
                  },
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "Cette semaine",
                      child: Text("Cette semaine"),
                    ),
                    DropdownMenuItem(
                      value: "Ce mois-ci",
                      child: Text("Ce mois-ci"),
                    ),
                  ],
                ),
              ),
              Text(
                "${_weekBorders[0]} - ${_weekBorders[1]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizes.upperLarge,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if (state is WalletLoading) {
                return CircularProgressIndicator();
              } else if (state is WalletError) {
                return Text(state.message);
              } else if (state is WalletLoaded) {
                final groupedTransactions = state.groupedTransactions;

                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,

                    itemCount: groupedTransactions.length,
                    itemBuilder: (context, index) {
                      final date = groupedTransactions.keys.elementAt(index);
                      final transactions = groupedTransactions[date]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            CustomDateUtils.formatDateSpecial(date),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),

                          ...transactions.map((transaction) {
                            return TransactionUnitCard(
                              transaction: transaction,
                            );
                          }),
                          DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: AppColors.background,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
