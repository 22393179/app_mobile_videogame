// lib/screens/cultivos_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import '../widgets/bottom_nav_bar.dart'; 

// Modelo mejorado para un Cultivo
class Cultivo {
  final String nombre;
  final String tiempo;
  final String icono;
  final Color bgColor;
  final int nivel;
  final int experiencia;
  final double progreso;

  Cultivo(
    this.nombre, 
    this.tiempo, 
    this.icono, 
    this.bgColor, {
    this.nivel = 1,
    this.experiencia = 0,
    this.progreso = 0.0,
  });
}

// Lista de cultivos con datos realistas
final List<Cultivo> listaCultivos = [
  Cultivo('🥕 Zanahorias', '2h:45m', Icons.eco.toString(), const Color(0xFFFF7043),
      nivel: 3, experiencia: 145, progreso: 0.7),
  Cultivo('🍅 Tomates', '4h:30m', Icons.eco.toString(), const Color(0xFFE53935),
      nivel: 5, experiencia: 340, progreso: 0.9),
  Cultivo('🥬 Lechuga', '1h:15m', Icons.eco.toString(), const Color(0xFF7CB342),
      nivel: 2, experiencia: 80, progreso: 0.4),
  Cultivo('🌽 Maíz', '5h:00m', Icons.eco.toString(), const Color(0xFFFFB300),
      nivel: 4, experiencia: 230, progreso: 0.6),
  Cultivo('🥔 Papas', '3h:20m', Icons.eco.toString(), const Color(0xFF8D6E63),
      nivel: 3, experiencia: 175, progreso: 0.5),
  Cultivo('🧅 Cebollas', '2h:50m', Icons.eco.toString(), const Color(0xFFBA68C8),
      nivel: 2, experiencia: 95, progreso: 0.3),
  Cultivo('🫑 Pimientos', '3h:45m', Icons.eco.toString(), const Color(0xFF4CAF50),
      nivel: 1, experiencia: 45, progreso: 0.2),
];

class CultivosScreen extends StatelessWidget {
  const CultivosScreen({super.key});

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
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

  Widget _buildCultivoRow(Cultivo cultivo) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cultivo.bgColor.withOpacity(0.7),
            cultivo.bgColor.withOpacity(0.9),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: cultivo.bgColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // Para futura interacción
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Contenedor para la imagen con efecto de brillo
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Text(
                        cultivo.nombre.split(' ')[0], // Mostrar solo el emoji
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cultivo.nombre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'PixelifySans',
                            shadows: [
                              Shadow(
                                color: kColorMarronOscuro,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nivel ${cultivo.nivel}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.9),
                                fontFamily: 'PixelifySans',
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 50,
                              height: 3,
                              child: LinearProgressIndicator(
                                value: cultivo.progreso,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                valueColor: AlwaysStoppedAnimation<Color>(kColorDorado),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cultivo.tiempo,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'PixelifySans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/farm_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats rápidos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard(
                      icon: Icons.water_drop,
                      value: '85%',
                      label: 'Agua',
                      color: Colors.blue,
                    ),
                    _buildStatCard(
                      icon: Icons.eco,
                      value: '12',
                      label: 'Cultivos',
                      color: kColorVerdeClaro,
                    ),
                    _buildStatCard(
                      icon: Icons.running_with_errors,
                      value: '3',
                      label: 'En riesgo',
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                        'MIS CULTIVOS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kColorMarronOscuro,
                          fontFamily: 'PixelifySans',
                        ),
                      ),
                      const Divider(color: kColorMarronOscuro, thickness: 2, height: 25),
                      ...listaCultivos.map(_buildCultivoRow).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 0),
    );
  }
}