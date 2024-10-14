import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedCircularProgress extends StatefulWidget {
  final double currentStep;
  final double totalSteps;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  const AnimatedCircularProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 10.0,
  });

  @override
  _AnimatedCircularProgressState createState() => _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.currentStep / widget.totalSteps,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentStep != oldWidget.currentStep ||
        widget.totalSteps != oldWidget.totalSteps) {
      _controller.reset();
      _animation = Tween<double>(
        begin: 0,
        end: widget.currentStep / widget.totalSteps,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size.square(200.0),
          painter: CircularProgressPainter(
            progress: _animation.value,
            progressColor: widget.progressColor,
            backgroundColor: widget.backgroundColor,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = -pi / 2; // Starting point at the top
    final sweepAngle = 2 * pi * progress; // Arc based on progress

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawArc(
      rect,
      0.0,
      2 * pi,
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
