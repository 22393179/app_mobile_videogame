import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'menu_screen.dart';
import 'package:image_picker/image_picker.dart';

// ======================================================
// PERFIL SCREEN
// ======================================================
class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Map<String, dynamic>? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await AuthService().getUserProfile();
    setState(() {
      user = data?['user'];
      loading = false;
    });
  }

  // ======================================================
  // LOGOUT BONITO
  // ======================================================
  Future<void> _logout() async {
    await AuthService().logout();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Has cerrado sesión",
          style: TextStyle(fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (_) => false,
        );
      }
    });
  }

  // ======================================================
  // SUBIR FOTO
  // ======================================================
  Future<void> _changePhoto() async {
    final picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (img == null) return;

    final url = await AuthService().uploadProfilePhoto(img.path);

    if (url == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error al subir foto")));
      return;
    }

    setState(() => user!['photoURL'] = url);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Foto actualizada")));
  }

  // ======================================================
  // ELIMINAR FOTO
  // ======================================================
  Future<void> _deletePhoto() async {
    final ok = await AuthService().deleteProfilePhoto();

    if (ok) {
      setState(() => user!['photoURL'] = "");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Foto eliminada")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error al eliminar foto")));
    }
  }

  // ======================================================
  // BOTÓN REDONDO PARA FOTO
  // ======================================================
  Widget _circleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }

  // ======================================================
  // HELPERS: avatar and experience sections (refactor)
  // ======================================================
  Widget _buildAvatarSection(String? photoUrl, String letter, Color brown, Color green) {
    return Column(
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.20,
          backgroundColor: brown.withOpacity(0.5),
          child: (photoUrl != null && photoUrl.isNotEmpty)
              ? ClipOval(
                  child: Image.network(
                    photoUrl,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.width * 0.40,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.white70,
                        ),
                      );
                    },
                  ),
                )
              : Text(
                  letter,
                  style: const TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontFamily: 'PixelifySans',
                  ),
                ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circleButton(
              icon: Icons.camera_alt,
              color: green,
              onTap: _changePhoto,
            ),
            if (photoUrl != null && photoUrl.isNotEmpty) ...[
              const SizedBox(width: 14),
              _circleButton(
                icon: Icons.delete,
                color: Colors.red,
                onTap: () => showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Eliminar foto"),
                    content: const Text("¿Seguro que deseas eliminar tu foto?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                          _deletePhoto();
                        },
                        child: const Text("Eliminar"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceSection(Map<String, dynamic> profile, Color brown, Color green, Color gold, Color lightGray) {
    final int level = profile['level'] ?? 1;
    final int xp = profile['xp'] ?? 0;
    final int xpTarget = 2000;
    final double xpProgress = (xpTarget > 0) ? (xp / xpTarget).clamp(0.0, 1.0) : 0.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 110,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: gold,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8)],
                ),
                alignment: Alignment.center,
                child: Text(
                  '$level',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: brown,
                    fontFamily: 'PixelifySans',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nivel',
                style: TextStyle(
                  color: brown.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'PixelifySans',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Experiencia',
                      style: TextStyle(
                        color: brown.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PixelifySans',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.star, size: 14, color: gold),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            '$xp / $xpTarget XP',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: brown.withOpacity(0.8),
                              fontFamily: 'PixelifySans',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  minHeight: 16,
                  value: xpProgress,
                  backgroundColor: lightGray.withOpacity(0.6),
                  valueColor: AlwaysStoppedAnimation<Color>(green),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                xpProgress >= 1.0 ? '¡Listo para subir de nivel!' : '${(xpProgress * 100).toInt()}% hacia siguiente nivel',
                style: TextStyle(
                  color: brown.withOpacity(0.75),
                  fontFamily: 'PixelifySans',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ======================================================
  // ROW INFO
  // ======================================================
  Widget _rowInfo(String label, String value, Color brown) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: brown.withOpacity(0.75),
              fontFamily: 'PixelifySans',
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: brown,
                fontFamily: 'PixelifySans',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // INICIAL SEGURA
  // ======================================================
  String _getInitial(String name) {
    if (name.trim().isEmpty) return "J";
    return name.trim()[0].toUpperCase();
  }

  // ======================================================
  // BUILD
  // ======================================================
  @override
  Widget build(BuildContext context) {
    const crema = Color(0xFFF5EFE6);
    const brown = Color(0xFF6B4B3E);
    const green = Color(0xFF8BC34A);
    const gold = Color(0xFFFFB74D);
    const lightGray = Color(0xFFE0E0E0);

    if (loading) {
      return const Scaffold(
        backgroundColor: crema,
        body: Center(child: CircularProgressIndicator(color: brown)),
      );
    }

    final photoUrl = user?['photoURL'];
    final profile = user?['profile'] ?? {};
    final displayName = user?['displayName'] ?? 'Jugador';
    final letter = _getInitial(displayName);

    return Scaffold(
      backgroundColor: crema,
      appBar: AppBar(
        backgroundColor: crema,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: brown),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MenuScreen()),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: brown),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar + action buttons (extracted)
            _buildAvatarSection(photoUrl, letter, brown, green),

            const SizedBox(height: 50),

            Text(
              displayName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: brown,
                fontFamily: 'PixelifySans',
              ),
            ),

            const SizedBox(height: 24),

            // Nivel y barra de experiencia (extraído)
            _buildExperienceSection(profile, brown, green, gold, lightGray),

            const SizedBox(height: 28),

            // INFO DE CUENTA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Información de la Cuenta",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: brown,
                      fontFamily: 'PixelifySans',
                    ),
                  ),
                  Divider(color: brown.withOpacity(0.2)),
                  _rowInfo("Email", user?['email'] ?? "", brown),
                  Divider(color: brown.withOpacity(0.1)),
                  _rowInfo("UID", user?['uid'] ?? "", brown),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
