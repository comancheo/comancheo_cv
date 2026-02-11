// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:comancheo_cv/auto_route/app_router.dart' as _i2;
import 'package:comancheo_cv/screens/chat.dart' as _i1;
import 'package:comancheo_cv/screens/dashboard.dart' as _i3;
import 'package:comancheo_cv/screens/home.dart' as _i4;
import 'package:comancheo_cv/screens/news.dart' as _i5;
import 'package:comancheo_cv/screens/splash.dart' as _i6;
import 'package:flutter/cupertino.dart' as _i8;

/// generated route for
/// [_i1.ChatScreen]
class ChatRoute extends _i7.PageRouteInfo<void> {
  const ChatRoute({List<_i7.PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatScreen();
    },
  );
}

/// generated route for
/// [_i2.DashboardEmptyPage]
class DashboardEmptyRoute extends _i7.PageRouteInfo<DashboardEmptyRouteArgs> {
  DashboardEmptyRoute({
    _i8.Key? key,
    String name = 'EmptyPage',
    List<_i7.PageRouteInfo>? children,
  }) : super(
         DashboardEmptyRoute.name,
         args: DashboardEmptyRouteArgs(key: key, name: name),
         initialChildren: children,
       );

  static const String name = 'DashboardEmptyRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DashboardEmptyRouteArgs>(
        orElse: () => const DashboardEmptyRouteArgs(),
      );
      return _i2.DashboardEmptyPage(key: args.key, name: args.name);
    },
  );
}

class DashboardEmptyRouteArgs {
  const DashboardEmptyRouteArgs({this.key, this.name = 'EmptyPage'});

  final _i8.Key? key;

  final String name;

  @override
  String toString() {
    return 'DashboardEmptyRouteArgs{key: $key, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DashboardEmptyRouteArgs) return false;
    return key == other.key && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i7.PageRouteInfo<void> {
  const DashboardRoute({List<_i7.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.NewsScreen]
class NewsRoute extends _i7.PageRouteInfo<void> {
  const NewsRoute({List<_i7.PageRouteInfo>? children})
    : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.NewsScreen();
    },
  );
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashScreen();
    },
  );
}
