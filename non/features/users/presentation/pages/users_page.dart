import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../domain/entities/user.dart';
import '../blocs/users/users_bloc.dart';
import 'user_page.dart';
// import 'package:pluto_grid_crud/features/users/domain/entities/user.dart';
// 
// import 'package:pluto_grid_crud/features/users/presentation/blocs/users/users_bloc.dart';
// import 'package:pluto_grid_crud/features/users/presentation/pages/user_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  PlutoGridStateManager? stateManager;

  final List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'Id',
      field: 'id',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Nombre',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Email',
      field: 'email',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Status',
      field: 'status',
      type: PlutoColumnType.number(),
    ),
  ];
  final List<PlutoRow> rows = [];

  final List<PlutoColumn> columns2 = [];
  final List<PlutoRow> rows2 = [];

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
      ),

      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if(state is GettingUsers) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is UserTable) {
            rows.clear();
            for(var element in state.users) {
              rows.add(
                PlutoRow(
                  cells: {
                    'id': PlutoCell(value: element.id),
                    'name': PlutoCell(value: element.name),
                    'email': PlutoCell(value: element.email),
                    'status': PlutoCell(value: element.status),
                    //'options': PlutoCell(value: ''),
                  },
                ),
              );
            }

            PlutoGridStateManager.initializeRowsAsync(
              columns,
              rows,
            ).then((value) {
              //stateManager!.refRows.addAll(FilteredList(initialList: value));
              stateManager!.notifyListeners();
            });

            return Container(
              padding: const EdgeInsets.all(15),

              child: PlutoGrid(
                columns: columns,
                rows: rows,

                onLoaded: (PlutoGridOnLoadedEvent event) => stateManager = event.stateManager,

                onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                  User user = User(
                    id: event.row.toJson()['id'],
                    name: event.row.toJson()['name'],
                    email: event.row.toJson()['email'],
                    status: event.row.toJson()['status'],
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage(user: user)),
                  );
                },
              ),
            );
          } else if(state is ErrorGettingUsers) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          } else {
            return Container();
          }
        },
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete),

            onPressed: () {
              if(stateManager!.currentRow != null) {
                context.read<UsersBloc>().add(PressDeleteUserButton(id: stateManager!.currentRow!.toJson()['id']));
                context.read<UsersBloc>().add(GetUsers());
              }
            },
          ),

          SizedBox(height: 10),

          FloatingActionButton(
            child: const Icon(Icons.add),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
