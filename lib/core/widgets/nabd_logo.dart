import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// شعار Nabd: مربع بنفسجي بزوايا مستديرة، فيه خط نبض (ECG) أبيض ونقطة Mint.
class NabdLogo extends StatelessWidget {
  const NabdLogo({super.key, this.size = 96});

  /// طول وعرض المربع (نكبّرو ونصغّرو الشعار من هنا).
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x335B4BDB), // البنفسجي بشفافية 20%
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _PulsePainter(),
      ),
    );
  }
}

/// يرسم خط النبض والنقطة. كل الأرقام نسب من حجم الشعار (w = العرض، h = الارتفاع).
class _PulsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.06
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(w * 0.16, h * 0.52)
      ..lineTo(w * 0.34, h * 0.52)
      ..lineTo(w * 0.42, h * 0.34)
      ..lineTo(w * 0.52, h * 0.68)
      ..lineTo(w * 0.60, h * 0.46)
      ..lineTo(w * 0.66, h * 0.52)
      ..lineTo(w * 0.72, h * 0.52);

    canvas.drawPath(path, linePaint);

    canvas.drawCircle(
      Offset(w * 0.81, h * 0.52),
      w * 0.045,
      Paint()..color = AppColors.accentMint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}