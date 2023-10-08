import 'package:bloc_use/data/datasource/firebase_services.dart';
import 'package:flutter/material.dart';
// import 'package:homework_crud/data/datasource/firebase_services.dart';

import '../provider/warning_change_notifier.dart';

class EditHomework extends StatefulWidget {
  EditHomework({Key? key}) : super(key: key);

  @override
  State<EditHomework> createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController dateController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar tarea'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const WarningChangeNotifier(),
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: arguments['name']),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: arguments['description']),
          ),
          TextField(
            controller: dateController,
            decoration: InputDecoration(hintText: arguments['date']),
          ),
          ElevatedButton(
              onPressed: () async {
                await updateHomework(arguments['uid'], nameController.text,
                        descriptionController.text, dateController.text)
                    .then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Actualizar'))
        ],
      ),
    );
  }
}
