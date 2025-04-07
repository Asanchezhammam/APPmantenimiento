import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class Lectura {
  final String contador;
  final double lectura;
  final DateTime fecha;
  Lectura({required this.contador, required this.lectura, required this.fecha});
}

class LecturasDetalleView extends StatefulWidget {
  final String contador;
  const LecturasDetalleView({Key? key, required this.contador}) : super(key: key);

  @override
  _LecturasDetalleViewState createState() => _LecturasDetalleViewState();
}

class _LecturasDetalleViewState extends State<LecturasDetalleView> {
  List<Lectura> lecturas = [];
  double? consumoActual;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  void loadCSVData() {
    // Se asume que el contenido CSV se almacenó en localStorage bajo la clave "lecturasCSV"
    final csvContent = html.window.localStorage['lecturasCSV'];
    if (csvContent == null || csvContent.trim().isEmpty) {
      setState(() {
        lecturas = [];
        isLoading = false;
      });
      return;
    }

    List<Lectura> allLecturas = [];
    List<String> lines = const LineSplitter().convert(csvContent);
    // Se asume que la primera línea es el encabezado "Contador,Lectura,Fecha"
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      final parts = line.split(',');
      if (parts.length >= 3) {
        final contador = parts[0];
        final lecturaValue = double.tryParse(parts[1]) ?? 0;
        final fecha = DateTime.tryParse(parts[2]);
        if (fecha != null) {
          allLecturas.add(Lectura(
              contador: contador, lectura: lecturaValue, fecha: fecha));
        }
      }
    }

    // Filtrar por el contador seleccionado
    List<Lectura> filtered =
        allLecturas.where((l) => l.contador == widget.contador).toList();

    // Ordenar por fecha ascendente
    filtered.sort((a, b) => a.fecha.compareTo(b.fecha));

    // Calcular "consumo actual"
    double? consumo;
    if (filtered.isNotEmpty) {
      final lastReading = filtered.last;
      // Determinar el último día del mes anterior al mes actual
      DateTime now = DateTime.now();
      DateTime primerDiaMesActual = DateTime(now.year, now.month, 1);
      DateTime ultimoDiaMesAnterior = primerDiaMesActual.subtract(const Duration(days: 1));
      Lectura? lecturaPrev;
      try {
        lecturaPrev = filtered.firstWhere((l) =>
            l.fecha.year == ultimoDiaMesAnterior.year &&
            l.fecha.month == ultimoDiaMesAnterior.month &&
            l.fecha.day == ultimoDiaMesAnterior.day);
      } catch (e) {
        lecturaPrev = null;
      }
      if (lecturaPrev != null) {
        consumo = lastReading.lectura - lecturaPrev.lectura;
      }
    }

    setState(() {
      lecturas = filtered;
      consumoActual = consumo;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecturas - ${widget.contador}'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    consumoActual != null
                        ? 'Consumo actual: $consumoActual'
                        : 'Consumo actual: No hay datos',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Fecha')),
                          DataColumn(label: Text('Lectura')),
                        ],
                        rows: lecturas.map((l) {
                          final fechaStr =
                              "${l.fecha.year}-${l.fecha.month.toString().padLeft(2, '0')}-${l.fecha.day.toString().padLeft(2, '0')}";
                          return DataRow(cells: [
                            DataCell(Text(fechaStr)),
                            DataCell(Text(l.lectura.toString())),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
