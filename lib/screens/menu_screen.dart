// lib/screens/menu_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import '../widgets/bottom_nav_bar.dart'; 
import 'cultivos_screen.dart';
import 'logros_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Widget _buildMenuButton(String text, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 100, // Altura fija para todos los botones
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: kColorMarronOscuro,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: kColorDorado, width: 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kColorDorado.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 32, color: kColorDorado),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kColorMarronOscuro,
                      fontFamily: 'PixelifySans',
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: kColorMarronOscuro.withOpacity(0.5)),
            ],
          ),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/farm_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9),
              BlendMode.lighten,
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '¡Bienvenido a The Last Farm!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kColorMarronOscuro,
                          fontFamily: 'PixelifySans',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildMenuButton(
                        'Cosecha',
                        Icons.grass,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CultivosScreen()),
                          );
                        },
                      ),
                      _buildMenuButton(
                        'Logros',
                        Icons.emoji_events,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LogrosScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 1),
    );
  }
}