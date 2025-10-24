import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lotto_service.dart';
import 'stats_screen.dart';
import 'tip_analysis_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Fehlerbehandlung für App-Starts
  runApp(SmartLottoApp());
}

class SmartLottoApp extends StatefulWidget {
  const SmartLottoApp({super.key});

  @override
  State<SmartLottoApp> createState() => _SmartLottoAppState();
}

class _SmartLottoAppState extends State<SmartLottoApp> {
  ThemeMode _mode = ThemeMode.system;
  Locale _locale = const Locale('de');

  void _changeLanguage(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto World Pro',
      themeMode: _mode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de'),
        Locale('en'),
        Locale('tr'),
      ],
      home: LottoHomeScreen(
        onThemeChanged: (mode) {
          setState(() {
            _mode = mode;
          });
        },
        onLanguageChanged: _changeLanguage,
        currentLocale: _locale,
      ),
    );
  }
}

class LottoHomeScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;

  const LottoHomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.currentLocale,
  });

  @override
  State<LottoHomeScreen> createState() => _LottoHomeScreenState();
}

class _LottoHomeScreenState extends State<LottoHomeScreen> {
  List<int> _currentNumbers = [];
  final List<List<int>> _myTips = [];
  double _totalCost = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    try {
      // Sicherer Start ohne komplexe Initialisierung
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Falls Fehler auftreten, trotzdem UI anzeigen
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _generateNumbers() {
    setState(() {
      _currentNumbers = LottoService.generateLottoNumbers();
      _totalCost = LottoService.calculateCost(_myTips.length, 1.50);
    });
  }

  void _saveTip() {
    if (_currentNumbers.isNotEmpty) {
      setState(() {
        _myTips.add(List.from(_currentNumbers));
        _totalCost = LottoService.calculateCost(_myTips.length, 1.50);
      });
    }
  }

  void _clearTips() {
    setState(() {
      _myTips.clear();
      _totalCost = 0.0;
    });
  }

  void _generateMultipleTips(int count) {
    setState(() {
      final newTips = LottoService.generateMultipleTips(count);
      _myTips.addAll(newTips);
      _totalCost = LottoService.calculateCost(_myTips.length, 1.50);
    });
  }

  Widget _buildLottoBall(int number, {double size = 40.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [Colors.white, Color(0xFFFFD700)],
          stops: [0.1, 1.0],
        ),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: const Color(0xFFB8860B), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number.toString().padLeft(2, '0'),
          style: TextStyle(
            color: const Color(0xFF8B4513),
            fontWeight: FontWeight.bold,
            fontSize: size * 0.35,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFFFFD700)),
              SizedBox(height: 20),
              Text('Lade Lotto App...', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text('Lotto World Pro', style: TextStyle(color: Color(0xFFFFD700))),
        backgroundColor: const Color(0xFF2D2D2D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF2D2D2D),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('🎲 Deine Glückszahlen 🎲', style: TextStyle(color: Color(0xFFFFD700))),
                    SizedBox(height: 20),
                    _currentNumbers.isEmpty
                        ? Column(
                            children: [
                              Icon(Icons.casino_outlined, size: 50, color: Colors.grey),
                              SizedBox(height: 10),
                              Text('Drücke SPIN zum Starten', style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _currentNumbers
                                .map((number) => _buildLottoBall(number))
                                .toList(),
                          ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _generateNumbers,
                          child: Text('SPIN'),
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFC41E3A)),
                        ),
                        ElevatedButton(
                          onPressed: _currentNumbers.isEmpty ? null : _saveTip,
                          child: Text('SPEICHERN'),
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF228B22)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _myTips.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.celebration_outlined, size: 60, color: Colors.grey),
                          SizedBox(height: 15),
                          Text('Noch keine Tipps', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _myTips.length,
                      itemBuilder: (context, index) {
                        final tip = _myTips[index];
                        return Card(
                          color: const Color(0xFF2D2D2D),
                          child: ListTile(
                            leading: CircleAvatar(backgroundColor: Color(0xFFFFD700), child: Text('${index + 1}')),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: tip.map((number) => _buildLottoBall(number, size: 28)).toList(),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _myTips.isNotEmpty
          ? FloatingActionButton(
              onPressed: _clearTips,
              child: Icon(Icons.delete),
              backgroundColor: Colors.red,
            )
          : null,
    );
  }
}
