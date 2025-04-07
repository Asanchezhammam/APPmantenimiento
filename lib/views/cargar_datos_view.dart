import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class CargarDatosView extends StatefulWidget {
  const CargarDatosView({Key? key}) : super(key: key);

  @override
  _CargarDatosViewState createState() => _CargarDatosViewState();
}

class _CargarDatosViewState extends State<CargarDatosView> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _opcionesContador = [
    'General',
    'Terma caliente',
    'Terma templada',
    'Terma fría',
    'Acs',
    'Lavandería',
    'Desagüe'
  ];
  String? _contadorSeleccionado;
  final TextEditingController _lecturaController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  // Función para guardar datos en localStorage (almacenándolos en formato CSV)
  void _guardarDatos() {
    if (_formKey.currentState!.validate()) {
      final newData =
          "$_contadorSeleccionado,${_lecturaController.text},${_fechaController.text}";
      // Recupera el contenido CSV actual almacenado en localStorage
      String? currentCSV = html.window.localStorage['lecturasCSV'];
      if (currentCSV == null || currentCSV.trim().isEmpty) {
        // Si no existe, se inicializa con la cabecera
        currentCSV = "Contador,Lectura,Fecha\n";
      }
      // Se añade la nueva línea de datos
      currentCSV += "$newData\n";
      // Se guarda el CSV actualizado en localStorage
      html.window.localStorage['lecturasCSV'] = currentCSV;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados correctamente')),
      );
      // Se limpian los campos del formulario
      setState(() {
        _contadorSeleccionado = null;
      });
      _lecturaController.clear();
      _fechaController.clear();
    }
  }

  @override
  void dispose() {
    _lecturaController.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cargar Datos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de selección (Dropdown) para el contador
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Contador',
                  border: OutlineInputBorder(),
                ),
                value: _contadorSeleccionado,
                items: _opcionesContador.map((opcion) {
                  return DropdownMenuItem(
                    value: opcion,
                    child: Text(opcion),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _contadorSeleccionado = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione un contador';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo para la lectura
              TextFormField(
                controller: _lecturaController,
                decoration: const InputDecoration(
                  labelText: 'Lectura',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la lectura';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo para la fecha con DatePicker
              TextFormField(
                controller: _fechaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    setState(() {
                      _fechaController.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la fecha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Botón para guardar datos
              ElevatedButton(
                onPressed: _guardarDatos,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
