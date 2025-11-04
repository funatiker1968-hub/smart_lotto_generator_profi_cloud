class LotteryDrawing {
  final String lotteryId;      // z.B. "lotto_6aus49", "eurojackpot"
  final DateTime date;         // Ziehungsdatum
  final List<int> numbers;     // Hauptzahlen
  final List<int> extraNumbers; // Zusatzzahlen (Superzahl, Eurozahlen)
  final String? jackpot;       // Jackpot in €
  final int? winners;          // Anzahl Gewinner

  LotteryDrawing({
    required this.lotteryId,
    required this.date,
    required this.numbers,
    this.extraNumbers = const [],
    this.jackpot,
    this.winners,
  });

  // JSON Konvertierung
  factory LotteryDrawing.fromJson(Map<String, dynamic> json) {
    return LotteryDrawing(
      lotteryId: json['lotteryId'],
      date: DateTime.parse(json['date']),
      numbers: List<int>.from(json['numbers']),
      extraNumbers: List<int>.from(json['extraNumbers'] ?? []),
      jackpot: json['jackpot'],
      winners: json['winners'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lotteryId': lotteryId,
      'date': date.toIso8601String(),
      'numbers': numbers,
      'extraNumbers': extraNumbers,
      'jackpot': jackpot,
      'winners': winners,
    };
  }

  // Für Anzeige in der UI
  String get displayDate {
    return '${date.day}.${date.month}.${date.year}';
  }

  String get displayNumbers {
    final mainNumbers = numbers.join(' - ');
    if (extraNumbers.isNotEmpty) {
      return '$mainNumbers | ${extraNumbers.join(' - ')}';
    }
    return mainNumbers;
  }
}

// Unterstützte Lotterien
class LotterySystem {
  final String id;
  final String name;
  final String country;
  final int numbersCount;
  final int minNumber;
  final int maxNumber;
  final int extraNumbersCount;
  final int extraMinNumber;
  final int extraMaxNumber;
  final String apiQuality; // "premium", "good", "limited"

  const LotterySystem({
    required this.id,
    required this.name,
    required this.country,
    required this.numbersCount,
    required this.minNumber,
    required this.maxNumber,
    this.extraNumbersCount = 0,
    this.extraMinNumber = 0,
    this.extraMaxNumber = 0,
    required this.apiQuality,
  });

  // Vordefinierte Lotterie-Systeme
  static const lotto6aus49 = LotterySystem(
    id: 'lotto_6aus49',
    name: 'Lotto 6aus49',
    country: 'DE',
    numbersCount: 6,
    minNumber: 1,
    maxNumber: 49,
    extraNumbersCount: 1,
    extraMinNumber: 0,
    extraMaxNumber: 9,
    apiQuality: 'limited',
  );

  static const eurojackpot = LotterySystem(
    id: 'eurojackpot',
    name: 'Eurojackpot',
    country: 'EU',
    numbersCount: 5,
    minNumber: 1,
    maxNumber: 50,
    extraNumbersCount: 2,
    extraMinNumber: 1,
    extraMaxNumber: 10,
    apiQuality: 'good',
  );

  static const sayisalLoto = LotterySystem(
    id: 'sayisal_loto',
    name: 'Sayısal Loto',
    country: 'TR',
    numbersCount: 6,
    minNumber: 1,
    maxNumber: 54,
    apiQuality: 'premium',
  );

  static const swissLotto = LotterySystem(
    id: 'swiss_lotto',
    name: 'Swiss Lotto',
    country: 'CH',
    numbersCount: 6,
    minNumber: 1,
    maxNumber: 42,
    extraNumbersCount: 1,
    extraMinNumber: 1,
    extraMaxNumber: 6,
    apiQuality: 'premium',
  );

  // Liste aller unterstützten Systeme
  static const allSystems = [
    lotto6aus49,
    eurojackpot,
    sayisalLoto,
    swissLotto,
  ];

  // System nach ID finden
  static LotterySystem getById(String id) {
    return allSystems.firstWhere(
      (system) => system.id == id,
      orElse: () => lotto6aus49,
    );
  }
}
