import 'package:comancheo_cv/widgets/comming_soon_image.dart';
import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class CommingSoonCard extends StatelessWidget {
  const CommingSoonCard({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: const CommingSoonImage(),
    );
  }
}
