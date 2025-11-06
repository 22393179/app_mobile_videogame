import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';

class LogrosScreen extends StatelessWidget {
  const LogrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logros'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Sección de Progreso General
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progreso General',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                  ),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: 0.65, // Ejemplo de progreso
                  backgroundColor: kColorGrisClaro,
                  valueColor: AlwaysStoppedAnimation<Color>(kColorDorado),
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 10,
                ),
                const SizedBox(height: 8),
                const Text(
                  '13/20 Logros Desbloqueados',
                  style: TextStyle(
                    color: kColorMarronOscuro,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Lista de Logros
          ...List.generate(5, (index) => _buildLogro(
            title: _logrosEjemplo[index]['title']!,
            description: _logrosEjemplo[index]['description']!,
            progress: _logrosEjemplo[index]['progress']!,
            isUnlocked: _logrosEjemplo[index]['isUnlocked']!,
          )),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(context, 1), // Ajusta el índice según necesites
    );
  }

  Widget _buildLogro({
    required String title,
    required String description,
    required double progress,
    required bool isUnlocked,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked ? kColorDorado.withOpacity(0.1) : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isUnlocked ? kColorDorado : kColorGrisClaro,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isUnlocked ? Icons.emoji_events : Icons.lock_outline,
                color: isUnlocked ? kColorDorado : kColorGrisClaro,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? kColorMarronOscuro : kColorGrisClaro,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: isUnlocked ? kColorMarronOscuro.withOpacity(0.8) : kColorGrisClaro,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: kColorGrisClaro.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
              isUnlocked ? kColorDorado : kColorGrisClaro,
            ),
            borderRadius: BorderRadius.circular(10),
            minHeight: 6,
          ),
          const SizedBox(height: 4),
          Text(
            '${(progress * 100).toInt()}%',
            style: TextStyle(
              color: isUnlocked ? kColorDorado : kColorGrisClaro,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> _logrosEjemplo = [
  {
    'title': 'Granjero Novato',
    'description': 'Cultiva tu primera cosecha',
    'progress': 1.0,
    'isUnlocked': true,
  },
  {
    'title': 'Experto en Cultivos',
    'description': 'Cultiva 50 plantas diferentes',
    'progress': 0.7,
    'isUnlocked': true,
  },
  {
    'title': 'Maestro del Riego',
    'description': 'Mantén 10 plantas hidratadas por 7 días',
    'progress': 0.3,
    'isUnlocked': false,
  },
  {
    'title': 'Coleccionista Verde',
    'description': 'Desbloquea todas las semillas disponibles',
    'progress': 0.5,
    'isUnlocked': true,
  },
  {
    'title': 'Rey de la Cosecha',
    'description': 'Obtén una cosecha perfecta',
    'progress': 0.0,
    'isUnlocked': false,
  },
];