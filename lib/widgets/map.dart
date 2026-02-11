import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/utils/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Position currentPosition = GeolocationService.fallbackPosition;
  GeolocationService? geolocationService;
  final MapController mapController = MapController();
  bool mapReady = false;
  @override
  void initState() {
    super.initState();
    GetIt.instance.getAsync<GeolocationService>().then((service) {
      setState(() {
        geolocationService = service;
        setPositionAndState();
      });
      geolocationService!.loading.stream.listen((loading) {
        if (loading == false) {
          setPositionAndState();
        }
      });
    });
  }

  void setPositionAndState() {
    if (geolocationService != null && mapReady) {
      setState(() {
        setPosition();
      });
    }
  }

  void setPosition() {
    if (geolocationService != null && mapReady) {
      currentPosition = geolocationService?.currentPosition ?? GeolocationService.fallbackPosition;
      mapController.moveAndRotate(currentPosition.latLng, 9.2, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (geolocationService == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return BlocBuilder<NullBoolCubit, bool?>(
      bloc: geolocationService!.loading,
      builder: (context, loading) {
        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: currentPosition.latLng,
            initialZoom: 9.2,
            onMapReady: () {
              setState(() {
                mapReady = true;
                setPosition();
              });
            },
          ),
          children: [
            TileLayer(
              // Bring your own tiles
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
              userAgentPackageName: 'cz.comancheo.cv', // Add your app identifier
              // And many more recommended properties!
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: currentPosition.latLng, // Location of the marker
                  child: GestureDetector(
                    onTap: () async {
                      String url = 'https://www.google.com/maps/place/${currentPosition.latitude},${currentPosition.longitude}';
                      await launchUrl(Uri.parse(url));
                    },
                    child: Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary, size: 40),
                  ),
                ),
              ],
            ),

            ///get my location button
            IconButton(
              onPressed: () async {
                mapController.moveAndRotate(geolocationService?.currentPosition?.latLng ?? GeolocationService.fallbackPosition.latLng, 9.2, 0);
                //get my location
              },
              icon: Icon(Icons.my_location),
            ),
            if (loading == true) SizedBox(child: const Center(child: CircularProgressIndicator())),
          ],
        );
      },
    );
  }
}
