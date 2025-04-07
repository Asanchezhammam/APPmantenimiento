import 'package:flutter/material.dart';
import 'lectura_detalle_view.dart';
import 'cargar_datos_view.dart';

class ControlAguaView extends StatelessWidget {
  const ControlAguaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Agua'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          // Posiciones relativas para centrar el diagrama
          final contadorCenter = Offset(width * 0.15, height * 0.5);
          final lavanderiaCenter = Offset(width * 0.45, height * 0.2);
          final termaCalienteCenter = Offset(width * 0.45, height * 0.35);
          final termaFriaCenter = Offset(width * 0.45, height * 0.5);
          final termaTempladaCenter = Offset(width * 0.45, height * 0.65);
          final acsCenter = Offset(width * 0.45, height * 0.8);
          final desagueCenter = Offset(width * 0.75, height * 0.5);

          // Tamaño base para botones grandes
          final buttonSize = Size(width * 0.22, height * 0.1);

          return Stack(
            children: [
              // Dibuja las líneas del diagrama
              CustomPaint(
                size: Size(width, height),
                painter: _FlowChartPainter(
                  contadorCenter: contadorCenter,
                  lavanderiaCenter: lavanderiaCenter,
                  termaCalienteCenter: termaCalienteCenter,
                  termaFriaCenter: termaFriaCenter,
                  termaTempladaCenter: termaTempladaCenter,
                  acsCenter: acsCenter,
                  desagueCenter: desagueCenter,
                ),
              ),

              // Botón: Contador General
              Positioned(
                left: contadorCenter.dx - buttonSize.width / 2,
                top: contadorCenter.dy - buttonSize.height / 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LecturasDetalleView(contador: 'General'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    fixedSize: buttonSize,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Contador\nGeneral',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Botón: Lavandería
              Positioned(
                left: lavanderiaCenter.dx - buttonSize.width / 2,
                top: lavanderiaCenter.dy - buttonSize.height / 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LecturasDetalleView(contador: 'Lavandería'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    fixedSize: buttonSize,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Lavandería',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Botón: Terma Caliente
              Positioned(
                left: termaCalienteCenter.dx - buttonSize.width / 2,
                top: termaCalienteCenter.dy - buttonSize.height / 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LecturasDetalleView(contador: 'Terma caliente'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    fixedSize: buttonSize,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Terma\nCaliente',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Botón: Terma Fría
              Positioned(
                left: termaFriaCenter.dx - buttonSize.width / 2,
                top: termaFriaCenter.dy - buttonSize.height / 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LecturasDetalleView(contador: 'Terma fría'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    fixedSize: buttonSize,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Terma\nFría',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Botón: Terma Templada
              Positioned(
                left: termaTempladaCenter.dx - buttonSize.width / 2,
                top: termaTempladaCenter.dy - buttonSize.height / 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LecturasDetalleView(contador: 'Terma templada'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    fixedSize: buttonSize,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Terma\nTemplada',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Botón: ACS
              Positioned(
                left: acsCenter.dx - buttonSize.width / 2,
                top: acsCenter.dy - buttonSize.height / 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LecturasDetalleView(contador: 'Acs'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: buttonSize,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'ACS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Contenedor: Desagüe General (se trata como un botón mediante InkWell)
              Positioned(
                left: desagueCenter.dx - (buttonSize.width * 1.5) / 2,
                top: desagueCenter.dy - (buttonSize.height * 3) / 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LecturasDetalleView(contador: 'Desagüe'),
                      ),
                    );
                  },
                  child: Container(
                    width: buttonSize.width * 1.5,
                    height: buttonSize.height * 3,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Desagüe\nGeneral',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),

              // Botón: Cargar datos (navega a la vista del formulario)
              Positioned(
                left: width * 0.1,
                bottom: 20,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CargarDatosView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  child: const Text(
                    'Cargar datos',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// CustomPainter que dibuja las líneas conectando los botones del diagrama.
class _FlowChartPainter extends CustomPainter {
  final Offset contadorCenter;
  final Offset lavanderiaCenter;
  final Offset termaCalienteCenter;
  final Offset termaFriaCenter;
  final Offset termaTempladaCenter;
  final Offset acsCenter;
  final Offset desagueCenter;

  _FlowChartPainter({
    required this.contadorCenter,
    required this.lavanderiaCenter,
    required this.termaCalienteCenter,
    required this.termaFriaCenter,
    required this.termaTempladaCenter,
    required this.acsCenter,
    required this.desagueCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // Líneas desde el Contador General hacia cada uno de los botones intermedios
    canvas.drawLine(contadorCenter, lavanderiaCenter, paint);
    canvas.drawLine(contadorCenter, termaCalienteCenter, paint);
    canvas.drawLine(contadorCenter, termaFriaCenter, paint);
    canvas.drawLine(contadorCenter, termaTempladaCenter, paint);
    canvas.drawLine(contadorCenter, acsCenter, paint);

    // Líneas desde cada botón intermedio hasta el Desagüe General
    canvas.drawLine(lavanderiaCenter, desagueCenter, paint);
    canvas.drawLine(termaCalienteCenter, desagueCenter, paint);
    canvas.drawLine(termaFriaCenter, desagueCenter, paint);
    canvas.drawLine(termaTempladaCenter, desagueCenter, paint);
    canvas.drawLine(acsCenter, desagueCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
