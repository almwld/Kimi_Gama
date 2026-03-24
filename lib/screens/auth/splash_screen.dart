import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/providers/auth_provider.dart';
import 'package:flex_yemen/screens/auth/login_screen.dart';
import 'package:flex_yemen/screens/home/main_navigation.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );
    
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeIn,
      ),
    );
    
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeIn,
      ),
    );
    
    _startAnimation();
    _navigateToNext();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(milliseconds: 300));
    _logoController.forward();
    
    await Future.delayed(Duration(milliseconds: 800));
    _textController.forward();
  }

  void _navigateToNext() async {
    await Future.delayed(Duration(seconds: 3));
    
    if (!mounted) return;
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainNavigation()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark 
                ? [AppColors.darkBg, AppColors.darkSurface]
                : [AppColors.lightBg, Colors.white],
          ),
        ),
        child: Stack(
          children: [
            // دوائر متحركة في الخلفية
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.goldPrimary.withOpacity(0.1),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .scale(duration: 3.seconds, begin: Offset(0.8, 0.8), end: Offset(1.2, 1.2))
                .then()
                .scale(duration: 3.seconds, begin: Offset(1.2, 1.2), end: Offset(0.8, 0.8)),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.goldLight.withOpacity(0.08),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .scale(duration: 4.seconds, begin: Offset(1.1, 1.1), end: Offset(0.9, 0.9))
                .then()
                .scale(duration: 4.seconds, begin: Offset(0.9, 0.9), end: Offset(1.1, 1.1)),
            ),
            
            // المحتوى الرئيسي
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الشعار
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoOpacity.value,
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.goldPrimary,
                                  AppColors.goldLight,
                                  AppColors.goldAccent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.goldPrimary.withOpacity(0.4),
                                  blurRadius: 30,
                                  offset: Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.shopping_bag,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 40),
                  
                  // اسم التطبيق
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textOpacity.value,
                        child: Column(
                          children: [
                            Text(
                              'FLEX YEMEN',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'منصة التجارة الإلكترونية اليمنية',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                fontSize: 16,
                                color: isDark 
                                    ? Colors.white70 
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 60),
                  
                  // مؤشر التحميل
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textOpacity.value,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.goldPrimary,
                            ),
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            // النسخة في الأسفل
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textOpacity.value,
                    child: Text(
                      'الإصدار 1.0.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
