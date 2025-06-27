import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/home/components/qr_code_generate_button.dart';
import 'package:tripiz_app/home/models/itinerary_from_station.dart';
import 'package:tripiz_app/home/models/payment_info.dart';

class ItineraryCard extends StatelessWidget {
  final ItineraryFromStation itinerary;

  const ItineraryCard({super.key, required this.itinerary});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary..withOpacity(0.4),
        boxShadow: [
          BoxShadow(color: AppColors.milk, blurRadius: 5, spreadRadius: 2),
        ],
        border: Border.all(
          color: AppColors.primary,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itinerary.itineraryName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
                Chip(
                  label: Text(
                    '${itinerary.distance} km',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, size: 16, color: AppColors.white),
                const SizedBox(width: 4),
                Text(
                  '${itinerary.estimatedDuration} min',
                  style: TextStyle(color: AppColors.white),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.white,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${itinerary.departureStation} → ${itinerary.arrivalStation}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: QrCodeGeneratorButton(
                paymentInfo: PaymentInfo(
                  tripId: itinerary.itineraryId!,
                  walletId: "94f94902-c724-47ca-85d7-529af32b4a64",
                  amount: 250,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showPaymentPage(BuildContext context, ItineraryFromStation itinerary) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PaymentPage(
  //         itineraryId: itinerary.itineraryId,
  //         amount: itinerary.distance * 100, // Exemple de calcul du prix
  //       ),
  //     ),
  //   );
  // }
}
