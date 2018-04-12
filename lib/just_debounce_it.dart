library just_debounce_it;

import 'dart:async';

/// Map of functions currently being debounced.
Map<Function, Timer> timeouts = <Function, Timer>{};

/// A collection of of static functions to debounce calls to a target function.
class Debounce {
  /// Calls [duration] with a timeout specified in milliseconds.
  static void milliseconds(int timeoutMs, Function target,
      [List<dynamic> args]) {
    duration(new Duration(milliseconds: timeoutMs), target, args);
  }

  /// Calls [duration] with a timeout specified in seconds.
  static void seconds(int timeoutSeconds, Function target,
      [List<dynamic> args]) {
    duration(new Duration(seconds: timeoutSeconds), target, args);
  }

  /// Calls [target] with the latest supplied [args] after a [timeout] duration.
  ///
  /// Repeated calls to [duration] (or any debounce operation in this library)
  /// with the same [Function target] will reset the specified [timeout].
  static void duration(Duration timeout, Function target,
      [List<dynamic> args]) {
    if (timeouts.containsKey(target)) {
      timeouts[target].cancel();
    }

    final dynamic timer = new Timer(timeout, () {
      Function.apply(target, args);
    });

    timeouts[target] = timer;
  }
}
