// lib/widgets/bottom_nav_bar.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import '../screens/cultivos_screen.dart'; // Importación correcta: sube a lib/ y baja a screens/
import '../screens/menu_screen.dart';
import '../screens/perfil_screen.dart';

Widget buildBottomNavBar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    backgroundColor: kColorMarronOscuro,
    selectedItemColor: kColorBeigeFondo,
    unselectedItemColor: Colors.white70,
    currentIndex: currentIndex, 
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: const TextStyle(fontFamily: 'PixelifySans', fontWeight: FontWeight.bold), 
    unselectedLabelStyle: const TextStyle(fontFamily: 'PixelifySans'), 
    onTap: (index) {
      if (index == 0 && currentIndex != 0) { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CultivosScreen()));
      } else if (index == 1 && currentIndex != 1) { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
      } else if (index == 2 && currentIndex != 2) { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PerfilScreen()));
      }
    },
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'Cultivos'), 
      BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menú'),    
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),  
    ],
  );
}