import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/info_mock.dart';

class ObjetoView extends StatelessWidget {
  final String titulo;

  const ObjetoView({required this.titulo, super.key});

  final int estadoGeneral = 80;
  final int humedad = 98;
  final int temperatura = 25;

  final List<List<String>> materiales = const [
    ['Nombre', 'Material'],
    ['Estructura', 'Hormigón armado'],
    ['Revestimiento', 'Cerámica'],
    ['Aislante', 'Lana de roca'],
    ['Acabado', 'Marmol'],
  ];

  final Map<String, IconData> iconosPorOpcion = const {
    'Mantenimiento': FontAwesomeIcons.wrench,
    'Incidencias': FontAwesomeIcons.triangleExclamation,
    'Calendario': FontAwesomeIcons.calendarDays,
    'Inversión': FontAwesomeIcons.coins,
    'Documentación': FontAwesomeIcons.filePdf,
  };

  Color _colorEstado(int valor) {
    if (valor >= 80) return Colors.green;
    if (valor >= 60) return Colors.orange;
    return Colors.red;
  }

  Color _colorHumedad(int valor) {
    if (valor >= 75) return Colors.red;
    if (valor >= 45) return Colors.orange;
    return Colors.green;
  }

  Color _colorTemperatura(int valor) {
    if (valor < 15 || valor > 30) return Colors.red;
    if ((valor >= 16 && valor <= 20) || (valor >= 28 && valor <= 29)) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final contenidoInfo = datosPorObjeto[titulo]?['info'] ?? 'No hay descripción disponible.';

    return Scaffold(
      appBar: AppBar(title: Text('Detalles del objeto: $titulo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Datos en tiempo real',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _datoConColor('Estado General:', estadoGeneral.toString(), _colorEstado(estadoGeneral)),
                _datoConColor('Humedad:', '$humedad%', _colorHumedad(humedad)),
                _datoConColor('Temperatura:', '$temperaturaº', _colorTemperatura(temperatura)),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                contenidoInfo,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            _tablaMateriales(),
            const Spacer(),
            Column(
              children: [
                _boton(context, 'Mantenimiento'),
                _boton(context, 'Incidencias'),
                _boton(context, 'Calendario'),
                _boton(context, 'Inversión'),
                _boton(context, 'Documentación'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _datoConColor(String label, String valor, Color color) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(
            text: valor,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _tablaMateriales() {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: materiales.map((fila) {
        final isHeader = fila[0] == 'Nombre';
        return TableRow(
          decoration: BoxDecoration(color: isHeader ? Colors.blue.shade900 : Colors.grey.shade300),
          children: fila.map((celda) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                celda,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  color: isHeader ? Colors.white : Colors.black87,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Widget _boton(BuildContext context, String label) {
    final icono = iconosPorOpcion[label] ?? FontAwesomeIcons.circleQuestion;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/detalle',
            arguments: {'titulo': titulo, 'opcion': label},
          );
        },
        icon: FaIcon(icono),
        label: Text(label, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade700,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
