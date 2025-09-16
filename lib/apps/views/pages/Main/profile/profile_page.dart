// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Bagian Header ---
            _buildHeader(),

            // --- Bagian Konten (Kartu) ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSettingsCard(
                    title: 'General',
                    items: [
                      _buildSettingsItem(
                        icon: PhosphorIconsRegular.user,
                        title: 'Edit Profile',
                        subtitle:
                            'Ubah foto, nama, email, dan info dasar akunmu.',
                        onTap: () {
                          context.push('/edit-profile');
                        },
                      ),
                      _buildSettingsItem(
                        icon: PhosphorIconsRegular.lock,
                        title: 'Changes Password',
                        subtitle: 'Perbarui password untuk menjaga keamanan.',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsCard(
                    title: 'Preferences',
                    items: [
                      _buildSettingsItem(
                        icon: PhosphorIconsRegular.info,
                        title: 'FAQ',
                        subtitle:
                            'Jawaban dari pertanyaan yang sering ditanyakan.',
                        onTap: () {},
                      ),
                      _buildSettingsItem(
                        icon: PhosphorIconsRegular.signOut,
                        title: 'Logout',
                        subtitle: 'Keluar dari akunmu dengan aman.',
                        onTap: () {
                          context.go('/sign-in');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget untuk membuat bagian header profil.
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 32),
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.contrast),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
            backgroundColor: AppColors.background,
          ),
          SizedBox(height: 16),
          Text(
            'Kiplinyu',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteText,
              fontFamily: 'SFUI',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Kiplinyu@gmail.com',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.placeholder,
              fontFamily: 'SFUI',
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk membuat kartu pengaturan.
  Widget _buildSettingsCard({
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.placeholder,
              fontFamily: 'SFUI',
            ),
          ),
          const SizedBox(height: 8),
          ...items,
        ],
      ),
    );
  }

  /// Widget untuk membuat satu item di dalam kartu pengaturan.
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.text),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'SFUI',
          color: AppColors.text,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.placeholder,
          fontFamily: 'SFUI',
        ),
      ),
      trailing: const Icon(
        PhosphorIconsRegular.caretRight,
        color: AppColors.placeholder,
      ),
      onTap: onTap,
    );
  }
}
