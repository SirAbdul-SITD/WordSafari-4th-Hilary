// lib/screens/daily_challenge_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../theme/app_theme.dart';
import '../utils/storage_service.dart';
import '../data/word_bank.dart';
import 'game_screen.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});
  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen> {
  late String _todayWord;
  late String _todayCategory;
  bool _alreadyPlayed = false;

  @override
  void initState() {
    super.initState();
    _generateDailyChallenge();
  }

  void _generateDailyChallenge() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final cats = WordBank.allCategories;
    _todayCategory = cats[dayOfYear % cats.length];
    final words = WordBank.getWordsForLevel(_todayCategory, (dayOfYear % 10) + 1);
    _todayWord = words[dayOfYear % words.length];
    // ignore: unused_local_variable
    final key = 'daily_${now.year}_${now.month}_${now.day}';
    _alreadyPlayed = StorageService.getLevelProgress(_todayCategory, 99).isUnlocked;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(width: 42, height: 42,
                      decoration: BoxDecoration(color: AppTheme.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                      child: const Icon(Icons.arrow_back_rounded, color: AppTheme.purple)),
                  ),
                  const SizedBox(width: 16),
                  const Text('Daily Challenge', style: TextStyle(fontFamily: 'Fredoka', fontSize: 26, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                ]),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(28),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  children: [
                    const Text('📅', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 16),
                    Text('${now.day}/${now.month}/${now.year}', style: const TextStyle(fontFamily: 'Nunito', fontSize: 16, color: AppTheme.textMedium, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('Category: $_todayCategory', style: const TextStyle(fontFamily: 'Fredoka', fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                    const SizedBox(height: 8),
                    Text('${_todayWord.length} letter word', style: const TextStyle(fontFamily: 'Nunito', fontSize: 15, color: AppTheme.textMedium)),
                    const SizedBox(height: 24),
                    if (_alreadyPlayed)
                      const Text('✅ Already played today!\nCome back tomorrow.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Nunito', fontSize: 16, color: AppTheme.green, fontWeight: FontWeight.w700))
                    else
                      GestureDetector(
                        onTap: () {
                          context.read<GameProvider>().startClassicLevel(_todayCategory, 5);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen()));
                        },
                        child: Container(
                          width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(gradient: AppTheme.blitzGradient, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.buttonShadow(AppTheme.purple)),
                          child: const Center(child: Text('Play Today\'s Challenge', style: TextStyle(fontFamily: 'Fredoka', fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white))),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
