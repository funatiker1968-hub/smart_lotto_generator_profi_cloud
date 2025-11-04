import 'package:flutter/material.dart';
import '../services/historical_data_service.dart';
import '../services/language_service.dart';
import '../services/theme_service.dart';
import '../services/lotto_system_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final HistoricalDataService _dataService = HistoricalDataService();
  final LanguageService _languageService = LanguageService();
  final ThemeService _themeService = ThemeService();
  final Map<String, List<int>> _hotNumbers = {};
  final Map<String, List<int>> _coldNumbers = {};
  bool _isLoading = true;
  String _loadingText = 'Lade Statistik...';

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  void _initializeServices() async {
    await _languageService.init();
    await _themeService.init();
    
    // Künstliche Verzögerung für sichtbaren Loading-State
    await Future.delayed(const Duration(milliseconds: 800));
    
    setState(() {
      _loadingText = 'Analysiere historische Daten...';
    });

    // Verwende historische Daten für echte Analyse
    final systems = ['lotto6aus49', 'eurojackpot', 'sans_topu'];
    
    for (final systemId in systems) {
      final drawings = _dataService.getHistoricalData(systemId);

      if (drawings.isNotEmpty) {
        final hotStats = _dataService.getHotNumbers(drawings);
        final coldStats = _dataService.getColdNumbers(drawings);
        
        setState(() {
          _hotNumbers[systemId] = hotStats.map((stat) => stat.number).toList();
          _coldNumbers[systemId] = coldStats.map((stat) => stat.number).toList();
        });
      } else {
        // Fallback: Demo-Daten
        setState(() {
          _hotNumbers[systemId] = [7, 15, 23, 34, 42, 19];
          _coldNumbers[systemId] = [1, 13, 27, 39, 48, 5];
        });
      }
      
      // Kurze Verzögerung zwischen Systemen für flüssigere UI
      await Future.delayed(const Duration(milliseconds: 300));
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildSystemStats(String systemId, String systemName) {
    final system = LottoSystemService.getSystemById(systemId);
    final hotNumbers = _hotNumbers[systemId] ?? [];
    final coldNumbers = _coldNumbers[systemId] ?? [];
    final timeframeInfo = _dataService.getDataTimeframeInfo(systemId);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: system.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  systemName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              timeframeInfo,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            _buildNumberSection('🔥 Heiße Zahlen', hotNumbers, system.primaryColor),
            const SizedBox(height: 16),
            _buildNumberSection('❄️ Kalte Zahlen', coldNumbers, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberSection(String title, List<int> numbers, Color color) {
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
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: numbers.map((number) {
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  number.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik & Analyse'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              _languageService.switchLanguage();
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(_themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              _themeService.toggleTheme();
              setState(() {});
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    _loadingText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSystemStats('lotto6aus49', 'Lotto 6aus49'),
                  const SizedBox(height: 24),
                  _buildSystemStats('eurojackpot', 'Eurojackpot'),
                  const SizedBox(height: 24),
                  _buildSystemStats('sans_topu', 'Sayısal Loto'),
                ],
              ),
            ),
    );
  }
}
