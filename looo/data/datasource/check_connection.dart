import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

enum ConnectionStatus {
  online,
  offline,
}

class CheckConnection {
  final Connectivity _connectivity = Connectivity();
  final _controller = BehaviorSubject.seeded(ConnectionStatus.online);
  StreamSubscription? _connectionSubscription;
  CheckConnection() {
    _checkConnection();
  }
  Stream<ConnectionStatus> internetStatus() {
    _connectionSubscription ??=
        _connectivity.onConnectivityChanged.listen((_) => _checkConnection());
    return _controller.stream;
  }

  Future<void> _checkConnection() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      print("result $result");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _controller.sink.add(ConnectionStatus.online);
      } else {
        _controller.sink.add(ConnectionStatus.offline);
      }
    } on SocketException catch (_) {
      _controller.sink.add(ConnectionStatus.offline);
    }
  }

  Future<void> close() async {
    await _connectionSubscription?.cancel();
    await _controller.close();
  }
}
