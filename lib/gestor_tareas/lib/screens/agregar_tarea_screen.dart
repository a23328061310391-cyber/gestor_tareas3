import 'package:flutter/material.dart';
import '../models/tarea.dart';

class AgregarTareaScreen extends StatefulWidget {
  const AgregarTareaScreen({super.key});

  @override
  State<AgregarTareaScreen> createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nueva Tarea'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Título de la tarea',
                  border: OutlineInputBorder(),
                  hintText: 'Ej: Comprar leche',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa un título para la tarea';
                  }
                  if (value.length < 3) {
                    return 'El título debe tener al menos 3 caracteres';
                  }
                  return null;
                },
                autofocus: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final nuevaTarea = Tarea(_controller.text.trim());
                          Navigator.pop(context, nuevaTarea);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Guardar Tarea'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}