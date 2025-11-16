// lib/features/shared/presentation/widgets/top_bar.dart

import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onProfileTap;

  const TopBar({
    Key? key,
    required this.title,
    this.onNotificationTap,
    this.onSettingsTap,
    this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0A1F3D),
      elevation: 0,
      title: Row(
        children: [
          // Logo desde Assets
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'lib/assets/images/logo.png',  // ← TU IMAGEN
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              // Si la imagen no existe, muestra un fallback
              errorBuilder: (context, error, stackTrace) {
                return _buildFallbackLogo();
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        // Notification Icon
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined, color: Colors.white),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: onNotificationTap ?? () {},
        ),
        // Settings Icon
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: onSettingsTap ?? () {},
        ),
        // Profile Icon
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.white),
          onPressed: onProfileTap ?? () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // Fallback si la imagen no carga
  Widget _buildFallbackLogo() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF00D9A3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'B',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
