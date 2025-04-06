import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/info_mock.dart';

class DetalleView extends StatefulWidget {
  final String titulo;
  final String opcion;

  const DetalleView({required this.titulo, required this.opcion, super.key});

  @override
  State<DetalleView> createState() => _DetalleViewState();
}

class _DetalleViewState extends State<DetalleView> {
  DateTime _fechaSeleccionada = DateTime.now();
  final Map<DateTime, String> notas = {};
  final TextEditingController _notaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contenido = datosPorObjeto[widget.titulo]?[widget.opcion];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.opcion} - ${widget.titulo}'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: _buildContenido(widget.opcion, contenido),
        ),
      ),
    );
  }

  Widget _buildContenido(String opcion, dynamic contenido) {
    if (opcion == 'Documentación' && contenido != null) {
      return Center(
        child: ElevatedButton.icon(
          onPressed: () => _abrirEnlace(contenido),
          icon: const FaIcon(FontAwesomeIcons.filePdf),
          label: const Text('Ver documento'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }

    if (opcion == 'Calendario') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            focusedDay: _fechaSeleccionada,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(day, _fechaSeleccionada),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _fechaSeleccionada = selectedDay;
                _notaController.text = notas[selectedDay] ?? '';
              });
            },
            eventLoader: (day) {
              final normalized = DateTime(day.year, day.month, day.day);
              return calendarioEventos[normalized] ?? [];
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.indigo.shade700,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.indigo.shade300,
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Builder(
            builder: (context) {
              final normalizedDay = DateTime(
                  _fechaSeleccionada.year, _fechaSeleccionada.month, _fechaSeleccionada.day);
              final events = calendarioEventos[normalizedDay] ?? [];
              if (events.isEmpty) {
                return const Text('No hay eventos para este día.');
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: events
                    .map((event) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            event,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 20),
          Text('Nota para ${_fechaSeleccionada.toLocal().toString().split(' ')[0]}:'),
          const SizedBox(height: 8),
          TextField(
            controller: _notaController,
            decoration: const InputDecoration(
              hintText: 'Escribe aquí tu nota...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                notas[_fechaSeleccionada] = _notaController.text;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nota guardada')),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('Guardar nota'),
          ),
        ],
      );
    }

    return Text(
      contenido ?? 'No hay información disponible.',
      style: const TextStyle(fontSize: 18, color: Colors.black87, height: 1.5),
    );
  }

  Future<void> _abrirEnlace(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }
}
