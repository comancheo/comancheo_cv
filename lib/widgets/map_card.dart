import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:comancheo_cv/widgets/map.dart';
import 'package:flutter/material.dart';

class MapCard extends StatefulWidget {
  const MapCard({super.key});

  @override
  State<MapCard> createState() => MapCardState();
}

class MapCardState extends State<MapCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () {
        ///
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Kde teď stojíte", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          SizedBox(height: 400, child: MyMap()),
        ],
      ),
    );
  }
}
