import 'package:bloc_use/data/datasource/firebase_services.dart';
import 'package:bloc_use/presentacion/provider/warning_change_notifier.dart';
import 'package:flutter/material.dart';
// import 'package:homework_crud/data/datasource/check_connection.dart';
// import 'package:homework_crud/data/datasource/firebase_services.dart';
// import 'package:homework_crud/presentacion/provider/warning_change_notifier.dart';

class MenuOptions extends StatefulWidget {
  const MenuOptions({Key? key}) : super(key: key);

  @override
  State<MenuOptions> createState() => _MenuOptions();
}

class _MenuOptions extends State<MenuOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Administrador de tareas'),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
          child: Container(
        color: const Color.fromARGB(255, 243, 243, 243),
        child: Column(
          children: [
            const WarningChangeNotifier(),
            const Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Lista de tareas',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
            Expanded(
                flex: 9,
                child: FutureBuilder(
                    future: getHomeworks(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Title(
                                color: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 99, 99, 99), // Color del borde
                                      width: 0.5, // Ancho del borde
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Text(
                                              snapshot.data?[index]['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          )),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Text(
                                              snapshot.data?[index]
                                                  ['description'],
                                              style: const TextStyle(
                                                  fontSize: 15.0),
                                            ),
                                          )),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                                snapshot.data?[index]['date']),
                                          )),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                await deleteHomework(snapshot
                                                    .data?[index]['uid']);
                                                setState(() {});
                                              },
                                              child: const Text('Eliminar')))
                                    ],
                                  ),
                                ),
                              ),
                              onTap: (() async {
                                await Navigator.pushNamed(context, '/edit',
                                    arguments: {
                                      'name': snapshot.data?[index]['name'],
                                      'description': snapshot.data?[index]
                                          ['description'],
                                      'date': snapshot.data?[index]['date'],
                                      'uid': snapshot.data?[index]['uid'],
                                    });
                                setState(() {});
                              }),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
