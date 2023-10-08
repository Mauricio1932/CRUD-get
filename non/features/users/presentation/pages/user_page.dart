import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/users/users_bloc.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pluto_grid_crud/features/users/domain/entities/user.dart';
// import 'package:pluto_grid_crud/features/users/presentation/blocs/user/user_bloc.dart';
// import 'package:pluto_grid_crud/features/users/presentation/blocs/users/users_bloc.dart';

class UserPage extends StatefulWidget {
  final User? user;

  const UserPage({super.key, this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController status = TextEditingController();

  @override
  void initState() {
    super.initState();

    if(widget.user != null) {
      name.text = widget.user!.name;
      email.text = widget.user!.email;
      status.text = widget.user!.status.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Crear Usuario' : 'Actualizar Usuario'),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          
          child:Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                ),
              ),

              const SizedBox(height: 15),

              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if(state is SavingUser) {
                    return const CircularProgressIndicator();
                  } else if(state is UserSaved) {
                    return const Text("Usuario guardado exitosamente", style: TextStyle(color: Colors.green));
                  } else if(state is ErrorSavingUser) {
                    return Text(state.message, style: const TextStyle(color: Colors.red));
                  } else {
                    return Container();
                  }
                },
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                child: const Text('Guardar Usuario'),
                onPressed: () {
                  if(widget.user == null) {
                    String id = DateTime.now().millisecondsSinceEpoch.toString();
                    User user = User(id: id, name: name.text, email: email.text, status: int.parse(status.text));
                    context.read<UserBloc>().add(PressCreateUserButton(user: user));
                  } else {
                    User user = User(id: widget.user!.id, name: name.text, email: email.text, status: int.parse(status.text));
                    context.read<UserBloc>().add(PressUpdateUserButton(user: user));
                  }
                  context.read<UsersBloc>().add(GetUsers());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
