// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:comancheo_cv/auto_route/app_router.dart' as _i1;
import 'package:comancheo_cv/screens/chat.dart' as _i3;
import 'package:comancheo_cv/screens/chat_login.dart' as _i2;
import 'package:comancheo_cv/screens/dashboard.dart' as _i4;
import 'package:comancheo_cv/screens/home.dart' as _i5;
import 'package:comancheo_cv/screens/news.dart' as _i6;
import 'package:comancheo_cv/screens/splash.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i9;

/// generated route for
/// [_i1.ChatEmptyPage]
class ChatEmptyRoute extends _i8.PageRouteInfo<ChatEmptyRouteArgs> {
  ChatEmptyRoute({
    _i9.Key? key,
    String name = 'EmptyPage',
    List<_i8.PageRouteInfo>? children,
  }) : super(
         ChatEmptyRoute.name,
         args: ChatEmptyRouteArgs(key: key, name: name),
         initialChildren: children,
       );

  static const String name = 'ChatEmptyRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatEmptyRouteArgs>(
        orElse: () => const ChatEmptyRouteArgs(),
      );
      return _i1.ChatEmptyPage(key: args.key, name: args.name);
    },
  );
}

class ChatEmptyRouteArgs {
  const ChatEmptyRouteArgs({this.key, this.name = 'EmptyPage'});

  final _i9.Key? key;

  final String name;

  @override
  String toString() {
    return 'ChatEmptyRouteArgs{key: $key, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatEmptyRouteArgs) return false;
    return key == other.key && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i2.ChatLoginScreen]
class ChatLoginRoute extends _i8.PageRouteInfo<void> {
  const ChatLoginRoute({List<_i8.PageRouteInfo>? children})
    : super(ChatLoginRoute.name, initialChildren: children);

  static const String name = 'ChatLoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChatLoginScreen();
    },
  );
}

/// generated route for
/// [_i3.ChatScreen]
class ChatRoute extends _i8.PageRouteInfo<void> {
  const ChatRoute({List<_i8.PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChatScreen();
    },
  );
}

/// generated route for
/// [_i1.DashboardEmptyPage]
class DashboardEmptyRoute extends _i8.PageRouteInfo<DashboardEmptyRouteArgs> {
  DashboardEmptyRoute({
    _i9.Key? key,
    String name = 'EmptyPage',
    List<_i8.PageRouteInfo>? children,
  }) : super(
         DashboardEmptyRoute.name,
         args: DashboardEmptyRouteArgs(key: key, name: name),
         initialChildren: children,
       );

  static const String name = 'DashboardEmptyRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DashboardEmptyRouteArgs>(
        orElse: () => const DashboardEmptyRouteArgs(),
      );
      return _i1.DashboardEmptyPage(key: args.key, name: args.name);
    },
  );
}

class DashboardEmptyRouteArgs {
  const DashboardEmptyRouteArgs({this.key, this.name = 'EmptyPage'});

  final _i9.Key? key;

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
/// [_i4.DashboardScreen]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute({List<_i8.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.NewsScreen]
class NewsRoute extends _i8.PageRouteInfo<void> {
  const NewsRoute({List<_i8.PageRouteInfo>? children})
    : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.NewsScreen();
    },
  );
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashScreen();
    },
  );
}
