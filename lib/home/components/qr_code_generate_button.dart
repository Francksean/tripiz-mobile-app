import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/home/models/payment_info.dart';

class QrCodeGeneratorButton extends StatelessWidget {
  final PaymentInfo paymentInfo;
  final Color buttonColor;
  final double qrSize;
  final Color qrBackgroundColor;
  final Color qrForegroundColor;

  const QrCodeGeneratorButton({
    super.key,
    required this.paymentInfo,
    this.buttonColor = Colors.blue,
    this.qrSize = 200,
    this.qrBackgroundColor = Colors.white,
    this.qrForegroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showQrBottomSheet(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.background,
        padding: const EdgeInsets.all(10),
      ),
      child: Icon(Icons.qr_code, color: AppColors.vantablack),
    );
  }

  void _showQrBottomSheet(BuildContext context) {
    final jsonData = paymentInfo.toJsonString();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'QR Code de Paiement',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildQrCodeWidget(jsonData),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.share,
                        label: 'Partager',
                        onPressed: () => _shareQrCode(context, jsonData),
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.download,
                        label: 'Télécharger',
                        onPressed: () => _saveQrCode(context, jsonData),
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.copy,
                        label: 'Copier',
                        onPressed: () => _copyToClipboard(context, jsonData),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildQrCodeWidget(String data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: qrBackgroundColor),
      child: Column(
        children: [
          QrImageView(
            data: data,
            version: QrVersions.auto,
            size: qrSize,
            backgroundColor: qrBackgroundColor,
            foregroundColor: qrForegroundColor,
            gapless: true,
            errorStateBuilder: (cxt, err) {
              return const Center(
                child: Text(
                  "Erreur de génération",
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 28),
          onPressed: onPressed,
          color: Theme.of(context).primaryColor,
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _shareQrCode(BuildContext context, String data) {
    // Implémentez la logique de partage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fonctionnalité de partage bientôt disponible'),
      ),
    );
  }

  void _saveQrCode(BuildContext context, String data) {
    // Implémentez la sauvegarde du QR code
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fonctionnalité de sauvegarde bientôt disponible'),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String data) {
    Clipboard.setData(ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Données copiées dans le presse-papier')),
    );
  }
}
