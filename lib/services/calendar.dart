import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:flutter_nameday_api/flutter_nameday_api.dart';

class CalendarService {
  final ListCubit<String> namesDay = ListCubit<String>([]);
  final NullBoolCubit loading = NullBoolCubit();

  Future<CalendarService> init() async {
    // Initialize any necessary resources here, such as API clients or databases.
    await loadTodayData();
    return this;
  }

  Future<void> loadTodayData() async {
    final OneDayData todayData = await Nameday.today();
    namesDay.clear();
    namesDay.addAll(todayData.nameDaysWithCodes['cz'] ?? []);
    // This is a placeholder implementation. You would replace this with actual logic to fetch nameday data.
  }
}