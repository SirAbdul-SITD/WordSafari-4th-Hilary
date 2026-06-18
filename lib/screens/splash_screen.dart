// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/audio_service.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _ctrl, _textCtrl;
  late Animation<double> _scale, _fade, _textFade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..forward();
    _scale = Tween<double>(begin: 0.2, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade  = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0, 0.4)));
    _textCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _textFade  = CurvedAnimation(parent: _textCtrl, curve: Curves.easeIn);
    _run();
  }

  Future<void> _run() async {
    await Future.delayed(const Duration(milliseconds: 700));
    _textCtrl.forward();
    AudioService.startMusic();
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) Navigator.pushReplacement(context, PageRouteBuilder(
      pageBuilder: (_,__,___) => const MenuScreen(),
      transitionsBuilder: (_,anim,__,child) => FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 500),
    ));
  }

  @override void dispose() { _ctrl.dispose(); _textCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AnimatedBuilder(animation: _ctrl, builder: (_,__) => Opacity(opacity: _fade.value,
          child: Transform.scale(scale: _scale.value,
            child: Container(width:130,height:130,
              decoration: BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.circular(36), boxShadow: AppTheme.buttonShadow(AppTheme.primary)),
              child: const Center(child: Text('🟧', style: TextStyle(fontSize:68))),
            ),
          ),
        )),
        const SizedBox(height: 28),
        FadeTransition(opacity: _textFade, child: Column(children: [
          RichText(text: TextSpan(style: const TextStyle(fontFamily:'Nunito',fontSize:46,fontWeight:FontWeight.w800), children: [
            TextSpan(text: 'Word', style: const TextStyle(color: Color(0xFFFF4D94))),
            TextSpan(text: 'Safari', style: const TextStyle(color: Color(0xFFFFD60A))),
          ])),
          const SizedBox(height: 8),
          Text('Block by Block. Word by Word.', style: const TextStyle(fontFamily:'Nunito',fontSize:15,color:AppTheme.textMedium,fontWeight:FontWeight.w600)),
          const SizedBox(height: 52),
          SizedBox(width:32,height:32,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary.withOpacity(0.7)),strokeWidth:3)),
        ])),
      ])),
    ),
  );
}
