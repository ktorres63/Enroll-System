import 'package:flutter/material.dart';
import 'package:enrollment_system/screens/registro_curso_page.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistroCursoPage(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navegando a la página de Nuevo Curso...'),
                  ),
                );
              },
              child: const Text('Nuevo Curso'),
            ),
            const SizedBox(height: 16), // Espacio entre el botón y el cuadro
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lista de Cursos',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    // Cambiado aquí
                    ListView.builder(
                      shrinkWrap: true, // Agregar esta línea
                      physics: NeverScrollableScrollPhysics(), // Deshabilitar el desplazamiento
                      itemCount: 10, // Cambia esto por la longitud de tu lista
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Curso ${index + 1}'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
