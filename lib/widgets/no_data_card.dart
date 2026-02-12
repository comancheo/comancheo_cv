import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:comancheo_cv/widgets/no_data_image.dart';
import 'package:flutter/material.dart';

class NoDataCard extends StatelessWidget {
  const NoDataCard({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: const NoDataImage(),
    );
  }
}
