import 'package:auto_route/auto_route.dart';
import 'package:comancheo_cv/auto_route/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    // HomeScreen is generated as HomeRoute because
    // of the replaceInRouteName property
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
    ),
    AutoRoute(
      page: HomeRoute.page,
      children: [
        AutoRoute(path: 'DashboardEmptyRoute', page: DashboardEmptyRoute.page, usesPathAsKey: true, children: [
          AutoRoute(path: 'Dashboard', page: DashboardRoute.page, usesPathAsKey: true),
          AutoRoute(path: 'News', page: NewsRoute.page, usesPathAsKey: true,)
        ]),
        AutoRoute(path: 'Chat', page: ChatRoute.page, usesPathAsKey: true, children: []),
      ],
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}

@RoutePage(name: 'DashboardEmptyRoute')
class DashboardEmptyPage extends AutoRouter {
  final String name;
  const DashboardEmptyPage({super.key, this.name = 'EmptyPage'});
}
