// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:my_app/helper/toast/custom_animation_toast.dart';
import 'package:my_app/helper/toast/keyboard_safety.dart';
import 'package:my_app/helper/toast/toast_init.dart';
import 'package:my_app/helper/toast/toast_widget.dart';

class BotToast {
  static const int maxContentLength = 34;
  static const String notificationKey = '_notificationKey';
  static const String defaultKey = '_defaultKey';

  static final Map<String, List<CancelFunc>> cacheCancelFunc = {
    notificationKey: [],
    defaultKey: [],
  };

  static CancelFunc showAnimationWidget({
    required ToastBuilder toastBuilder,
    Duration? animationDuration,
    Duration? animationReverseDuration,
    Alignment? align = const Alignment(0, -0.99),
    WrapAnimation? wrapAnimation,
    UniqueKey? key,
    String? groupKey = notificationKey,
    bool crossPage = true,
    bool ignoreContentClick = false,
    bool onlyOne = false,
    bool enableKeyboardSafeArea = true,
    Color backgroundColor = Colors.transparent,
    Duration duration = const Duration(milliseconds: 2000),
    VoidCallback? onClose,
    bool useSafeArea = true,
  }) {
    AnimationController? controller = _createAnimationController(
      animationDuration ?? const Duration(milliseconds: 500),
      reverseDuration:
          animationReverseDuration ?? const Duration(milliseconds: 500),
    );
    wrapAnimationFunc(controller, cancel, child) {
      child = CustomOffsetAnimation(
        controller: controller,
        child: child,
      );

      if (align != null) {
        child = Align(alignment: align, child: child);
      }
      return useSafeArea ? SafeArea(child: child) : child;
    }

    return showEnhancedWidget(
      groupKey: groupKey,
      key: key,
      crossPage: crossPage,
      onClose: onClose,
      onlyOne: onlyOne,
      enableKeyboardSafeArea: enableKeyboardSafeArea,
      ignoreContentClick: ignoreContentClick,
      closeFunc: () async {
        await controller?.reverse();
      },
      duration: duration,
      warpWidget: (cancel, child) => ProxyInitState(
        initStateCallback: () {
          assert(!controller!.isAnimating);
          controller!.forward();
        },
        child: ProxyDispose(
          disposeCallback: () {
            controller!.dispose();
            controller = null;
          },
          child: wrapAnimation != null
              ? wrapAnimation(controller!, cancel, child)
              : child,
        ),
      ),
      toastBuilder: (cancelFunc) => wrapAnimationFunc(
        controller,
        cancelFunc,
        toastBuilder(cancelFunc),
      ),
    );
  }

  static CancelFunc showEnhancedWidget({
    required ToastBuilder toastBuilder,
    UniqueKey? key,
    String? groupKey,
    bool crossPage = true,
    bool clickClose = false,
    bool ignoreContentClick = false,
    bool onlyOne = false,
    bool enableKeyboardSafeArea = true,
    FutureFunc? closeFunc,
    VoidCallback? onClose,
    WrapWidget? warpWidget,
    Duration? duration,
  }) {
    late final CancelFunc cancelFunc;
    dismissFunc() async {
      await closeFunc?.call();
      cancelFunc();
    }

    final List<CancelFunc> cache =
        cacheCancelFunc[groupKey ?? defaultKey] ??= [];
    if (onlyOne) {
      final clone = cache.toList();
      cache.clear();
      for (final cancel in clone) {
        cancel();
      }
    }
    cache.add(dismissFunc);

    //Timer
    Timer? timer;
    if (duration != null) {
      timer = Timer(duration, () {
        dismissFunc();
        timer = null;
      });
    }

    BotToastNavigatorObserverProxy? observerProxy;
    if (!crossPage) {
      observerProxy = BotToastNavigatorObserverProxy.all(dismissFunc);
      BotToastNavigatorObserver.register(observerProxy);
    }

    cancelFunc = showWidget(
      groupKey: groupKey,
      key: key,
      toastBuilder: (_) {
        return KeyboardSafeArea(
          enable: enableKeyboardSafeArea,
          child: ProxyDispose(
            disposeCallback: () {
              cache.remove(dismissFunc);
              if (observerProxy != null) {
                BotToastNavigatorObserver.unregister(observerProxy);
              }
              timer?.cancel();
              onClose?.call();
            },
            child: Builder(
              builder: (context) {
                final Widget child = DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!,
                  child: IgnorePointer(
                    ignoring: ignoreContentClick,
                    child: toastBuilder(dismissFunc),
                  ),
                );
                return warpWidget != null
                    ? warpWidget(dismissFunc, child)
                    : child;
              },
            ),
          ),
        );
      },
    );

    return dismissFunc;
  }

  static CancelFunc showWidget({
    required ToastBuilder toastBuilder,
    UniqueKey? key,
    String? groupKey,
  }) {
    final gk = groupKey ?? defaultKey;
    final uniqueKey = key ?? UniqueKey();
    cancelFunc() {
      remove(uniqueKey, gk);
    }

    toastManager.insert(gk, uniqueKey, toastBuilder(cancelFunc));
    return cancelFunc;
  }

  static void remove(UniqueKey key, [String? groupKey]) {
    toastManager.remove(groupKey ?? defaultKey, key);
  }

  static void removeAll([String? groupKey]) {
    toastManager.removeAll(groupKey ?? defaultKey);
  }

  static void cleanAll() {
    toastManager.cleanAll();
  }

  static AnimationController _createAnimationController(
    Duration duration, {
    Duration? reverseDuration,
  }) {
    return AnimationController(
      vsync: TickerProviderImpl(),
      duration: duration,
      reverseDuration: reverseDuration,
    );
  }
}
