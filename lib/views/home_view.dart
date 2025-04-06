import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Lista de botones de instalaciones.
  final List<_InstalacionButton> botones = const [
    _InstalacionButton('GRX', Colors.lightBlue),
    _InstalacionButton('MAD', Colors.deepOrange),
    _InstalacionButton('PDH', Colors.teal),
    _InstalacionButton('COR', Colors.purple),
    _InstalacionButton('AGP', Colors.pinkAccent),
    _InstalacionButton('PMI', Colors.amber),
    _InstalacionButton('BAR', Colors.green),
  ];

  // Datos predefinidos para la tabla.
  final List<Map<String, dynamic>> tablaData = const [
    {
      'fecha': '2025-03-28',
      'tarea': 'Visita de electricista para revisar los puntos de luz',
      'responsable': 'Ledesma',
      'okey': true,
    },
    {
      'fecha': '2025-04-05',
      'tarea': 'Mantenimiento de la terma templado',
      'responsable': 'Emilio',
      'okey': false,
    },
    {
      'fecha': '2025-04-15',
      'tarea': 'Revisión del ascensor',
      'responsable': 'Emilio',
      'okey': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONTROL DE INSTALACIONES'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Título de la sección.
            const Text(
              'Tareas Programadas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // DataTable con fondo en el encabezado y filas.
            DataTable(
              headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.blue.shade100),
              dataRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.grey.shade200),
              columnSpacing: 80,
              horizontalMargin: 24,
              headingRowHeight: 60,
              dataRowHeight: 64,
              columns: const [
                DataColumn(
                  label: Text(
                    'Fecha',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Tarea',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Responsable',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Okey',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: tablaData.map((row) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        row['fecha'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        row['tarea'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        row['responsable'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Icon(
                        row['okey'] ? Icons.check : Icons.close,
                        color: row['okey']
                            ? Colors.green
                            : Colors.red,
                        size: 28,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Botones de instalaciones.
            Expanded(
              child: Center(
                child: Wrap(
                  spacing: 40,
                  runSpacing: 30,
                  children: botones.map((b) => b.build(context)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InstalacionButton {
  final String label;
  final Color color;

  const _InstalacionButton(this.label, this.color);

  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black87),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/plano',
          arguments: {'instalacion': label},
        );
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
