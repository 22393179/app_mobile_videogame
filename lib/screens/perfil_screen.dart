import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

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
        const SnackBar(content: Text("Sesión cerrada correctamente")),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Widget _buildResumenDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: kColorMarronOscuro,
              fontFamily: 'PixelifySans',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kColorMarronOscuro,
              fontFamily: 'PixelifySans',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final auth = userData?['auth'] ?? {};
    final profile = userData?['profile'] ?? {};
    final stats = profile['profile'] ?? {}; // nivel, xp, etc.

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/thelastfarm.png', height: 40),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
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
              // Avatar
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.18,
                backgroundColor: kColorMarronOscuro,
                child: const Icon(Icons.person, size: 70, color: Colors.white),
              ),
              const SizedBox(height: 15),

              // Nombre del jugador
              Text(
                auth['name'] ?? profile['displayName'] ?? 'Jugador',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kColorMarronOscuro,
                  fontFamily: 'PixelifySans',
                ),
              ),

              const SizedBox(height: 40),

              // Contenedor de resumen
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
                    const Divider(
                      color: kColorMarronOscuro,
                      thickness: 2,
                      height: 25,
                    ),
                    _buildResumenDetail('Nivel', '${stats['level'] ?? 1}'),
                    _buildResumenDetail('Experiencia (XP)', '${stats['xp'] ?? 0}'),
                    _buildResumenDetail('Email', '${auth['email'] ?? ''}'),
                    _buildResumenDetail('UID', '${auth['uid'] ?? ''}'),
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
