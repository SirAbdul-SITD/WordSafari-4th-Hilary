// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/storage_service.dart';
import '../utils/audio_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _sound;
  late bool _music;

  @override
  void initState() {
    super.initState();
    _sound = StorageService.getSoundEnabled();
    _music = StorageService.getMusicEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: AppTheme.primary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _ToggleCard(
                      icon: '🔊',
                      title: 'Sound Effects',
                      subtitle: 'Tap sounds, correct/wrong feedback',
                      value: _sound,
                      onChanged: (v) {
                        setState(() => _sound = v);
                        StorageService.setSoundEnabled(v);
                      },
                    ),
                    const SizedBox(height: 12),
                    _ToggleCard(
                      icon: '🎵',
                      title: 'Background Music',
                      subtitle: 'Ambient game music',
                      value: _music,
                      onChanged: (v) {
                        setState(() => _music = v);
                        StorageService.setMusicEnabled(v);
                        if (v) {
                          AudioService.startMusic();
                        } else {
                          AudioService.stopMusic();
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    _InfoCard(
                      icon: '🪙',
                      title: 'Your Coins',
                      value: StorageService.getCoins().toString(),
                    ),
                    const SizedBox(height: 12),
                    _InfoCard(
                      icon: '⭐',
                      title: 'Total Stars',
                      value: StorageService.getTotalStars().toString(),
                    ),
                    const SizedBox(height: 24),
                    // Version
                    Text(
                      'WordSafari v1.0.0',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 13,
                        color: AppTheme.textLight,
                      ),
                    ),
                    Text(
                      'com.hilaryapps.wordsafari',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: AppTheme.textLight,
                      ),
                    ),
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

class _ToggleCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: AppTheme.cardShadow,
    ),
    child: Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTheme.bodyLarge),
              Text(subtitle, style: AppTheme.bodyMedium),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primary,
        ),
      ],
    ),
  );
}

class _InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const _InfoCard({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: AppTheme.cardShadow,
    ),
    child: Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 14),
        Text(title, style: AppTheme.bodyLarge),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
          ),
        ),
      ],
    ),
  );
}
