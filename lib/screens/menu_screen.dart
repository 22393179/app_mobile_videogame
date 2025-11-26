import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';

// Importa tus pantallas reales
import 'cultivos_screen.dart';
import 'logros_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // --- TARJETA DE NAVEGACIÓN GENERAL ---
  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, size: 28, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kColorMarronOscuro,
                      fontFamily: 'PixelifySans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: kColorMarronOscuro.withOpacity(0.7),
                      fontFamily: 'PixelifySans',
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kColorMarronOscuro.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBeigeFondo,
      appBar: null,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Logo
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kColorDorado.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/thelastfarm.png',
                        height: 120,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'Menú Principal',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: kColorMarronOscuro,
                        fontFamily: 'PixelifySans',
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    // 📌 PRIMERA TARJETA — Cosecha
                    _buildMenuCard(
                      context: context,
                      title: 'Cosecha',
                      description: 'Planta y recoge tus cultivos.',
                      icon: Icons.grass,
                      iconColor: kColorVerdeClaro,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CultivosScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    // 📌 SEGUNDA TARJETA — Novedades
                    _buildMenuCard(
                      context: context,
                      title: 'Novedades',
                      description: 'Últimos eventos de tu granja.',
                      icon: Icons.new_releases,
                      iconColor: kColorDorado,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NovedadesScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: buildBottomNavBar(context, 1),
    );
  }
}
