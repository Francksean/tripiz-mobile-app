import 'package:flutter/material.dart';

class AnimatedPulseMarker extends StatefulWidget {
  final Color color;
  final double size;
  const AnimatedPulseMarker({
    super.key,
    this.color = Colors.blue,
    this.size = 20.0,
  });

  @override
  State<AnimatedPulseMarker> createState() => _AnimatedPulseMarkerState();
}

class _AnimatedPulseMarkerState extends State<AnimatedPulseMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radius;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _radius = Tween<double>(
      begin: widget.size,
      end: widget.size * 3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacity = Tween<double>(
      begin: 0.4,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder:
          (_, __) => Stack(
            alignment: Alignment.center,
            children: [
              // Cercle pulsant (extérieur)
              Container(
                width: _radius.value,
                height: _radius.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withOpacity(_opacity.value),
                ),
              ),
              // Marqueur central
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
