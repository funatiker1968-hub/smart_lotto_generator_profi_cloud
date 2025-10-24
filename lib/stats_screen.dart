import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  final List<List<int>> allTips;

  const StatsScreen({super.key, required this.allTips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiken'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gesamt Tipps: ${allTips.length}'),
            const SizedBox(height: 20),
            const Text('Häufigste Zahlen:'),
            // Hier kommt die Statistik-Logik
          ],
        ),
      ),
    );
  }
}
