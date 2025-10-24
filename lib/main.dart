import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lotto_service.dart';
import 'stats_screen.dart';
import 'tip_analysis_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  List<List<int>> _myTips = [];
  double _totalCost = 0.0;

  void _generateNumbers() {
    setState(() {
      _currentNumbers = LottoService.generateLottoNumbers();
    });
  }

  void _saveTip() {
    if (_currentNumbers.isNotEmpty) {
      setState(() {
        _myTips.add(List.from(_currentNumbers));
      });
    }
  }

  Widget _buildLottoBall(int number) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange),
      ),
      child: Center(
        child: Text(
          number.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lotto World Pro'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text('Deine Lotto Zahlen'),
                    const SizedBox(height: 20),
                    _currentNumbers.isEmpty
                        ? const Text('Drücke "Zahlen generieren"')
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _currentNumbers
                                .map((number) => _buildLottoBall(number))
                                .toList(),
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _generateNumbers,
                          child: const Text('Zahlen generieren'),
                        ),
                        ElevatedButton(
                          onPressed: _currentNumbers.isEmpty ? null : _saveTip,
                          child: const Text('Tipp speichern'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Gespeicherte Tipps: ${_myTips.length}'),
            Expanded(
              child: _myTips.isEmpty
                  ? const Center(child: Text('Noch keine Tipps gespeichert'))
                  : ListView.builder(
                      itemCount: _myTips.length,
                      itemBuilder: (context, index) {
                        final tip = _myTips[index];
                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: tip
                                  .map((number) => _buildLottoBall(number))
                                  .toList(),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _myTips.removeAt(index);
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
    );
  }
}
