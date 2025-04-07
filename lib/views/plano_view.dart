import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/capa_button.dart';
import '../widgets/interactive_shape.dart';
import '../data/capa1_data.dart';
import '../data/capa2_data.dart';
import '../data/capa3_data.dart';
import '../data/capa4_data.dart';

class PlanoView extends StatefulWidget {
  final String instalacion;

  const PlanoView({required this.instalacion, super.key});

  @override
  State<PlanoView> createState() => _PlanoViewState();
}

class _PlanoViewState extends State<PlanoView> {
  final List<String> capasSeleccionadas = [];

  // Función para cambiar el estado de las capas (para los botones tradicionales)
  void cambiarCapa(String capa) {
    setState(() {
      if (capasSeleccionadas.contains(capa)) {
        capasSeleccionadas.remove(capa);
      } else {
        capasSeleccionadas.add(capa);
      }
    });
  }

  // Función para mostrar información de un objeto
  void mostrarInfo(String info, String id) {
    Navigator.pushNamed(
      context,
      '/objeto',
      arguments: {'titulo': id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plano interactivo - ${widget.instalacion}'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Fila de botones: se incluye "Consumo Agua" como una capa más
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón "Consumo Agua" usando CapaButton con callback personalizado
                CapaButton(
                  'Consumo Agua',
                  'consumo_agua',
                  Colors.blue, // Puedes ajustar el color
                  (layer) {
                    Navigator.pushNamed(context, '/control_agua');
                  },
                  capasSeleccionadas,
                ),
                // Resto de botones de capas
                CapaButton(
                  'Soleria',
                  'soleria',
                  const Color.fromARGB(255, 67, 177, 233),
                  cambiarCapa,
                  capasSeleccionadas,
                ),
                CapaButton(
                  'Estructura',
                  'estructura',
                  const Color.fromARGB(255, 124, 121, 120),
                  cambiarCapa,
                  capasSeleccionadas,
                ),
                CapaButton(
                  'Fontaneria',
                  'fontaneria',
                  Colors.purpleAccent,
                  cambiarCapa,
                  capasSeleccionadas,
                ),
                CapaButton(
                  'Electricidad',
                  'electricidad',
                  Colors.green,
                  cambiarCapa,
                  capasSeleccionadas,
                ),
              ],
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              alignment: Alignment.center,
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4,
              boundaryMargin: const EdgeInsets.all(20),
              child: Center(
                child: Transform.scale(
                  scale: 3.0,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/planos/plano_casa.svg',
                        fit: BoxFit.contain,
                      ),
                      ..._buildCapas(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCapas() {
    List<Widget> widgets = [];
    if (capasSeleccionadas.contains('soleria')) {
      widgets.addAll(capa1Objetos.map((objeto) {
        return InteractiveShape(
          objeto: objeto,
          onTap: () => mostrarInfo(objeto.info, objeto.id),
        );
      }));
    }
    if (capasSeleccionadas.contains('estructura')) {
      widgets.addAll(capa2Objetos.map((objeto) {
        return InteractiveShape(
          objeto: objeto,
          onTap: () => mostrarInfo(objeto.info, objeto.id),
        );
      }));
    }
    if (capasSeleccionadas.contains('fontaneria')) {
      widgets.addAll(capa3Objetos.map((objeto) {
        return InteractiveShape(
          objeto: objeto,
          onTap: () => mostrarInfo(objeto.info, objeto.id),
        );
      }));
    }
    if (capasSeleccionadas.contains('electricidad')) {
      widgets.addAll(capa4Objetos.map((objeto) {
        return InteractiveShape(
          objeto: objeto,
          onTap: () => mostrarInfo(objeto.info, objeto.id),
        );
      }));
    }
    return widgets;
  }
}
