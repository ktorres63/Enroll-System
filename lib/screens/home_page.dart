import 'package:flutter/material.dart';
import 'package:enrollment_system/screens/login_page.dart';
import 'package:enrollment_system/screens/registro_alumno_page.dart';

import 'package:enrollment_system/screens/cursos_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white, // Cambia el color del texto a blanco
            fontSize: 20, // Puedes ajustar el tamaño de la fuente si lo deseas
            fontWeight: FontWeight.bold, // Ajusta el grosor del texto
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3E50),
        actions: [
          // Foto de perfil con opciones
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Configuración') {
                // Acción para ir a Configuración
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigPage()));
              } else if (value == 'Cerrar sesión') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Configuración',
                child: Text('Configuración'),
              ),
              const PopupMenuItem(
                value: 'Cerrar sesión',
                child: Text('Cerrar sesión'),
              ),
            ],
            // CircleAvatar para mostrar la imagen de perfil
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile1.png'),
                radius: 18,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Alinea desde arriba
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centra horizontalmente
            children: [
              const Text(
                'Bienvenido al Sistema de Registro',
                textAlign: TextAlign.center, // Centra el texto internamente
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200, // Ancho fijo para los botones
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroAlumnosPage(),
                      ),
                    );
                  },
                  child: const Text('Registro de Alumnos'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200, // Mismo ancho para mantener consistencia
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CursosPage(),
                      ),
                    );
                  },
                  child: const Text('Registro de Cursos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
