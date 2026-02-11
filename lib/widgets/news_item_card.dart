import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:comancheo_cv/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drop_cap_text/flutter_drop_cap_text.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemCard extends StatefulWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final String? link;

  const NewsItemCard({super.key, required this.title, required this.description, this.imageUrl, this.link});

  @override
  State<NewsItemCard> createState() => _NewsItemCardState();
}

class _NewsItemCardState extends State<NewsItemCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
            onTap: () {
              if (widget.link == null) return;
              launchUrl(Uri.parse(widget.link!), mode: LaunchMode.externalApplication);
            },
            child: Column(
              children: [
                Text(widget.title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                DropCapText(
                  widget.description.trimLeft(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  dropCap: (widget.imageUrl == null) ? null : DropCap(
                    width: 60,
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 10),
                      child: ImageWidget(imagePath: widget.imageUrl!, width: 50, height: 50),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}