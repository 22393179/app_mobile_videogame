// lib/screens/cultivos_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import '../widgets/bottom_nav_bar.dart'; 

// Modelo simple para un Cultivo
class Cultivo {
  final String nombre;
  final String tiempo;
  final String imagenAsset; 
  final Color bgColor;

  Cultivo(this.nombre, this.tiempo, this.imagenAsset, this.bgColor);
}

// Lista de cultivos
final List<Cultivo> listaCultivos = [
  Cultivo('RABANO', '20h:15m', 'assets/images/rabano.png', const Color(0xFFE0BBE4)),
  Cultivo('TOMATE', '20h:15m', 'assets/images/tomate.png', const Color(0xFFDA2C3E)),
  Cultivo('ZANAHORIA', '20h:15m', 'assets/images/zanahoria.png', const Color(0xFFFFD187)),
  Cultivo('PLATANO', '20h:15m', 'assets/images/platano.png', const Color(0xFFF9DC5C)),
  Cultivo('PIÑA', '20h:15m', 'assets/images/pina.png', const Color(0xFFFD9F2C)),
];

class CultivosScreen extends StatelessWidget {
  const CultivosScreen({super.key});

  Widget _buildCultivoRow(Cultivo cultivo) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      elevation: 3,
      color: cultivo.bgColor.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: kColorMarronOscuro, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  cultivo.imagenAsset,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 15),
                Text(
                  cultivo.nombre,
                  style: TextStyle( 
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                    fontFamily: 'PixelifySans',
                  ),
                ),
              ],
            ),
            Text(
              cultivo.tiempo,
              style: TextStyle( 
                fontSize: 16,
                color: kColorMarronOscuro,
                fontFamily: 'PixelifySans',
              ),
            ),
          ],
        ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
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
                      'CULTIVO',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kColorMarronOscuro,
                        fontFamily: 'PixelifySans',
                      ),
                    ),
                    const Divider(color: kColorMarronOscuro, thickness: 2, height: 25),
                    ...listaCultivos.map(_buildCultivoRow).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 0),
    );
  }
}