import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/custom_Input_decoration.dart';
import '../components/custom_snack_bar.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TextEditingController _minController = TextEditingController(text: '1');
  final TextEditingController _maxController = TextEditingController(text: '100');
  final TextEditingController _quantityController = TextEditingController(text: '1');

  final List<int> _sortedNumbers = [];
  final Set<int> _usedNumbers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sorteio de Números'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Configure o sorteio',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
              decoration: CustomInputDecoration.build(
                labelText: 'Quantos números serão sorteados?',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: _minController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                      decoration: CustomInputDecoration.build(
                        labelText: 'Valor mínimo',
                      ),
                    ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _maxController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                    decoration: CustomInputDecoration.build(
                      labelText: 'Valor máximo',
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _sortearNumeros();
                customSnackBar(
                  context,
                  'Foram sorteados ${_sortedNumbers.length} números!',
                  backgroundColor: Colors.green,
                );
              },
              child: const Text('Sortear'),
            ),
            const SizedBox(height: 20),
            _sortedNumbers.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Números Sorteados:',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey, width: 2),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _sortedNumbers
                        .map((num) => Chip(
                      label: Text(
                        num.toString(),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.teal[100],
                    ))
                        .toList(),
                  ),
                ),
              ],
            )
                : const Text(
              'Nenhum número sorteado ainda',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _sortearNumeros() {
    setState(() {
      _sortedNumbers.clear();

      final int min = int.tryParse(_minController.text) ?? 0;
      final int max = int.tryParse(_maxController.text) ?? 100;
      final int quantity = int.tryParse(_quantityController.text) ?? 1;

      if (min >= max || quantity <= 0 || (max - min + 1) < quantity) {
        // Se os valores não forem válidos ou impossíveis de sortear, não fazer nada
        return;
      }

      final Random random = Random();
      _usedNumbers.clear();

      while (_sortedNumbers.length < quantity) {
        final int randomNumber = random.nextInt(max - min + 1) + min;
        if (!_usedNumbers.contains(randomNumber)) {
          _sortedNumbers.add(randomNumber);
          _usedNumbers.add(randomNumber);
        }
      }
    });
  }
}