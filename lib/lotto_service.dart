import 'dart:math';

class LottoService {
  static List<int> generateLottoNumbers() {
    final random = Random();
    final numbers = <int>[];
    
    while (numbers.length < 6) {
      final number = random.nextInt(49) + 1;
      if (!numbers.contains(number)) {
        numbers.add(number);
      }
    }
    
    numbers.sort();
    return numbers;
  }

  static double calculateCost(int tipCount, double pricePerTip) {
    return tipCount * pricePerTip;
  }

  static List<List<int>> generateMultipleTips(int count) {
    final tips = <List<int>>[];
    for (int i = 0; i < count; i++) {
      tips.add(generateLottoNumbers());
    }
    return tips;
  }

  static Map<String, dynamic> simulateWinnings(List<List<int>> tips, int simulations) {
    final random = Random();
    int wins = 0;

    for (int i = 0; i < simulations; i++) {
      final winningNumbers = generateLottoNumbers();
      
      for (final tip in tips) {
        final matchingNumbers = tip.where((number) => winningNumbers.contains(number)).length;
        if (matchingNumbers >= 3) {
          wins++;
          break;
        }
      }
    }

    return {
      'winningProbability': wins / simulations,
      'totalWins': wins,
      'totalSimulations': simulations,
    };
  }
}
