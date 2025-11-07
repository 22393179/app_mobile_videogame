import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';
import 'cultivos_screen.dart';
import 'logros_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // --- WIDGET COMPLETAMENTE NUEVO PARA LAS SECCIONES ---
  /// Crea una tarjeta de navegación grande, coherente con las tarjetas del perfil.
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
            // Icono con fondo de color
            CircleAvatar(
              radius: 28,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, size: 28, color: iconColor),
            ),
            const SizedBox(width: 16),
            // Textos
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
            // Flecha
            Icon(Icons.arrow_forward_ios,
                color: kColorMarronOscuro.withOpacity(0.5), size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Fondo coherente con el resto de la app
      backgroundColor: kColorBeigeFondo,
      // 2. ¡AppBar eliminada!
      appBar: null,
      // 3. Cuerpo de la pantalla
      body: SafeArea(
        child: LayoutBuilder( // 1. Usar LayoutBuilder para obtener la altura
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox( // 2. Forzar altura mínima
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 3. Centrar verticalmente
                  crossAxisAlignment: CrossAxisAlignment.center, // 4. Centrar logo y título
                  children: <Widget>[
                    // --- INICIO DE LOGO ---
                    // 5. Se añade el logo con brillo
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kColorDorado.withOpacity(0.5), // Brillo
                            spreadRadius: 5,
                            blurRadius: 20, // Difuminado
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/thelastfarm.png',
                        height: 120, // 6. Un tamaño con presencia
                      ),
                    ),
                    const SizedBox(height: 30), // Espacio
                    // --- FIN DE LOGO ---

                    // 4. Título de la pantalla (CORREGIDO)
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

                    // 5. Tarjeta de "Cosecha" (AÑADIDA)
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
                              builder: (context) => const CultivosScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 15),

                    // 6. Tarjeta de "Logros" (AÑADIDA Y CORREGIDA)
                    _buildMenuCard(
                      context: context,
                      title: 'Logros',
                      description: 'Revisa tus medallas y trofeos.',
                      icon: Icons.emoji_events,
                      iconColor: kColorDorado,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogrosScreen()),
                        );
                      },
                    ),
                  ], // Cierre de children
                ), // Cierre de Column
              ), // Cierre de ConstrainedBox
            ); // Cierre de SingleChildScrollView
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 1),
    );
  }
}