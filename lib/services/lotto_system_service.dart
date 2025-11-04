import 'package:flutter/material.dart';

class LottoSystem {
  final String id;
  final String name;
  final Color primaryColor;
  final int mainNumbersCount;
  final int bonusNumbersCount;
  final int maxMainNumber;
  final int maxBonusNumber;

  const LottoSystem({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.mainNumbersCount,
    required this.bonusNumbersCount,
    required this.maxMainNumber,
    required this.maxBonusNumber,
  });
}

class LottoSystemService {
  static final Map<String, LottoSystem> _systems = {
    'lotto6aus49': const LottoSystem(
      id: 'lotto6aus49',
      name: 'Lotto 6aus49',
      primaryColor: Color(0xFF1976D2),
      mainNumbersCount: 6,
      bonusNumbersCount: 1,
      maxMainNumber: 49,
      maxBonusNumber: 9,
    ),
    'eurojackpot': const LottoSystem(
      id: 'eurojackpot',
      name: 'Eurojackpot',
      primaryColor: Color(0xFFF57C00),
      mainNumbersCount: 5,
      bonusNumbersCount: 2,
      maxMainNumber: 50,
      maxBonusNumber: 12,
    ),
    'sans_topu': const LottoSystem(
      id: 'sans_topu',
      name: 'Sayısal Loto',
      primaryColor: Color(0xFF7B1FA2),
      mainNumbersCount: 6,
      bonusNumbersCount: 1,
      maxMainNumber: 49,
      maxBonusNumber: 14,
    ),
  };

  static List<LottoSystem> getAvailableSystems() {
    return _systems.values.toList();
  }

  static LottoSystem getSystemById(String id) {
    return _systems[id] ?? _systems['lotto6aus49']!;
  }
}
