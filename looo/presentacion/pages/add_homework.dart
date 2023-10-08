import 'package:bloc_use/data/datasource/firebase_services.dart';
import 'package:flutter/material.dart';
// import 'package:homework_crud/data/datasource/firebase_services.dart';

import '../provider/warning_change_notifier.dart';

class AddHomework extends StatefulWidget {
  AddHomework({Key? key}) : super(key: key);

  @override
  State<AddHomework> createState() => _AddHomeworkState();
}

class _AddHomeworkState extends State<AddHomework> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController dateController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Administrador de tareas'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const WarningChangeNotifier(),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Nombre de la tarea'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Descripcion'),
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(hintText: 'Fecha'),
          ),
          ElevatedButton(
              onPressed: () async {
                await addHomework(nameController.text,
                        descriptionController.text, dateController.text)
                    .then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Guardar'))
        ],
      ),
    );
  }
}
