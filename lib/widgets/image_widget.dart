import 'package:cached_network_image/cached_network_image.dart';
import 'package:comancheo_cv/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;

  const ImageWidget({super.key, required this.imagePath, this.width = 100, this.height = 100, this.fit = BoxFit.cover});
  bool get isNetwork => imagePath.startsWith('http://') || imagePath.startsWith('https://');
  @override
  Widget build(BuildContext context) {
    return isNetwork ? CachedNetworkImage(imageUrl: imagePath, width: width, height: height, fit: fit) : Image.asset(imagePath, width: width, height: height, fit: fit);
  }

  static Future<void> openInDialog(BuildContext context, {String? title, required String imagePath, BoxFit? fit, double? width, double? height}) async {
    return await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: title,
            content: [
              ImageWidget(imagePath: imagePath, width: width ?? 100, height: height ?? 100, fit: fit ?? BoxFit.cover)
            ],
          );
        },
      );
  }
}
