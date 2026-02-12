import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comancheo_cv/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? titleWidget;
  final String? title;
  final List<Widget> body;
  final Future<void> Function()? onRefresh;
  final bool primary;

  const CustomScaffold({super.key, this.titleWidget, this.title, required this.body, this.onRefresh, this.primary = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: titleWidget != null || title != null
          ? AppBar(
              leadingWidth: 100,
              toolbarHeight: 100,
              automaticallyImplyActions: false,
              leading: (!primary)?
              IconButton(onPressed: () {context.router.back();}, icon: Row(children:[Icon(Icons.arrow_back),SizedBox(width: 8), Text("Zpět")]))
              :InkWell(
                onTap: () {
                  ImageWidget.openInDialog(context, imagePath: 'https://avatars.githubusercontent.com/u/48067900', fit: BoxFit.cover, width: 200, height: 200);
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    image: DecorationImage(image: CachedNetworkImageProvider('https://avatars.githubusercontent.com/u/48067900?v=4'), fit: BoxFit.cover),
                    border: Border.all(width: 5, color: Theme.of(context).colorScheme.primary, strokeAlign: BorderSide.strokeAlignOutside),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              title: titleWidget ?? Text(title ?? "Dashboard"),
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/logo.png"), fit: BoxFit.contain, opacity: 0.1),
        ),
        padding: const EdgeInsets.all(20),
        child: RefreshIndicator(
          onRefresh: () async {
            await onRefresh?.call();
          },
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ...body,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
