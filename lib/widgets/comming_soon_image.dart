import 'package:comancheo_cv/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class CommingSoonImage extends StatelessWidget {
  const CommingSoonImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageWidget(imagePath: 'assets/comming_soon.png', width: 100, height: 100, fit: BoxFit.contain, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn));
  }
}