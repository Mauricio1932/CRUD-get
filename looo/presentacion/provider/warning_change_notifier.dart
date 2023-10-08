import 'package:bloc_use/data/datasource/check_connection.dart';
import 'package:bloc_use/presentacion/provider/connection_status_change_notifier.dart';
import 'package:flutter/material.dart';
// import 'package:homework_crud/data/datasource/check_connection.dart';
// import 'package:homework_crud/presentacion/provider/connection_status_change_notifier.dart';
import 'package:provider/provider.dart';

class WarningChangeNotifier extends StatelessWidget {
  const WarningChangeNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectionStatusChangeNotifier(),
      child: Consumer<ConnectionStatusChangeNotifier>(
        builder: (context, value, child) {
          return Visibility(
              visible: value.status != ConnectionStatus.online,
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 60,
                color: Colors.red,
                child: const Row(
                  children: [
                    Icon(Icons.wifi_off),
                    SizedBox(width: 8),
                    Text('No hay conexión a internet')
                  ],
                ),
              ));
        },
      ),
    );
  }
}
