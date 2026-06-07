import 'package:flutter/material.dart';
import '../models/tarea.dart';
import 'agregar_tarea_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Tarea> tareas = [];

  void _agregarTarea(Tarea nuevaTarea) {
    setState(() {
      tareas.add(nuevaTarea);
    });
  }

  void _toggleCompletada(int index) {
    setState(() {
      tareas[index].completada = !tareas[index].completada;
    });
  }

  void _eliminarTarea(int index) {
    setState(() {
      tareas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Tareas'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: tareas.isEmpty
          ? const Center(
              child: Text(
                'No hay tareas pendientes',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: tarea.completada,
                      onChanged: (_) => _toggleCompletada(index),
                    ),
                    title: Text(
                      tarea.titulo,
                      style: TextStyle(
                        decoration: tarea.completada
                            ? TextDecoration.lineThrough
                            : null,
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarTarea(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgregarTareaScreen(),
            ),
          );
          
          if (resultado != null) {
            _agregarTarea(resultado);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
