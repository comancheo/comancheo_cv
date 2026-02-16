import 'package:auto_route/auto_route.dart';
import 'package:comancheo_cv/auto_route/app_router.gr.dart';
import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/models/app_notification.dart';
import 'package:comancheo_cv/services/chat.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:comancheo_cv/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatService chatService = GetIt.instance.get<ChatService>();
  final Set notificationDialogOpenIds = {};
  @override
  void initState() {
    super.initState();
    globals.checkNotificationToShow.stream.listen((event) {
      debugPrint('Notification event received: $event');
      if ((event) && globals.notificationToShow != null && !(notificationDialogOpenIds.contains(globals.notificationToShow?.id))) {
        notificationDialogOpenIds.add(globals.notificationToShow?.id);
        showNotification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
  listeners: [
    BlocListener<NullStringCubit, String?>(
      bloc:chatService.token,
      listener: (context, state) {
        setState(() {
          
        });
      },
    ),
    BlocListener<BoolCubit, bool>(
      bloc:chatService.verified,
      listener: (context, state) {
        setState(() {
          
        });
      },
    ),
  ],
  child: SafeArea(
          top: true,
          bottom: true,
          child: AutoTabsScaffold(
            routes: [
              DashboardEmptyRoute(children: [DashboardRoute()]),
              ChatEmptyRoute(children: [((chatService.token.state??'').isNotEmpty && chatService.verified.state)? ChatRoute() : ChatLoginRoute()]),
            ],
            extendBody: true,
            bottomNavigationBuilder: (_, tabsRouter) {
              return BottomNavigationBar(
                useLegacyColorScheme: false,
                backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                  BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
                ],
              );
            },
          ),
        )
    );
  }

  Future<void> showNotification({AppNotification? notifToShow}) async {
    try {
      AppNotification notif = notifToShow ?? AppNotification.fromJson(globals.notificationToShow!.toJson());
      debugPrint('showNotification');
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialog(title: notif.title, body: notif.body);
        },
      );
      if(chatService.token.state != null){
        await chatService.receiveMessages();
      }

      notificationDialogOpenIds.remove(notif.id);
      globals.notificationToShow = null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
