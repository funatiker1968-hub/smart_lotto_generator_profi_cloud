class JackpotService {
  // Berechnet das Datum des nächsten Mittwochs
  DateTime get nextWednesday {
    final today = DateTime.now();
    int daysUntilWednesday = (DateTime.wednesday - today.weekday + 7) % 7;
    daysUntilWednesday = daysUntilWednesday == 0 ? 7 : daysUntilWednesday;
    return DateTime(today.year, today.month, today.day + daysUntilWednesday);
  }

  // Berechnet das Datum des nächsten Samstags
  DateTime get nextSaturday {
    final today = DateTime.now();
    int daysUntilSaturday = (DateTime.saturday - today.weekday + 7) % 7;
    daysUntilSaturday = daysUntilSaturday == 0 ? 7 : daysUntilSaturday;
    return DateTime(today.year, today.month, today.day + daysUntilSaturday);
  }

  // Holt Jackpot-Daten von der API
  Future<Map<String, dynamic>> fetchJackpotData() async {
    try {
      return {
        'nextDraw': nextWednesday.toIso8601String(),
        'jackpotAmount': '10.000.000 €',
        'currency': 'EUR'
      };
    } catch (e) {
      // Fallback falls API nicht erreichbar
      return {
        'nextDraw': nextWednesday.toIso8601String(),
        'jackpotAmount': '8.500.000 €',
        'currency': 'EUR'
      };
    }
  }
}
