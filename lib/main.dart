import 'package:flutter/material.dart';
import 'lotto_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto World Pro',
      theme: ThemeData.dark(),
      home: LottoHomeScreen(),
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
  final List<List<int>> _myTips = [];
  double _totalCost = 0.0;

  void _generateNumbers() {
    setState(() {
      _currentNumbers = LottoService.generateLottoNumbers();
      _totalCost = _myTips.length * 1.50;
    });
  }

  void _saveTip() {
    if (_currentNumbers.isNotEmpty) {
      setState(() {
        _myTips.add(List.from(_currentNumbers));
        _totalCost = _myTips.length * 1.50;
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
      _totalCost = _myTips.length * 1.50;
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
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text('Lotto World Pro', style: TextStyle(color: Color(0xFFFFD700))),
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
                    const Text('🎲 Deine Glückszahlen 🎲', 
                             style: TextStyle(color: Color(0xFFFFD700), fontSize: 18)),
                    const SizedBox(height: 20),
                    _currentNumbers.isEmpty
                        ? Column(
                            children: const [
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
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _generateNumbers,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC41E3A)),
                          child: const Text('SPIN', style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: _currentNumbers.isEmpty ? null : _saveTip,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF228B22)),
                          child: const Text('SPEICHERN', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Statistik Karte
            Card(
              color: const Color(0xFF2D2D2D),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('🎫 Tipps', style: TextStyle(color: Colors.grey)),
                        Text('${_myTips.length}', 
                             style: const TextStyle(fontSize: 22, color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('💰 Kosten', style: TextStyle(color: Colors.grey)),
                        Text('${_totalCost.toStringAsFixed(2)} €', 
                             style: const TextStyle(fontSize: 22, color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quick Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _generateMultipleTips(5),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8C00)),
                    child: const Text('5 Quick-Tipps', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _generateMultipleTips(10),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC143C)),
                    child: const Text('10 Mega-Tipps', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            
            const Text('💎 Meine Gewinn-Tipps 💎', 
                     style: TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            Expanded(
              child: _myTips.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.celebration_outlined, size: 60, color: Colors.grey),
                          SizedBox(height: 15),
                          Text('Noch keine Tipps', style: TextStyle(fontSize: 18, color: Colors.grey)),
                          SizedBox(height: 5),
                          Text('Generiere deine Glückszahlen!', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _myTips.length,
                      itemBuilder: (context, index) {
                        final tip = _myTips[index];
                        return Card(
                          color: const Color(0xFF2D2D2D),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFFFFD700),
                              child: Text('${index + 1}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: tip
                                  .map((number) => _buildLottoBall(number, size: 28))
                                  .toList(),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _myTips.removeAt(index);
                                  _totalCost = _myTips.length * 1.50;
                                });
                              },
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
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            )
          : null,
    );
  }
}
