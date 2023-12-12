// Flutter imports:
// ignore_for_file: unnecessary_statements

// Flutter imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:my_app/helper/toast/toast_manager.dart';

// Project imports:
final GlobalKey<ToastManagerState> _key = GlobalKey<ToastManagerState>();

ToastManagerState get toastManager {
  assert(_key.currentState != null);
  return _key.currentState!;
}

class BotToastWidgetsBindingObserver with WidgetsBindingObserver {
  BotToastWidgetsBindingObserver._() : _listener = <PopTestFunc>[] {
    (WidgetsBinding.instance as dynamic).addObserver(this);
  }

  final List<PopTestFunc> _listener;

  static final BotToastWidgetsBindingObserver _singleton =
      BotToastWidgetsBindingObserver._();

  static BotToastWidgetsBindingObserver get singleton => _singleton;

  VoidCallback registerPopListener(PopTestFunc popTestFunc) {
    _listener.add(popTestFunc);
    return () {
      _listener.remove(popTestFunc);
    };
  }

  @override
  Future<bool> didPopRoute() async {
    if (_listener.isNotEmpty) {
      final clone = _listener.reversed.toList(growable: false);
      for (final PopTestFunc popTest in clone) {
        if (popTest()) return true;
      }
    }
    return super.didPopRoute();
  }
}

TransitionBuilder toastInit() {
  BotToastWidgetsBindingObserver._singleton;
  return (context, child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: ToastManager(key: _key, child: child!),
    );
  };
}
