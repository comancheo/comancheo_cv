import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/connection.dart';
import 'package:comancheo_cv/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CustomScaffold extends StatefulWidget {
  final Widget? titleWidget;
  final String? title;
  final List<Widget> body;
  final Future<void> Function()? onRefresh;
  final bool primary;

  const CustomScaffold({super.key, this.titleWidget, this.title, required this.body, this.onRefresh, this.primary = true});
  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  final ConnectionService _connectionService = GetIt.instance<ConnectionService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.titleWidget != null || widget.title != null
          ? AppBar(
              leadingWidth: 100,
              toolbarHeight: 100,
              automaticallyImplyActions: false,
              leading: (!widget.primary)
                  ? IconButton(
                      onPressed: () {
                        context.router.back();
                      },
                      icon: Row(children: [Icon(Icons.arrow_back), SizedBox(width: 8), Text("Zpět")]),
                    )
                  : InkWell(
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
              title: widget.titleWidget ?? Text(widget.title ?? "Dashboard"),
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/logo.png"), fit: BoxFit.contain, opacity: 0.1),
        ),
        padding: const EdgeInsets.all(20),
        child: RefreshIndicator(
          onRefresh: () async {
            await widget.onRefresh?.call();
          },
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                BlocBuilder<BoolCubit, bool>(bloc: _connectionService.isConnectedCubit, builder: (context, isConnected) {
                  if(isConnected) {
                    return SizedBox();
                  } else {
                    return InkWell(
                      onTap: () async {
                        await _connectionService.checkConnection();
                      },
                      child:Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        border: Border.all(color: Theme.of(context).colorScheme.error, width: 1, strokeAlign: BorderSide.strokeAlignInside),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: Theme.of(context).colorScheme.onErrorContainer),
                          SizedBox(width: 8),
                          Text("Není připojení k internetu", style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)),
                        ],
                      ),
                    ));
                  }
                }),
                ...widget.body,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
