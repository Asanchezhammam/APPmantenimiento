import 'package:flutter/material.dart';
import '../models/objeto_capa.dart';

class InteractiveShape extends StatefulWidget {
  final ObjetoCapa objeto;
  final VoidCallback onTap;

  const InteractiveShape({required this.objeto, required this.onTap, super.key});

  @override
  State<InteractiveShape> createState() => _InteractiveShapeState();
}

class _InteractiveShapeState extends State<InteractiveShape> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _colorPorCapa(String id) {
    if (id.startsWith('sol')) return Colors.blue;
    if (id.startsWith('muro')) return Colors.orange;
    if (id.startsWith('font')) return Colors.purple;
    if (id.startsWith('elec')) return Colors.green;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _colorPorCapa(widget.objeto.id);

    return Positioned(
      left: widget.objeto.posicion.dx,
      top: widget.objeto.posicion.dy,
      child: FadeTransition(
        opacity: _opacity,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: widget.objeto.tamanio.width,
              height: widget.objeto.tamanio.height,
              decoration: BoxDecoration(
                color: baseColor.withOpacity(_hovering ? 0.8 : 0.5),
                border: Border.all(
                  color: _hovering ? Colors.black : Colors.black45,
                  width: _hovering ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(_hovering ? 8 : 6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
