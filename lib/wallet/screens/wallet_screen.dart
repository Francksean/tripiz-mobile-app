import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
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
  String _timeSpanSelected = "Cette semaine";
  final List<String> _weekBorders =
      CustomDateUtils.getCurrentWeekRangeWithYear();

  @override
  void initState() {
    super.initState();
    context.read<WalletCubit>().loadWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: kToolbarHeight + 40,
      ),
      child: RefreshIndicator(
        onRefresh: () => context.read<WalletCubit>().loadWallet(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Champ de recherche
            _buildSearchField(),

            // Filtres par type de transaction
            _buildTransactionTypeFilters(),

            // Section solde et bouton recharger
            _buildBalanceSection(),

            // Filtres de période
            _buildTimeFilters(),

            // Liste des transactions
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return CustomInputField(
      fillColor: AppColors.background,
      borderRadius: const BorderRadius.all(Radius.circular(99)),
      hintText: "Rechercher",
      hintStyle: TextStyle(color: AppColors.border),
      suffixIcon: Icon(Icons.search, color: AppColors.border),
      isBordered: false,
    );
  }

  Widget _buildTransactionTypeFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TranxTypeChoiceChip(
            label: "Tous",
            isSelected: selectedLabel == "Tous",
            onSelected: () {
              setState(() => selectedLabel = "Tous");
              context.read<WalletCubit>().sortTransactionsByType(null);
            },
          ),
          const SizedBox(width: 5),
          TranxTypeChoiceChip(
            label: "Dépenses",
            isSelected: selectedLabel == "Dépenses",
            onSelected: () {
              setState(() => selectedLabel = "Dépenses");
              context.read<WalletCubit>().sortTransactionsByType(
                TransactionType.SPENDING,
              );
            },
          ),
          const SizedBox(width: 5),
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
    );
  }

  Widget _buildBalanceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Solde Disponible",
                style: TextStyle(
                  fontSize: FontSizes.large,
                  color: AppColors.vantablack,
                ),
              ),
              const SizedBox(height: 5),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoading) {
                    return _buildShimmerBalance();
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
                  return _buildShimmerBalance();
                },
              ),
            ],
          ),
          CustomButton(
            onPressed: () => _showRechargeBottomSheet(),
            text: "Recharger",
            prefixIcon: Icon(Icons.add, color: AppColors.white),
            backgroundColor: AppColors.secondary,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBalance() {
    return Shimmer.fromColors(
      baseColor: AppColors.background,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 150,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showRechargeBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return CustomBottomSheet(
          heightRatio: 0.5,
          child: RechargeBottomCard(
            walletId: "94f94902-c724-47ca-85d7-529af32b4a64",
          ),
        );
      },
    );
  }

  Widget _buildTimeFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: DropdownButton<String>(
              underline: Container(),
              value: _timeSpanSelected,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _timeSpanSelected = value);
                }
              },
              items: const [
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
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading) {
            return _buildShimmerTransactions();
          } else if (state is WalletError) {
            return Center(child: Text(state.message));
          } else if (state is WalletLoaded) {
            final groupedTransactions = state.groupedTransactions;

            if (groupedTransactions.isEmpty) {
              return Center(
                child: Text(
                  "Aucune transaction trouvée",
                  style: TextStyle(
                    fontSize: FontSizes.large,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: groupedTransactions.length,
              itemBuilder: (context, index) {
                final date = groupedTransactions.keys.elementAt(index);
                final transactions = groupedTransactions[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        CustomDateUtils.formatDateSpecial(date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                    ...transactions.map((transaction) {
                      return TransactionUnitCard(transaction: transaction);
                    }),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: AppColors.background,
                        dashGapLength: 4.0,
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return _buildShimmerTransactions();
        },
      ),
    );
  }

  Widget _buildShimmerTransactions() {
    return Shimmer.fromColors(
      baseColor: AppColors.background,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5, // Nombre d'éléments de chargement
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder pour la date
                Container(
                  width: 80,
                  height: 20,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                // Placeholder pour la transaction
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 16,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 80,
                            height: 14,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),

                // Séparateur
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: AppColors.background,
                    dashGapLength: 4.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
