import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'providers/food_provider.dart';
import 'providers/settings_provider.dart';
import 'services/notification_service.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';
import 'utils/app_colors_v2.dart';
import 'utils/app_typography_v2.dart';
import 'utils/app_spacing_v2.dart';
import 'utils/app_shadows_v2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider()..initialize(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodProvider(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,

            // Theme V2 - Feminine & Modern
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: settings.isInitialized
                ? settings.themeMode
                : ThemeMode.system,

            // Home
            home: settings.isInitialized
                ? const HomeScreen()
                : const SplashScreen(),
          );
        },
      ),
    );
  }

  // Build Light Theme V2
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorsV2.roseQuartz,
        brightness: Brightness.light,
        primary: AppColorsV2.roseQuartz,
        secondary: AppColorsV2.lavenderMist,
        surface: AppColorsV2.snowWhite,
        background: AppColorsV2.snowWhite,
      ),
      scaffoldBackgroundColor: AppColorsV2.snowWhite,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsV2.snowWhite,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 2,
        shadowColor: AppColorsV2.roseQuartz.withOpacity(0.1),
        titleTextStyle: AppTypographyV2.titleLarge(
          color: AppColorsV2.charcoalSoft,
        ),
        iconTheme: IconThemeData(
          color: AppColorsV2.charcoalSoft,
          size: AppSpacingV2.iconL,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColorsV2.snowWhite,
        shadowColor: AppColorsV2.roseQuartz.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacingV2.borderXl,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacingV2.l,
          vertical: AppSpacingV2.s,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColorsV2.roseQuartz,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacingV2.borderFull,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacingV2.l,
            vertical: AppSpacingV2.m,
          ),
          textStyle: AppTypographyV2.labelLarge(color: Colors.white),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorsV2.roseQuartz,
          side: BorderSide(color: AppColorsV2.roseQuartz, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacingV2.borderFull,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacingV2.l,
            vertical: AppSpacingV2.m,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsV2.snowWhite,
        border: OutlineInputBorder(
          borderRadius: AppSpacingV2.borderM,
          borderSide: BorderSide(color: AppColorsV2.doveGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacingV2.borderM,
          borderSide: BorderSide(
            color: AppColorsV2.doveGray.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacingV2.borderM,
          borderSide: BorderSide(color: AppColorsV2.roseQuartz, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacingV2.borderM,
          borderSide: BorderSide(color: AppColorsV2.statusExpiredBorder, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacingV2.l,
          vertical: AppSpacingV2.m,
        ),
        hintStyle: AppTypographyV2.bodyMedium(
          color: AppColorsV2.slateMuted,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColorsV2.roseQuartz,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacingV2.borderFull,
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColorsV2.doveGray.withOpacity(0.3),
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: AppColorsV2.charcoalSoft,
        size: AppSpacingV2.iconM,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypographyV2.heroLarge(),
        displayMedium: AppTypographyV2.heroMedium(),
        titleLarge: AppTypographyV2.titleLarge(),
        titleMedium: AppTypographyV2.titleMedium(),
        titleSmall: AppTypographyV2.titleSmall(),
        bodyLarge: AppTypographyV2.bodyLarge(),
        bodyMedium: AppTypographyV2.bodyMedium(),
        bodySmall: AppTypographyV2.bodySmall(),
        labelLarge: AppTypographyV2.labelLarge(),
        labelMedium: AppTypographyV2.labelMedium(),
        labelSmall: AppTypographyV2.labelSmall(),
      ),
    );
  }

  // Build Dark Theme V2 (Optional)
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorsV2.roseQuartz,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF1A1D23),
    );
  }
}

// Splash screen hiển thị trong khi khởi tạo
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsV2.snowWhite,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColorsV2.snowWhite,
              AppColorsV2.pearlGray.withOpacity(0.3),
              AppColorsV2.roseQuartz.withOpacity(0.1),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Cute icon with gradient
              Container(
                padding: EdgeInsets.all(AppSpacingV2.xxl),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColorsV2.gradientPrimary,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: AppShadowsV2.strong,
                ),
                child: const Text(
                  '🧊',
                  style: TextStyle(fontSize: 80),
                ),
              ),
              AppSpacingV2.gapXxl,

              // App name with gradient text effect
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: AppColorsV2.gradientPrimary,
                ).createShader(bounds),
                child: Text(
                  AppConstants.appName,
                  style: AppTypographyV2.heroLarge(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppSpacingV2.gapS,

              // Subtitle
              Text(
                'Quản lý thực phẩm thông minh ✨',
                style: AppTypographyV2.bodyMedium(
                  color: AppColorsV2.slateMuted,
                ),
              ),
              AppSpacingV2.gapXxl,

              // Loading indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColorsV2.roseQuartz,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
