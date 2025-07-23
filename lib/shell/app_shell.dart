import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grain/grain.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/shared/widgets/asset_loading_screen.dart';
import 'package:polymorphism/shared/widgets/curtain_loader.dart';
import 'package:polymorphism/shell/controllers/app_shell_controller.dart';

class AppShell extends StatefulWidget {
  // It now accepts a child widget to display.
  final Widget child;

  const AppShell({
    super.key,
    required this.child,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _fadeController, curve: const Interval(0, 0.8, curve: Curves.easeOutCubic)));
    _scaleAnimation = Tween<double>(begin: 0.98, end: 1).animate(CurvedAnimation(parent: _fadeController, curve: const Interval(0.2, 1, curve: Curves.easeOutCubic)));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onCurtainComplete() {
    Get.find<AppShellController>().onCurtainComplete();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _fadeController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppShellController>();

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Obx(() {
        if (controller.isPreloading.value) {
          return const AssetLoadingScreen();
        }
        if (controller.showCurtainLoader.value && !controller.isReady.value) {
          return CurtainLoader(onComplete: _onCurtainComplete);
        }
        return AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) => Opacity(
            opacity: controller.isReady.value ? _fadeAnimation.value : 0.0,
            child: Transform.scale(
              scale: controller.isReady.value ? _scaleAnimation.value : 0.98,
              // It now displays the child that was passed in from main.dart
              child: GrainFiltered(child: widget.child),
            ),
          ),
        );
      }),
    );
  }
}
