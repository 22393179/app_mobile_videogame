// lib/screens/perfil_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import '../widgets/bottom_nav_bar.dart'; 

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  Widget _buildResumenDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( // <--- ¡CORRECCIÓN FINAL! Eliminamos 'const'
            label,
            style: TextStyle( 
                fontSize: 16, 
                color: kColorMarronOscuro, 
                fontFamily: 'PixelifySans'),
          ),
          Text(
            value,
            style: TextStyle( 
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: kColorMarronOscuro, 
                fontFamily: 'PixelifySans'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/thelastfarm.png', height: 40),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Avatar de Perfil con marco decorativo
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kColorDorado.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.18,
                    backgroundColor: kColorDorado,
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.17,
                      backgroundColor: kColorMarronOscuro,
                      child: const Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Nombre del Jugador con badge de nivel
                Column(
                  children: [
                    const Text(
                      'Nolberto',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: kColorMarronOscuro,
                        fontFamily: 'PixelifySans',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: kColorDorado.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kColorDorado),
                      ),
                      child: const Text(
                        'Granjero Experto',
                        style: TextStyle(
                          color: kColorMarronOscuro,
                          fontFamily: 'PixelifySans',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Contenedor de Estadísticas
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Estadísticas',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kColorMarronOscuro,
                              fontFamily: 'PixelifySans',
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: kColorVerdeClaro.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.star, color: kColorDorado, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Nivel 15',
                                  style: TextStyle(
                                    color: kColorMarronOscuro,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PixelifySans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: kColorMarronOscuro, thickness: 2, height: 25),
                      _buildResumenDetail('Experiencia', '1,250 / 2,000 XP'),
                      _buildResumenDetail('Días jugados', '128 días'),
                      _buildResumenDetail('Cultivos completados', '347'),
                      _buildResumenDetail('Cultivos actuales', '12'),
                      _buildResumenDetail('Monedas', '15,430'),
                      const SizedBox(height: 20),
                      const Text(
                        'Logros',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kColorMarronOscuro,
                          fontFamily: 'PixelifySans',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildAchievementIcon(Icons.eco, '23/30'),
                          _buildAchievementIcon(Icons.water_drop, '15/20'),
                          _buildAchievementIcon(Icons.price_check, '8/10'),
                          _buildAchievementIcon(Icons.bolt, '12/15'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 2),
    );
  }

  Widget _buildAchievementIcon(IconData icon, String progress) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kColorDorado.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kColorDorado),
          ),
          child: Icon(icon, color: kColorDorado, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          progress,
          style: const TextStyle(
            color: kColorMarronOscuro,
            fontSize: 12,
            fontFamily: 'PixelifySans',
          ),
        ),
      ],
    );
  }
}