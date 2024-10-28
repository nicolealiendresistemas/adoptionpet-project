// presentation/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Configuración del controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Iniciar la animación
    _controller.forward();

    // Navegar a la pantalla de autenticación después de 3 segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/check-auth');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900, // Fondo azul marino
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logotipo o icono con animación de escala
              ScaleTransition(
                scale: _animation,
                child: const Icon(
                  Icons.pets,
                  size: 100,
                  color: Colors.white, // Icono de color blanco para contraste
                ),
              ),
              const SizedBox(height: 20),
              // Texto estilizado con animación de opacidad
              FadeTransition(
                opacity: _animation,
                child: const Text(
                  'Pet Adoption',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto principal en blanco
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Subtítulo o mensaje de bienvenida
              FadeTransition(
                opacity: _animation,
                child: const Text(
                  'Encuentra a tu amigo ideal',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70, // Subtítulo en blanco opaco
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
