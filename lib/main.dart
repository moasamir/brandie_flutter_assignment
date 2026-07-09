import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/quick_share/presentation/pages/quick_share_page.dart';

void main() {
  runApp(const BrandieApp());
}

class BrandieApp extends StatelessWidget {
  const BrandieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brandie Task',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const QuickSharePage(),
    );
  }
}
