import 'package:flutter/material.dart';
import 'lotto_service.dart';
import 'components/tip_sheet.dart';
import 'stats_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto World Pro',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const LottoHomeScreen(),
    );
  }
}

class LottoHomeScreen extends StatefulWidget {
  const LottoHomeScreen({super.key});

  @override
  State<LottoHomeScreen> createState() => _LottoHomeScreenState();
}

class _LottoHomeScreenState extends State<LottoHomeScreen> {
  List<int> _currentNumbers = [];
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const StatsScreen(),
  ];

  void _generateNumbers() {
    setState(() {
      _currentNumbers = LottoService.generateLottoNumbers();
    });
  }

  void _showTipSheet() {
    if (_currentNumbers.isEmpty) {
      _generateNumbers();
    }
    
    // Für 6aus49: 6 Hauptzahlen, 1 Bonusnummer
    final mainNumbers = _currentNumbers.take(6).toList();
    final bonusNumbers = _currentNumbers.length > 6 ? [_currentNumbers[6]] : [LottoService.generateSuperzahl()];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TipSheet(
        mainNumbers: mainNumbers,
        bonusNumbers: bonusNumbers,
        systemName: 'Lotto 6aus49',
        primaryColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lotto World Pro'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Statistik',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
        onPressed: _showTipSheet,
        child: const Icon(Icons.receipt_long),
        tooltip: 'Tippschein anzeigen',
      ) : null,
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Willkommen bei Lotto World Pro',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Ihre professionelle Lotto-App mit:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildFeatureItem('🎯 Intelligente Tipp-Generierung'),
                  _buildFeatureItem('📊 Hot & Cold Zahlen Analyse'),
                  _buildFeatureItem('🌍 3 Lotto-Systeme unterstützt'),
                  _buildFeatureItem('🎨 Dark/Light Mode'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Schnellstart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tippen Sie auf den Tippschein-Button unten rechts, um loszulegen!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
