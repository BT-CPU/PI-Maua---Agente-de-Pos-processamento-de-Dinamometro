import 'package:flutter/material.dart';

import 'screens/app_shell.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const DynamometerApp());
}

class DynamometerApp extends StatelessWidget {
  const DynamometerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamometer Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const AppShell(),
    );
  }
}
