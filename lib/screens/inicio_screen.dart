import 'package:flutter/material.dart';
import '../main.dart';
import 'login_screen.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen>
    with TickerProviderStateMixin {

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut, 
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0, 
    );
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    
    _fadeController.forward();
    _pulseController.repeat(reverse: true); // Repite el pulso
  }

  @override
  void dispose() {
    // Limpiar los controladores
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // --- INICIO DE NUEVO DISEÑO ---
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kColorBeigeFondo, // 1. Fondo coherente con la App
      body: SafeArea(
        child: FadeTransition(
          // 6. Animación de Fade-in aplicada
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // --- 2. Encabezado Gráfico ---
                Container(
                  height: screenHeight * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    // image: DecorationImage(
                    //   // image:
                    //   //     const AssetImage('assets/images/farm_background.png'),
                    //   fit: BoxFit.cover,
                    //   colorFilter: ColorFilter.mode(
                    //     Colors.black.withOpacity(0.2),
                    //     BlendMode.darken,
                    //   ),
                    // ),
                  ),
                  // --- 3. Logo Integrado ---
                  child: Center(
                    child: Container(
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
                        height: screenHeight * 0.2,
                      ),
                    ),
                  ),
                ),

                // --- 4. Contenido de Texto ---
                const SizedBox(height: 40),
                const Text(
                  '¡Bienvenido a la aventura!',
                  style: TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                    fontFamily: 'PixelifySans',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                
                // --- 5. Texto Adicional ---
                Text(
                  'Tu granja te espera. Cosecha, completa logros y conviértete en el mejor granjero.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: kColorMarronOscuro.withOpacity(0.7),
                    fontFamily: 'PixelifySans',
                    height: 1.5, // Interlineado
                  ),
                ),

                const Spacer(),
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    // --- 4. Botón Coherente ---
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorMarronOscuro,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'COMENZAR',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Margen inferior
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}