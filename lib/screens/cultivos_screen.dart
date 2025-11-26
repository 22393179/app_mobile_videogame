// lib/screens/cultivos_screen.dart

import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';

//
// ──────────────────────────────────────────────────────────────
//   MODELO DE BLOQUE DE CULTIVO
// ──────────────────────────────────────────────────────────────
//

class BloqueCultivo {
  final int id;                    // Número del bloque (1–26)
  final String cultivo;            // "Zanahoria 🥕"
  final Duration tiempoTotal;      // Tiempo total que tarda
  Duration tiempoRestante;         // Tiempo restante
  final int total;                 // Zanahorias que dará
  bool listo;                      // Si ya se puede cosechar
  final Color color;

  BloqueCultivo({
    required this.id,
    required this.cultivo,
    required this.tiempoTotal,
    required this.tiempoRestante,
    required this.total,
    required this.listo,
    required this.color,
  });
}

//
// ──────────────────────────────────────────────────────────────
//   LISTA DE BLOQUES (simulación inicial)
// ──────────────────────────────────────────────────────────────
//

List<BloqueCultivo> bloquesDeCultivo = [
  BloqueCultivo(
    id: 3,
    cultivo: 'Zanahoria 🥕',
    tiempoTotal: const Duration(hours: 3),
    tiempoRestante: const Duration(hours: 2, minutes: 45),
    total: 50,
    listo: false,
    color: const Color(0xFFFF7043),
  ),
  BloqueCultivo(
    id: 7,
    cultivo: 'Zanahoria 🥕',
    tiempoTotal: const Duration(hours: 3),
    tiempoRestante: const Duration(minutes: 10),
    total: 80,
    listo: false,
    color: const Color(0xFFFF7043),
  ),
  BloqueCultivo(
    id: 12,
    cultivo: 'Zanahoria 🥕',
    tiempoTotal: const Duration(hours: 3),
    tiempoRestante: Duration.zero,
    total: 120,
    listo: true,
    color: Colors.green,
  ),
];

//
// ──────────────────────────────────────────────────────────────
//   PANTALLA PRINCIPAL
// ──────────────────────────────────────────────────────────────
//

class CultivosScreen extends StatelessWidget {
  const CultivosScreen({super.key});

  // ───── Tarjetas superiores (contadores) ──────────────────────
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'PixelifySans',
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: 'PixelifySans',
            ),
          ),
        ],
      ),
    );
  }

  // ───── Card por bloque ──────────────────────
  Widget _buildBloqueRow(BloqueCultivo b) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            b.color.withOpacity(0.7),
            b.color.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: b.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ─────────── LADO IZQUIERDO ───────────
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('🥕', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bloque #${b.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'PixelifySans',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // ─────────── LADO DERECHO ───────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      b.listo
                          ? 'LISTO ✔️'
                          : '${b.tiempoRestante.inHours}h ${b.tiempoRestante.inMinutes % 60}m',
                      style: TextStyle(
                        fontSize: 16,
                        color: b.listo ? Colors.greenAccent : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PixelifySans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Icon(Icons.water_drop,
                        color: Colors.white, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ──────── UI ─────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    // Cálculo automático
    int bloquesTotales = 26;
    int bloquesOcupados = bloquesDeCultivo.length;
    int bloquesLibres = bloquesTotales - bloquesOcupados;

    int zanahoriasTotales = bloquesDeCultivo
        .fold(0, (sum, b) => sum + b.total); // 🔥 TOTAL GENERAL

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─────── TARJETAS SUPERIORES ────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard(
                    icon: Icons.square_foot,
                    value: '$bloquesTotales',
                    label: 'Bloques Totales',
                    color: Colors.orange,
                  ),
                  _buildStatCard(
                    icon: Icons.check_box,
                    value: '$bloquesOcupados',
                    label: 'Ocupados',
                    color: Colors.deepOrange,
                  ),
                  _buildStatCard(
                    icon: Icons.crop_square,
                    value: '$bloquesLibres',
                    label: 'Libres',
                    color: Colors.green,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔥 TOTAL GENERAL DE ZANAHORIAS
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '🥕 Total de Zanahorias: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PixelifySans',
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      '$zanahoriasTotales',
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'PixelifySans',
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ─────── LISTA DE BLOQUES ────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MIS ZANAHORIAS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kColorMarronOscuro,
                        fontFamily: 'PixelifySans',
                      ),
                    ),
                    const Divider(
                      color: kColorMarronOscuro,
                      thickness: 2,
                      height: 25,
                    ),

                    // Render dinámico de los bloques
                    ...bloquesDeCultivo.map(_buildBloqueRow).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 0),
    );
  }
}
