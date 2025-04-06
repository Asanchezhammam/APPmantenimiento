import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'views/plano_view.dart';
import 'views/detalle_view.dart';
import 'views/objeto_view.dart';
import 'utils/app_theme.dart';

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
            return MaterialPageRoute(builder: (_) => const HomeView());
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
