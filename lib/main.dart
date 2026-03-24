import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/providers/auth_provider.dart';
import 'package:flex_yemen/providers/theme_provider.dart';
import 'package:flex_yemen/providers/product_provider.dart';
import 'package:flex_yemen/providers/wallet_provider.dart';
import 'package:flex_yemen/providers/chat_provider.dart';
import 'package:flex_yemen/providers/order_provider.dart';
import 'package:flex_yemen/providers/notification_provider.dart';
import 'package:flex_yemen/services/local_storage_service.dart';
import 'package:flex_yemen/services/notification_service.dart';
import 'package:flex_yemen/screens/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة التخزين المحلي
  await LocalStorageService().init();
  
  // تهيئة الإشعارات
  await NotificationService().init();
  
  // تعيين اتجاه الشاشة
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // تعيين لون شريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flex Yemen',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: Locale('ar'),
            supportedLocales: [
              Locale('ar'),
              Locale('en'),
            ],
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
