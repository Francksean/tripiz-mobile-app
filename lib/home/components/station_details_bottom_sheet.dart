import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/home/components/itinerary_card.dart';
import 'package:tripiz_app/home/cubits/itinerary/itinerary_cubit.dart';
import 'package:tripiz_app/home/models/station_position.dart';

class StationDetailsBottomSheet extends StatelessWidget {
  final StationPosition station;

  const StationDetailsBottomSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header avec bouton fermer
          Text(
            station.stationName!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          // Informations de base
          // _buildInfoRow(Icons.location_on, station.address),
          // _buildInfoRow(Icons.phone, station.phone ?? 'Non renseigné'),
          // _buildInfoRow(Icons.access_time, station.openingHours ?? '24/7'),
          const SizedBox(height: 20),

          // Card des itinéraires
          const Text('Itinéraires disponibles', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),

          BlocProvider(
            create:
                (context) =>
                    ItineraryCubit()..loadItineraries(station.stationId!),
            child: _buildItinerariesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.black),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildItinerariesList() {
    return BlocBuilder<ItineraryCubit, ItineraryState>(
      builder: (context, state) {
        if (state is ItineraryLoading) {
          return Column(
            children: List.generate(2, (index) => _buildShimmerCard()),
          );
        }

        if (state is ItineraryError) {
          return Text('Erreur: ${state.message}');
        }

        if (state is ItineraryLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.itineraries.length,
            itemBuilder: (context, index) {
              final itinerary = state.itineraries[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ItineraryCard(itinerary: itinerary),
              );
            },
          );
        }

        return const Text('Aucun itinéraire disponible');
      },
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
