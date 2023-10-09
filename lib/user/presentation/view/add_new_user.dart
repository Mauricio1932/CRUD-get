import 'package:bloc_use/user/presentation/bloc/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../bloc/bloc/user_bloc.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({Key? key}) : super(key: key);

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    apellidoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text("Hello"),
                      ),
                    ),
                    title: TextFormField(
                      controller: nombreController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                    subtitle: TextFormField(
                      controller: apellidoController,
                      decoration: InputDecoration(labelText: 'Apellido'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('¡Alerta!'),
                content: Text("Estamos actualizando tu informacion"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Cierra la alerta
                      creatUserData();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        child: const Icon(Icons.save, color: Colors.black),
      ),
    );
  }

  void creatUserData() {
    List<User> user = [
      User(
          nombre: nombreController.text,
          apellido: apellidoController.text,
          id: 0),
    ];
    context.read<UserBloc>().add(CreateNewUser(user[0]));
    // print("${user[0].nombre}");
  }
}
