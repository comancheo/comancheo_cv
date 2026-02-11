import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/models/weather_model.dart';
import 'package:comancheo_cv/utils/geolocation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class WeatherService {
  static String weatherUrl = 'https://api.open-meteo.com/v1/forecast?latitude=<?=lat?>&longitude=<?=lon?>&current=temperature_2m,wind_speed_10m,relative_humidity_2m,weather_code&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code';
  final NullForecastModelCubit forecast = NullForecastModelCubit();
  final NullBoolCubit loading = NullBoolCubit();
  late GeolocationService geolocationService;
  Future<WeatherService> init() async {
    geolocationService = await GetIt.instance.getAsync<GeolocationService>();
    await loadWeather(geolocationService.currentPosition?.latLng ?? GeolocationService.fallbackPosition.latLng);
    return this;
  }

  Future<void> loadWeather([LatLng? location]) async {
    loading.set(true);
    location ??= geolocationService.currentPosition?.latLng??GeolocationService.fallbackPosition.latLng;
    var uri = Uri.parse(weatherUrl.replaceAll('<?=lat?>', location.latitude.toString()).replaceAll('<?=lon?>', location.longitude.toString()));
    String jsonString = await http.read(uri);
    forecast.set(ForecastModel.fromJson(jsonString));
    loading.set(false);
  }
}
