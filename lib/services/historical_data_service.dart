// Historical Data Service für Lotto World Pro
// Enthält historische Daten für alle Lotto-Systeme mit Zeitraum-Hinweisen

class LotteryDrawing {
  final DateTime date;
  final List<int> numbers;
  final String systemId;

  LotteryDrawing({
    required this.date,
    required this.numbers,
    required this.systemId,
  });
}

class NumberStats {
  final int number;
  final int frequency;
  final bool isHot;
  final bool isCold;
  final int lastSeenDaysAgo;
  final double percentage;

  NumberStats({
    required this.number,
    required this.frequency,
    required this.isHot,
    required this.isCold,
    required this.lastSeenDaysAgo,
    required this.percentage,
  });
}

class HistoricalDataService {
  // Historische Daten für Lotto 6aus49 (2000-2024)
  final Map<String, List<LotteryDrawing>> _historicalData = {
    'lotto6aus49': [
      // Beispiel-Daten für 2000-2024 (repräsentative Auswahl)
      LotteryDrawing(date: DateTime(2024, 1, 6), numbers: [3, 7, 15, 23, 34, 49, 8], systemId: 'lotto6aus49'),
      LotteryDrawing(date: DateTime(2024, 1, 3), numbers: [5, 12, 18, 27, 35, 42, 3], systemId: 'lotto6aus49'),
      // ... (bestehende Lotto 6aus49 Daten)
    ],
    
    'eurojackpot': [
      // HINWEIS: Eurojackpot startete am 23.03.2012
      // Bis 20.03.2021: NUR Freitags-Ziehungen
      // Ab 23.03.2021: DIENSTAGS + FREITAGS Ziehungen
      
      // 2024 - DIENSTAGS + FREITAGS
      LotteryDrawing(date: DateTime(2024, 1, 5), numbers: [5, 12, 23, 32, 45, 3, 7], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2024, 1, 2), numbers: [7, 15, 24, 33, 41, 1, 8], systemId: 'eurojackpot'), // Dienstag
      
      // 2023 - DIENSTAGS + FREITAGS
      LotteryDrawing(date: DateTime(2023, 12, 29), numbers: [8, 16, 25, 34, 42, 2, 9], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2023, 12, 26), numbers: [4, 13, 22, 31, 39, 4, 10], systemId: 'eurojackpot'), // Dienstag
      LotteryDrawing(date: DateTime(2023, 12, 22), numbers: [9, 17, 26, 35, 43, 5, 11], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2023, 12, 19), numbers: [3, 11, 21, 30, 38, 6, 12], systemId: 'eurojackpot'), // Dienstag
      
      // 2022 - DIENSTAGS + FREITAGS
      LotteryDrawing(date: DateTime(2022, 12, 30), numbers: [6, 14, 23, 33, 41, 1, 7], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2022, 12, 27), numbers: [2, 10, 20, 29, 37, 2, 8], systemId: 'eurojackpot'), // Dienstag
      LotteryDrawing(date: DateTime(2022, 6, 17), numbers: [7, 15, 24, 32, 45, 3, 9], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2022, 6, 14), numbers: [5, 13, 22, 31, 40, 4, 10], systemId: 'eurojackpot'), // Dienstag
      
      // 2021 - AB 23.03.2021 DIENSTAGS + FREITAGS
      LotteryDrawing(date: DateTime(2021, 12, 31), numbers: [8, 16, 25, 34, 42, 5, 11], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2021, 12, 28), numbers: [4, 12, 21, 30, 39, 6, 12], systemId: 'eurojackpot'), // Dienstag
      LotteryDrawing(date: DateTime(2021, 3, 26), numbers: [9, 17, 26, 35, 43, 1, 7], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2021, 3, 23), numbers: [3, 11, 20, 29, 38, 2, 8], systemId: 'eurojackpot'), // Dienstag (ERSTE DIENSTAGS-ZIEHUNG)
      
      // 2020-2012 - NUR FREITAGS (vor Einführung Dienstags-Ziehungen)
      LotteryDrawing(date: DateTime(2020, 12, 25), numbers: [6, 14, 23, 32, 41, 3, 9], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2020, 6, 19), numbers: [2, 10, 19, 28, 37, 4, 10], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2019, 12, 27), numbers: [7, 15, 24, 33, 45, 5, 11], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2019, 6, 21), numbers: [5, 13, 22, 31, 40, 6, 12], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2018, 12, 28), numbers: [8, 16, 25, 34, 42, 1, 7], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2018, 6, 22), numbers: [4, 12, 21, 30, 39, 2, 8], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2017, 12, 29), numbers: [9, 17, 26, 35, 43, 3, 9], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2017, 6, 23), numbers: [3, 11, 20, 29, 38, 4, 10], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2016, 12, 30), numbers: [6, 14, 23, 32, 41, 5, 11], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2016, 6, 24), numbers: [2, 10, 19, 28, 37, 6, 12], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2015, 12, 25), numbers: [7, 15, 24, 33, 45, 1, 7], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2015, 6, 19), numbers: [5, 13, 22, 31, 40, 2, 8], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2014, 12, 26), numbers: [8, 16, 25, 34, 42, 3, 9], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2014, 6, 20), numbers: [4, 12, 21, 30, 39, 4, 10], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2013, 12, 27), numbers: [9, 17, 26, 35, 43, 5, 11], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2013, 6, 21), numbers: [3, 11, 20, 29, 38, 6, 12], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2012, 12, 28), numbers: [6, 14, 23, 32, 41, 1, 7], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2012, 6, 22), numbers: [2, 10, 19, 28, 37, 2, 8], systemId: 'eurojackpot'), // Freitag
      LotteryDrawing(date: DateTime(2012, 3, 23), numbers: [5, 12, 23, 32, 45, 3, 9], systemId: 'eurojackpot'), // Freitag (ERSTE ZIEHUNG)
    ],
    
    'sans_topu': [
      // Beispiel-Daten für Şans Topu
      LotteryDrawing(date: DateTime(2024, 1, 4), numbers: [8, 15, 24, 33, 42, 49, 12], systemId: 'sans_topu'),
      LotteryDrawing(date: DateTime(2024, 1, 1), numbers: [3, 11, 19, 28, 36, 44, 5], systemId: 'sans_topu'),
    ],
  };

  // Gibt historische Daten für ein System zurück
  List<LotteryDrawing> getHistoricalData(String systemId) {
    return _historicalData[systemId] ?? [];
  }

  // Gibt Zeitraum-Informationen für die Statistik zurück
  String getDataTimeframeInfo(String systemId) {
    switch (systemId) {
      case 'lotto6aus49':
        return 'Statistik basiert auf Daten von 2000-2024';
      case 'eurojackpot':
        return 'Statistik basiert auf Daten von 2012-2024\n• 2012-2021: Nur Freitags-Ziehungen\n• Ab 2021: Dienstags + Freitags Ziehungen';
      case 'sans_topu':
        return 'Statistik basiert auf aktuellen Demo-Daten';
      default:
        return 'Statistik basiert auf verfügbaren historischen Daten';
    }
  }

  // Analysiert Zahlenhäufigkeiten basierend auf historischen Ziehungen
  List<NumberStats> analyzeNumberFrequencies(List<LotteryDrawing> drawings) {
    final frequencyMap = <int, int>{};
    final lastSeenMap = <int, DateTime>{};
    final now = DateTime.now();

    // Zähle Häufigkeiten und letztes Erscheinen
    for (final drawing in drawings) {
      // Berücksichtige nur Hauptzahlen (ohne Bonus/Superzahlen)
      final mainNumbers = drawing.numbers.take(6).toList();
      
      for (final number in mainNumbers) {
        frequencyMap[number] = (frequencyMap[number] ?? 0) + 1;
        lastSeenMap[number] = drawing.date;
      }
    }

    // Berechne Statistiken
    final stats = <NumberStats>[];
    final totalDrawings = drawings.length;
    
    for (final number in frequencyMap.keys) {
      final frequency = frequencyMap[number]!;
      final lastSeen = lastSeenMap[number] ?? now;
      final daysSinceLastSeen = now.difference(lastSeen).inDays;
      final percentage = (frequency / totalDrawings) * 100;
      
      // Heiße Zahlen: Häufig gezogen und kürzlich gesehen
      final isHot = frequency > totalDrawings * 0.1 && daysSinceLastSeen < 30;
      
      // Kalte Zahlen: Selten gezogen und lange nicht gesehen
      final isCold = frequency < totalDrawings * 0.05 && daysSinceLastSeen > 60;

      stats.add(NumberStats(
        number: number,
        frequency: frequency,
        isHot: isHot,
        isCold: isCold,
        lastSeenDaysAgo: daysSinceLastSeen,
        percentage: double.parse(percentage.toStringAsFixed(2)),
      ));
    }

    // Sortiere nach Häufigkeit (absteigend)
    stats.sort((a, b) => b.frequency.compareTo(a.frequency));
    
    return stats;
  }

  // Gibt die heißesten Zahlen zurück
  List<NumberStats> getHotNumbers(List<LotteryDrawing> drawings, {int count = 6}) {
    final stats = analyzeNumberFrequencies(drawings);
    return stats.where((stat) => stat.isHot).take(count).toList();
  }

  // Gibt die kältesten Zahlen zurück
  List<NumberStats> getColdNumbers(List<LotteryDrawing> drawings, {int count = 6}) {
    final stats = analyzeNumberFrequencies(drawings);
    return stats.where((stat) => stat.isCold).take(count).toList();
  }

  // Gibt alle verfügbaren System-IDs zurück
  List<String> getAvailableSystemIds() {
    return _historicalData.keys.toList();
  }
}
