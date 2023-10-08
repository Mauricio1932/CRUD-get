// ignore_for_file: must_be_immutable

// import 'package:fetch_data_dio/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:get/get.dart';

import '../../domain/entities/user.dart';
import '../bloc/bloc/user_bloc.dart';
// import '../utils/colors.dart';}

class DetailsView extends StatefulWidget {
  const DetailsView(userId, {super.key});

  // final String userId; // Debes declarar el tipo del userId

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    final userContent = context.select<UserBloc, List<User>>((b) => b
        .state.users
        .where((user) => b.state.userId.contains(user.id))
        .toList());

    return Scaffold(
      appBar:AppBar(title: const Text("Detalles"), backgroundColor: Colors.black,),
      body: Center(
        child: Builder(
        builder: (context) {
          return ListView.builder(
            itemCount: userContent.length,
            itemBuilder: (context, index) {
              final user = userContent[index];
      
              return Column(
                children: [
                  const SizedBox(height: 150),
                  Card(
                    key: ValueKey(user.id),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(user.id.toString()),
                        ),
                      ),
                      title: Text(
                        user.nombre,
                      ),
                      subtitle: Text(
                        user.apellido,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  // OutlinedButton(onPressed: (){ viewUser(state.users[index].id);
                  // print("${state.users[index].id}");
                  // }, child: Text("view"))
                ],
              );
            },
          );
        },
          ),
      ));
  }
}
