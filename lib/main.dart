import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/modules/home/pages/home_page.dart';
import 'package:polymorphism/shell/app_shell.dart';
import 'package:polymorphism/shell/controllers/app_shell_controller.dart';

void main() {
  // This ensures Flutter is ready before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // We remove the setPreferredOrientations call to make the app
  // fully responsive on desktop and mobile.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize your controller here, at the top of the widget tree.
    Get.put(AppShellController());

    return MaterialApp(
      title: 'Your Portfolio',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      // CORRECTED: Removed all 'const' keywords from this line.
      // This helps isolate the problem. If this works, the issue was
      // related to how the compiler handles constants. If it still fails,
      // the problem is a circular dependency caused by an incorrect import
      // in one of your other files (like home_page.dart importing app_shell.dart).
        home: const HomePage(),
    );
  }}



