import 'dart:async';

import 'package:bloc_use/data/datasource/check_connection.dart';
import 'package:bloc_use/main.dart';
import 'package:flutter/material.dart';
// import 'package:homework_crud/data/datasource/check_connection.dart';
// import 'package:homework_crud/main.dart';

class ConnectionStatusChangeNotifier extends ChangeNotifier {
  late StreamSubscription _connectionSuscription;

  ConnectionStatus status = ConnectionStatus.online;

  ConnectionStatusChangeNotifier() {
    _connectionSuscription = internetCheck.internetStatus().listen((newStatus) {
      status = newStatus;
      notifyListeners();
    });
  }

  void disponse() {
    _connectionSuscription.cancel();
    super.dispose();
  }
}
