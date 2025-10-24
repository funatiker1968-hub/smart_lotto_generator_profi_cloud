import 'package:flutter/material.dart';

class TipAnalysisScreen extends StatelessWidget {
  final List<List<int>> allTips;

  const TipAnalysisScreen({super.key, required this.allTips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipp Analyse'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Analysiere ${allTips.length} Tipps'),
            const SizedBox(height: 20),
            const Text('Tipp-Qualität:'),
            // Hier kommt die Analyse-Logik
          ],
        ),
      ),
    );
  }
}
