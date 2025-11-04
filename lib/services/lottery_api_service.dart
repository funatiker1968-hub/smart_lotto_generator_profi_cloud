import 'dart:convert';
import 'package:http/http.dart' as http;

class LotteryApiService {
  static const String _baseUrl = 'https://api.lotto.example.com';
  static const Duration _timeout = Duration(seconds: 10);

  static Future<Map<String, dynamic>> getDrawingResults(String lotteryId) async {
    // Simuliere API-Aufruf für Entwicklung
    await Future.delayed(Duration(milliseconds: 500));
    
    // Mock-Daten - funktionieren auch ohne Internet
    return {
      'numbers': [3, 15, 27, 32, 41, 49],
      'bonusNumber': 7,
      'drawDate': DateTime.now().toIso8601String(),
      'jackpot': 15000000,
    };
  }

  static Future<List<dynamic>> getHistoricalData(String lotteryId, int days) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    // Mock historische Daten
    return [
      {
        'date': '2024-01-15',
        'numbers': [5, 12, 23, 34, 45, 49],
        'bonus': 8
      },
      {
        'date': '2024-01-12', 
        'numbers': [2, 17, 25, 31, 42, 47],
        'bonus': 11
      }
    ];
  }
}
