import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/connection.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_nameday_api/flutter_nameday_api.dart';
import 'package:get_it/get_it.dart';

class CalendarService {
  final ListCubit<String> namesDay = ListCubit<String>([]);
  final NullBoolCubit loading = NullBoolCubit();
  final ConnectionService connectionService = GetIt.instance.get<ConnectionService>();

  Future<CalendarService> init() async {
    // Initialize any necessary resources here, such as API clients or databases.
    await loadTodayData();
    return this;
  }

  Future<void> loadTodayData() async {
    loading.set(true);
    if(!connectionService.isConnectedCubit.state){
      loading.set(false);
      return;
    }
    try {
      final OneDayData todayData = await Nameday.today();
      namesDay.clear();
      namesDay.addAll(todayData.nameDaysWithCodes['cz'] ?? []);
    } catch (e) {
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(const SnackBar(content: Text('Chyba při načítání svátků')));
    }
    loading.set(false);
  }
}
