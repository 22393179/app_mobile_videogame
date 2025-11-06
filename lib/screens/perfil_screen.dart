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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Avatar de Perfil
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.18,
                backgroundColor: kColorMarronOscuro,
                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              // Nombre del Jugador
              const Text(
                'Nolberto',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kColorMarronOscuro,
                  fontFamily: 'PixelifySans',
                ),
              ),
              const SizedBox(height: 40),
              // Contenedor de Resumen
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  border: Border.all(color: kColorMarronOscuro, width: 4.0),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resumen',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kColorMarronOscuro,
                        fontFamily: 'PixelifySans',
                      ),
                    ),
                    const Divider(color: kColorMarronOscuro, thickness: 2, height: 25),
                    _buildResumenDetail('Nivel', '15'),
                    _buildResumenDetail('Días de actividad', '128'),
                    _buildResumenDetail('Zombies Matados', '1,450'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 2),
    );
  }
}