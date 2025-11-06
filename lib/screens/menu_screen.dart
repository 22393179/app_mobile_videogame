// lib/screens/menu_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import '../widgets/bottom_nav_bar.dart'; 
import 'cultivos_screen.dart';
import 'perfil_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Widget _buildMenuButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorGrisBoton,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: kColorMarronOscuro, width: 3),
            ),
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.4),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'PixelifySans',
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/thelastfarm.png', height: 40),
        automaticallyImplyLeading: false, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMenuButton('Cosecha', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CultivosScreen()),
              );
            }),
            _buildMenuButton('LOGROS', () {
              // Lógica para Logros
            }),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 1), 
    );
  }
}