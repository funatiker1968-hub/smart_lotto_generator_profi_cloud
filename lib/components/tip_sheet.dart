import 'package:flutter/material.dart';
import './number_chip.dart';

class TipSheet extends StatelessWidget {
  final List<int> mainNumbers;
  final List<int> bonusNumbers;
  final String systemName;
  final Color primaryColor;
  final DateTime? generatedDate;

  const TipSheet({
    super.key,
    required this.mainNumbers,
    required this.bonusNumbers,
    required this.systemName,
    required this.primaryColor,
    this.generatedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kopfzeile mit Systemname und Datum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  systemName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  _formatDate(generatedDate ?? DateTime.now()),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 16),
            
            // Hauptzahlen Bereich
            const Text(
              'Hauptzahlen:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Hauptzahlen als Kugeln
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: mainNumbers.map((number) => buildNumberChip(
                number,
                primaryColor: primaryColor,
                isBall: true,
              )).toList(),
            ),
            
            // Bonus-Zahlen Bereich (falls vorhanden)
            if (bonusNumbers.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Bonus-Zahlen:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              // Bonus-Zahlen als Kugeln
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: bonusNumbers.map((number) => buildNumberChip(
                  number,
                  isBonus: true,
                  isBall: true,
                )).toList(),
              ),
            ],
            
            const SizedBox(height: 20),
            
            // Footer mit Trennlinie und Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: primaryColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Generiert mit Lotto World Pro',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// Erweiterte Version mit QR Code Platzhalter
class PremiumTipSheet extends StatelessWidget {
  final List<int> mainNumbers;
  final List<int> bonusNumbers;
  final String systemName;
  final Color primaryColor;
  final DateTime generatedDate;
  final String tipId;

  const PremiumTipSheet({
    super.key,
    required this.mainNumbers,
    required this.bonusNumbers,
    required this.systemName,
    required this.primaryColor,
    required this.generatedDate,
    required this.tipId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'OFFIZIELLER TIPPSCHEIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // System und Datum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  systemName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatDate(generatedDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'ID: $tipId',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 20),
            
            // Zahlen Bereich
            _buildNumbersSection('Hauptzahlen', mainNumbers, primaryColor),
            
            if (bonusNumbers.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildNumbersSection('Bonus-Zahlen', bonusNumbers, Colors.orange),
            ],
            
            const SizedBox(height: 24),
            
            // QR Code Platzhalter
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Icon(Icons.qr_code, size: 40, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  const Text(
                    'Scan für digitale Version',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumbersSection(String title, List<int> numbers, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: numbers.map((number) => buildNumberChip(
            number,
            primaryColor: color,
            isBall: true,
          )).toList(),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
