import 'dart:async';

import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionService {
  final BoolCubit isConnectedCubit = BoolCubit(true);
  late StreamSubscription<InternetStatus> connectionSubscription;

  Future<ConnectionService> init() async {
    await checkConnection();
    await initListener();
    return this;
  }

  Future<void> checkConnection() async {
    final bool isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      isConnectedCubit.set(true);
    } else {
      isConnectedCubit.set(false);
    }
  }

  Future<void> initListener() async {
    connectionSubscription = InternetConnection().onStatusChange.listen((InternetStatus status) {
      if (status == InternetStatus.connected) {
        // Internet is connected
        isConnectedCubit.set(true);
      } else {
        // Internet is disconnected
        isConnectedCubit.set(false);
      }
    });
  }

  Future<void> dispose() async {
    await connectionSubscription.cancel();
  }
}
