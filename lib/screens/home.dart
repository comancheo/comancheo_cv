import 'package:auto_route/auto_route.dart';
import 'package:comancheo_cv/auto_route/app_router.gr.dart';
import 'package:comancheo_cv/models/app_notification.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:comancheo_cv/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set notificationDialogOpenIds = {};
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
    return SafeArea(
      top: true,
      bottom: true,
      child: AutoTabsScaffold(
        routes: [DashboardEmptyRoute(children:[DashboardRoute()]), ChatRoute()],
        extendBody: true,
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
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
    );
  }

  Future<void> showNotification({AppNotification? notifToShow}) async {
    try {
      AppNotification notif = notifToShow ?? AppNotification.fromJson(globals.notificationToShow!.toJson());
      debugPrint('showNotification');
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: notif.title,
            body: notif.body,
          );
        },
      );

      notificationDialogOpenIds.remove(notif.id);
      globals.notificationToShow = null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
