import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'views/plano_view.dart';
import 'views/detalle_view.dart';
import 'views/objeto_view.dart';
import 'utils/app_theme.dart';
import 'views/control_agua_view.dart';

void main() {
  runApp(const ControlInstalacionesApp());
}

class ControlInstalacionesApp extends StatelessWidget {
  const ControlInstalacionesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Instalaciones',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            // La nueva vista principal
            return MaterialPageRoute(builder: (_) => const HomeView());
          case '/mantenimiento':
            // Redirige a la HomeView con toda la funcionalidad actual
            return MaterialPageRoute(builder: (_) => const HomeView());
          case '/control_agua':
            // Placeholder para la vista de Control Agua
            return MaterialPageRoute(builder: (_) => const ControlAguaView());
          case '/plano':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (_) => PlanoView(instalacion: args['instalacion']));
          case '/detalle':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (_) =>
                    DetalleView(titulo: args['titulo'], opcion: args['opcion']));
          case '/objeto':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (_) => ObjetoView(titulo: args['titulo']));
          default:
            return null;
        }
      },
    );
  }
}
