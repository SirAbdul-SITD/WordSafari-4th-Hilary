// lib/utils/audio_service.dart
import 'package:audioplayers/audioplayers.dart';
import 'storage_service.dart';

class AudioService {
  static final AudioPlayer _sfxPlayer = AudioPlayer();
  static final AudioPlayer _musicPlayer = AudioPlayer();

  static Future<void> init() async {
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(0.4);
    await _sfxPlayer.setVolume(0.8);
  }

  static Future<void> playTap() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/tap.mp3'));
  }

  static Future<void> playCorrect() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/correct.mp3'));
  }

  static Future<void> playWrong() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/wrong.mp3'));
  }

  static Future<void> playBlast() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/blast.mp3'));
  }

  static Future<void> playLevelComplete() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/level_complete.mp3'));
  }

  static Future<void> playHint() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/hint.mp3'));
  }

  static Future<void> playShuffle() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/shuffle.mp3'));
  }

  static Future<void> playCombo(int streak) async {
    if (!StorageService.getSoundEnabled()) return;
    if (streak >= 5) {
      await _sfxPlayer.play(AssetSource('audio/combo_big.mp3'));
    } else if (streak >= 3) {
      await _sfxPlayer.play(AssetSource('audio/combo.mp3'));
    }
  }

  static Future<void> playGameOver() async {
    if (!StorageService.getSoundEnabled()) return;
    await _sfxPlayer.play(AssetSource('audio/game_over.mp3'));
  }

  static Future<void> startMusic() async {
    if (!StorageService.getMusicEnabled()) return;
    await _musicPlayer.play(AssetSource('audio/bgm.mp3'));
  }

  static Future<void> stopMusic() async {
    await _musicPlayer.stop();
  }

  static Future<void> dispose() async {
    await _sfxPlayer.dispose();
    await _musicPlayer.dispose();
  }
}
