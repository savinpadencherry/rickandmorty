import '../../core/base/base_service.dart';
import 'package:flutter/material.dart';

class NavigatorService extends BaseService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> push<T>(MaterialPageRoute<T> pageRoute) async {
    log.i('push');
    if (navigatorKey.currentState == null) {
      log.e('push: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState!.push(pageRoute);
  }

  Future<T?> pushReplacement<T>(
    MaterialPageRoute<T> pageRoute,
  ) async {
    log.i('pushReplacement');
    if (navigatorKey.currentState == null) {
      log.i('pushReplacement: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState!.pushReplacement(pageRoute);
  }

  void pop<T>([T? result]) {
    log.i('pop:');
    if (navigatorKey.currentState == null) {
      log.e('goBack: Navigator State is null');
      return;
    }
    navigatorKey.currentState!.pop(result);
  }

  Future<T?> buildAndPush<T>(Widget child) async {
    log.i('buildAndPush: child: ${child.runtimeType}');
    return await push(
      MaterialPageRoute<T>(
        builder: (context) => child,
        settings: RouteSettings(name: child.runtimeType.toString()),
      ),
    );
  }

  Future<T?> buildAndPushReplacement<T>(Widget child) async {
    log.i('buildAndPushReplacement: child: ${child.runtimeType}');
    return await pushReplacement(
      MaterialPageRoute<T>(
        builder: (context) => child,
        settings: RouteSettings(name: child.runtimeType.toString()),
      ),
    );
  }
}
