import 'package:flutter/material.dart';

class CapaButton extends StatelessWidget {
  final String label;
  final String capaKey;
  final Color color;
  final Function(String) onTap;
  final List<String> activas;

  const CapaButton(
    this.label,
    this.capaKey,
    this.color,
    this.onTap,
    this.activas, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool activa = activas.contains(capaKey);

    return ElevatedButton(
      onPressed: () => onTap(capaKey),
      style: ElevatedButton.styleFrom(
        backgroundColor: activa ? color : color.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
