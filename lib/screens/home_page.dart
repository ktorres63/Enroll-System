import 'package:flutter/material.dart';
import 'package:enrollment_system/screens/login_page.dart';
import 'package:enrollment_system/screens/registro_alumno_page.dart';
import 'package:enrollment_system/screens/curso_page.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido al Sistema Escolar',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CursosScreen(),
                  ),
                );
              },
              child: const Text('Registro de Asignaturas'),
            ),
          ],

        ),
      ),
    );
  }
}
