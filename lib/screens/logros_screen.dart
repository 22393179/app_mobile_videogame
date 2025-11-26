import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';

class NovedadesScreen extends StatelessWidget {
  const NovedadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novedades',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // CABECERA — Novedades del videojuego
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Próximas Mejoras del Juego',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Mantente al día con las actualizaciones y nuevas funciones del videojuego 🎮',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // LISTA
          ..._novedades.map((n) => _buildNovedadCard(n)),
        ],
      ),

      bottomNavigationBar: buildBottomNavBar(context, 1),
    );
  }

  /// Tarjeta de cada novedad
  Widget _buildNovedadCard(Map<String, dynamic> n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICONO + TÍTULO
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kColorDorado.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  n['icon'],
                  color: kColorDorado,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  n['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // DESCRIPCIÓN
          Text(
            n['description'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),

          const SizedBox(height: 12),

          // FECHA
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                n['date'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Novedades del videojuego — EDITABLES
final List<Map<String, dynamic>> _novedades = [
  {
    'title': 'Nueva actualización 1.2 en camino 🚀',
    'description': 'Llegará un nuevo mapa exploratorio, correcciones visuales y mejoras en el rendimiento del juego.',
    'date': 'Hoy • 6:40 PM',
    'icon': Icons.system_update,
  },
  {
    'title': 'Modo Historia — Próxima expansión 📖',
    'description': 'Se añadirá un nuevo capítulo con personajes inéditos y misiones exclusivas.',
    'date': 'Ayer • 3:10 PM',
    'icon': Icons.auto_stories,
  },
  {
    'title': 'Nueva mecánica de logros 🏆',
    'description': 'El sistema de logros será conectado con la app para mostrar progreso en tiempo real.',
    'date': 'Hace 2 días',
    'icon': Icons.emoji_events,
  },
  {
    'title': 'Optimización del juego ⚙️',
    'description': 'Se redujeron los tiempos de carga y se mejoró la fluidez en dispositivos de gama baja.',
    'date': 'Hace 4 días',
    'icon': Icons.speed,
  },
  {
    'title': 'Próximamente: Modo Multijugador 🌐',
    'description': 'Se está trabajando en un sistema de salas privadas para partidas entre amigos.',
    'date': 'Hace 1 semana',
    'icon': Icons.group,
  },
  {
    'title': 'Nuevos objetos y skins 🎨',
    'description': 'Se agregarán diseños exclusivos y objetos personalizables para tu personaje.',
    'date': 'Hace 10 días',
    'icon': Icons.brush,
  },
];
