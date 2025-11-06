// lib/widgets/bottom_nav_bar.dart

import 'package:flutter/material.dart';
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
      if (index == 0 && currentIndex != 0) { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CultivosScreen()));
      } else if (index == 1 && currentIndex != 1) { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
      } else if (index == 2 && currentIndex != 2) { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PerfilScreen()));
      }
    },
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: currentIndex == 0 ? kColorDorado.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.grass_outlined),
        ),
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
      BottomNavigationBarItem(
        icon: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: currentIndex == 1 ? kColorDorado.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.menu_book_outlined),
        ),
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
      BottomNavigationBarItem(
        icon: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: currentIndex == 2 ? kColorDorado.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person_outline),
        ),
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