import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'viewmodels/converter_viewmodel.dart';
import 'views/splash_screen.dart';
import 'views/home_screen.dart';
import 'views/conversion_screen.dart';
import 'views/history_screen.dart';
import 'views/settings_screen.dart';
import 'views/about_screen.dart';

void main() {
  runApp(const UniCalcApp());
}

class UniCalcApp extends StatelessWidget {
  const UniCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (context) => ConverterViewModel()..initialize(),
          child: Consumer<ConverterViewModel>(
            builder: (context, viewModel, child) {
              return MaterialApp(
                title: 'UniCalc',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: viewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                initialRoute: '/splash',
                routes: {
                  '/splash': (context) => const SplashScreen(),
                  '/': (context) => const HomeScreen(),
                  '/conversion': (context) => const ConversionScreen(),
                  '/history': (context) => const HistoryScreen(),
                  '/settings': (context) => const SettingsScreen(),
                  '/about': (context) => const AboutScreen(),
                },
                onGenerateRoute: (settings) {
                  // Handle any additional routes if needed
                  return null;
                },
              );
            },
          ),
        );
      },
    );
  }
}