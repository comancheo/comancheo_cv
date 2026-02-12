import 'package:cached_network_image/cached_network_image.dart';
import 'package:comancheo_cv/widgets/custom_dialog.dart';
import 'package:comancheo_cv/widgets/no_data_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final ColorFilter? colorFilter;

  const ImageWidget({super.key, required this.imagePath, this.width = 100, this.height = 100, this.fit = BoxFit.cover, this.colorFilter});
  bool get isNetwork => imagePath.startsWith('http://') || imagePath.startsWith('https://');

  Widget _buildImage() {
    if (isNetwork) {
      return CachedNetworkImage(imageUrl: imagePath, width: width, height: height, fit: fit, errorWidget: (context, url, error) => const NoDataImage(),);
    } else {
      return Image.asset(imagePath, width: width, height: height, fit: fit);
    }
  }

  Widget _buildWithFilter() {
    return ColorFiltered(
        colorFilter: colorFilter ?? ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: _buildImage(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return colorFilter != null ? _buildWithFilter() : _buildImage();
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
