

import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get result;
}

class NetworkInfoImp implements NetworkInfo {
  final Connectivity? connectionChecker;

  NetworkInfoImp(this.connectionChecker);

  @override
  Future<ConnectivityResult> get result => connectionChecker!.checkConnectivity();
}