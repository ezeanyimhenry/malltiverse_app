import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();
  StreamController<ConnectivityResult> _connectivityController =
      StreamController<ConnectivityResult>.broadcast();

  NetworkService() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityController.add(result);
    });
  }

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivityController.stream;

  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
