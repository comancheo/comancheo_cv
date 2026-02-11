import 'package:comancheo_cv/cubits/base_cubits.dart';

class ConnectionService {
  final BoolCubit isConnectedCubit = BoolCubit(true);
  Future<ConnectionService> init() async {
    // Simulate connection initialization
    await Future.delayed(Duration(seconds: 1));
    isConnectedCubit.set(true); // Assume connection is successful for this example
    return this;
  }
}