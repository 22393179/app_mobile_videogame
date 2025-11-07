import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importado para HapticFeedback
import '../main.dart';
import '../screens/cultivos_screen.dart';
import '../screens/menu_screen.dart';
import '../screens/perfil_screen.dart';

Widget buildBottomNavBar(BuildContext context, int currentIndex) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BottomNavigationBar(
        backgroundColor: kColorMarronOscuro,
        selectedItemColor: kColorDorado,
        unselectedItemColor: kColorGrisClaro,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'PixelifySans',
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'PixelifySans',
          fontSize: 11,
        ),
        onTap: (index) {
          // --- MEJORA: Feedback Táctil ---
          HapticFeedback.lightImpact();

          // Lógica de navegación (sin cambios, ya estaba perfecta)
          if (index == 0 && currentIndex != 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CultivosScreen()));
          } else if (index == 1 && currentIndex != 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MenuScreen()));
          } else if (index == 2 && currentIndex != 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const PerfilScreen()));
          }
        },

        // --- MEJORA: Lógica de ítems simplificada ---
        items: <BottomNavigationBarItem>[
          // 1. Cultivos
          BottomNavigationBarItem(
            icon: const Icon(Icons.grass_outlined),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kColorDorado.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.grass),
            ),
            label: 'Cultivos',
          ),
          // 2. Menú
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_outlined),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kColorDorado.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu_book),
            ),
            label: 'Menú',
          ),
          // 3. Perfil
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kColorDorado.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person),
            ),
            label: 'Perfil',
          ),
        ],
      ),
    ),
  );
}