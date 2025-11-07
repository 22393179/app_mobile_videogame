import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'menu_screen.dart'; // <--- Importa tu MenuScreen

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Map<String, dynamic>? userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await AuthService().getUserProfile();
    setState(() {
      userData = data;
      _loading = false;
    });
  }

  Future<void> _logout() async {
    await AuthService().logout();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text("Has cerrado sesión desde tu perfil")),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // Pequeño delay para que se vea el SnackBar antes de ir al login
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  // --- Tarjeta de estadísticas ---
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color kColorVerdeClaro,
    Color kColorMarronOscuro,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: kColorVerdeClaro, size: 20),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: kColorMarronOscuro.withOpacity(0.8),
                    fontFamily: 'PixelifySans',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: kColorMarronOscuro,
              fontFamily: 'PixelifySans',
            ),
          ),
        ],
      ),
    );
  }

  // --- Fila de información ---
  Widget _buildInfoRow(String label, String value, Color kColorMarronOscuro) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: kColorMarronOscuro.withOpacity(0.7),
                fontFamily: 'PixelifySans',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kColorMarronOscuro,
                fontFamily: 'PixelifySans',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Colores ---
    const kColorCrema = Color(0xFFF5EFE6);
    const kColorMarronOscuro = Color(0xFF6B4B3E);
    const kColorVerdeClaro = Color(0xFF8BC34A);

    if (_loading) {
      return const Scaffold(
        backgroundColor: kColorCrema,
        body: Center(
          child: CircularProgressIndicator(color: kColorMarronOscuro),
        ),
      );
    }

    final auth = userData?['auth'] ?? {};
    final profile = userData?['profile'] ?? {};
    final stats = profile['profile'] ?? {};
    final String displayName =
        auth['name'] ?? profile['displayName'] ?? 'Jugador';
    final String displayLetter =
        displayName.isNotEmpty ? displayName[0].toUpperCase() : 'J';

    return Scaffold(
      backgroundColor: kColorCrema,
      appBar: AppBar(
        backgroundColor: kColorCrema,
        elevation: 0,
        iconTheme: const IconThemeData(color: kColorMarronOscuro),
        // Flecha de regreso manda al MenuScreen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kColorMarronOscuro),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: kColorMarronOscuro),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.18,
                backgroundColor: kColorMarronOscuro,
                child: Text(
                  displayLetter,
                  style: const TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontFamily: 'PixelifySans',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                displayName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kColorMarronOscuro,
                  fontFamily: 'PixelifySans',
                ),
              ),
              const SizedBox(height: 30),
              // Tarjetas de estadísticas
              Row(
                children: [
                  Flexible(
                    child: _buildStatCard(
                        'NIVEL',
                        '${stats['level'] ?? 1}',
                        Icons.star_border_outlined,
                        kColorVerdeClaro,
                        kColorMarronOscuro),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: _buildStatCard(
                        'EXPERIENCIA',
                        '${stats['xp'] ?? 0}',
                        Icons.trending_up_rounded,
                        kColorVerdeClaro,
                        kColorMarronOscuro),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Contenedor de información
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Información de la Cuenta',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kColorMarronOscuro,
                          fontFamily: 'PixelifySans',
                        ),
                      ),
                    ),
                    Divider(color: kColorMarronOscuro.withOpacity(0.2)),
                    _buildInfoRow('Email', '${auth['email'] ?? ''}', kColorMarronOscuro),
                    Divider(height: 1, color: kColorMarronOscuro.withOpacity(0.1)),
                    _buildInfoRow('UID', '${auth['uid'] ?? ''}', kColorMarronOscuro),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
