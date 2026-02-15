import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class InternetConnectionIndicator extends StatefulWidget {
  const InternetConnectionIndicator({super.key});

  @override
  State<InternetConnectionIndicator> createState() => _InternetConnectionIndicatorState();
}

class _InternetConnectionIndicatorState extends State<InternetConnectionIndicator> {
  final ConnectionService _connectionService = GetIt.instance<ConnectionService>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoolCubit, bool>(
      bloc: _connectionService.isConnectedCubit,
      builder: (context, isConnected) {
        if (isConnected) {
          return SizedBox();
        } else {
          return InkWell(
            onTap: () async {
              await _connectionService.checkConnection();
            },
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                border: Border.all(color: Theme.of(context).colorScheme.error, width: 1, strokeAlign: BorderSide.strokeAlignInside),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Theme.of(context).colorScheme.onErrorContainer),
                  SizedBox(width: 8),
                  Text("Není připojení k internetu", style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
