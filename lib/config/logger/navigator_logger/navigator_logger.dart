import 'package:flutter/widgets.dart';
import 'package:talker/talker.dart';

class NavigatorLogger extends NavigatorObserver {
  final Talker _talker;

  NavigatorLogger({required Talker talker}) : _talker = talker;

  @override
  void didPop(Route route, Route? previousRoute) {
    _talker.log('🔙 Navigation popped: ${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _talker.log('🚀 Navigation pushed: ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _talker.log('🗑️ Navigation removed: ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _talker.log(
      '🔄 Navigation replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
