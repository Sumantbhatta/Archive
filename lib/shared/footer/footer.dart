import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// Make sure these imports point to your project's theme and constants
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/core/constant.dart';

// ===================================================================
// Main Footer Widget
// ===================================================================
class Footer extends StatelessWidget {
  final Function(int) onSectionTap;

  const Footer({
    super.key,
    required this.onSectionTap,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Removed padding to allow it to be flush with screen edges
    return Container(
      color: AppColors.bgDark,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. Enhanced Green Aura ✨
          _buildAura(),

          // 2. Main Console Body (now full-width)
          _buildConsoleBody(context),
        ],
      ),
    );
  }

  /// Builds the semi-circle green glow behind the console.
  Widget _buildAura() {
    return Transform.translate(
      offset: const Offset(0, 30),
      child: Container(
        width: 600, // Made the base width of the glow wider
        height: 150,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.5),
              // Increased blur and spread for a wider, more acquired glow
              blurRadius: 150,
              spreadRadius: 45,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the main dark container that holds all the elements.
  Widget _buildConsoleBody(BuildContext context) {
    return Container(
      // Changed to double.infinity for a full-width design
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 1,
            spreadRadius: -1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildKeyboardSection(),
          const SizedBox(width: 20),
          const Expanded(child: _GrillSection()),
          const SizedBox(width: 20),
          _CRTScreenSection(),
        ],
      ),
    );
  }

  /// Builds the left-hand side keyboard section.
  Widget _buildKeyboardSection() {
    // This section remains the same, but the keys inside now have hover animations
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _KeyButton(text: 'HOME', onTap: () => onSectionTap(0)),
            const SizedBox(width: 8),
            _KeyButton(text: 'CV', onTap: () => onSectionTap(1), keyColor: const Color(0xFF4A4A4A)),
            const SizedBox(width: 8),
            _KeyButton(
              text: 'IG',
              tooltip: 'Instagram',
              onTap: () => _launchUrl('https://instagram.com'),
              gradient: const LinearGradient(
                colors: [Color(0xFFF9CE34), Color(0xFFEE2A7B), Color(0xFF6228D7)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _KeyButton(text: '@', tooltip: 'Email', onTap: () => _launchUrl('mailto:contact@example.com'), keyColor: const Color(0xFFB9A488)),
            const SizedBox(width: 8),
            _KeyButton(text: 'HIRE ME', onTap: () => onSectionTap(5), keyColor: const Color(0xFF4A4A4A)),
            const SizedBox(width: 8),
            _KeyButton(text: 'X', tooltip: 'Example Link', onTap: () {}, keyColor: const Color(0xFF4A4A4A)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _KeyButton(text: 'CALL ME', onTap: () => _launchUrl('tel:+1234567890')),
            const SizedBox(width: 8),
            _KeyButton(text: 'DB', tooltip: 'Dribbble', onTap: () => _launchUrl('https://dribbble.com'), keyColor: const Color(0xFFEA4C89)),
            const SizedBox(width: 8),
            _KeyButton(text: 'BH', tooltip: 'Behance', onTap: () => _launchUrl('https://behance.net'), keyColor: const Color(0xFF053EFF)),
          ],
        ),
      ],
    );
  }
}

// ===================================================================
// Helper Widgets
// ===================================================================

class _GrillSection extends StatelessWidget {
  const _GrillSection();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          18,
              (index) => Container(
            height: 2,
            margin: const EdgeInsets.symmetric(vertical: 2.5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}

/// The CRT screen display with your custom glowing image logo. 🖼️
class _CRTScreenSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const screenColor = Color(0xFF39FF14); // Neon green

    return Container(
      width: 170,
      height: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              border: Border.all(color: const Color(0xFF101010), width: 4),
              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 5)],
            ),
            child: ClipOval(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background glow for the whole screen
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [screenColor.withOpacity(0.3), Colors.transparent],
                        stops: const [0.3, 1.0],
                      ),
                    ),
                  ),

                  // Your custom image logo with glow effect
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // The "Glow" layer (a blurred, colored version of the image)
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Image.asset(
                            'assets/images/image.png',
                            color: screenColor.withOpacity(0.8),
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                        // The "Top" layer (the sharp image)
                        Image.asset(
                          'assets/images/image.png',
                          color: screenColor,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ],
                    ),
                  ),

                  // Scanline Overlay
                  RepaintBoundary(child: _ScanLineEffect()),
                ],
              ),
            ),
          ),
          // Screws
          Positioned(top: 0, left: 0, child: _buildScrew()),
          Positioned(top: 0, right: 0, child: _buildScrew()),
          Positioned(bottom: 0, left: 0, child: _buildScrew()),
          Positioned(bottom: 0, right: 0, child: _buildScrew()),
        ],
      ),
    );
  }

  Widget _buildScrew() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFF454545),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black.withOpacity(0.7), width: 1),
      ),
    );
  }
}

class _ScanLineEffect extends StatefulWidget {
  @override
  State<_ScanLineEffect> createState() => _ScanLineEffectState();
}

class _ScanLineEffectState extends State<_ScanLineEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: _ScanLinePainter(_controller.value),
      ),
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  final double progress;
  _ScanLinePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final scanLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 2.0;
    final y = size.height * progress;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), scanLinePaint);
  }

  @override
  bool shouldRepaint(covariant _ScanLinePainter oldDelegate) => oldDelegate.progress != progress;
}

/// A 3D key button with press AND hover animations.
class _KeyButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? keyColor;
  final Gradient? gradient;
  final String? tooltip;

  const _KeyButton({
    required this.text,
    required this.onTap,
    this.keyColor,
    this.gradient,
    this.tooltip,
  });

  @override
  State<_KeyButton> createState() => _KeyButtonState();
}

class _KeyButtonState extends State<_KeyButton> {
  bool _isPressed = false;
  bool _isHovered = false; // New state for hover

  void _onTapDown(TapDownDetails details) => setState(() {
    _isPressed = true;
    HapticFeedback.lightImpact();
  });

  void _onTapUp(TapUpDetails details) => setState(() {
    _isPressed = false;
    widget.onTap();
  });

  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final keyFaceColor = widget.keyColor ?? const Color(0xFF3A3A3A);
    final keySideColor = Color.lerp(keyFaceColor, Colors.black, 0.4)!;
    const keyHeight = 8.0;
    final topPadding = _isPressed ? keyHeight : 0.0;
    final bottomPadding = _isPressed ? 0.0 : keyHeight;

    final keyFace = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: widget.gradient == null ? keyFaceColor : null,
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          shadows: [Shadow(color: Colors.black, blurRadius: 2, offset: Offset(1, 1))],
        ),
      ),
    );

    final keyBody = Container(
      decoration: BoxDecoration(
        color: keySideColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 2, spreadRadius: 1)],
      ),
      child: keyFace,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        // The new hover animation
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
            child: keyBody,
          ),
        ),
      ),
    );
  }
}