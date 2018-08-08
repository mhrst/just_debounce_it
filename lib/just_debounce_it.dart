library just_debounce_it;

import 'dart:async';

/// Map of functions currently being debounced.
Map<Function, _DebounceTimer> timeouts = <Function, _DebounceTimer>{};

/// A collection of of static functions to debounce calls to a target function.
class Debounce {
  /// Calls [target] with the latest supplied [args] after a [timeout] duration.
  ///
  /// Repeated calls to [duration] (or any debounce operation in this library)
  /// with the same [Function target] will reset the specified [timeout].
  static void duration(Duration timeout, Function target,
      [List<dynamic> args]) {
    if (timeouts.containsKey(target)) {
      timeouts[target].cancel();
    }

    final _DebounceTimer timer = new _DebounceTimer(timeout, target, args);

    timeouts[target] = timer;
  }

  /// Calls [duration] with a timeout specified in milliseconds.
  static void milliseconds(int timeoutMs, Function target,
      [List<dynamic> args]) {
    duration(new Duration(milliseconds: timeoutMs), target, args);
  }

  /// Run a function which is already debounced (queued to be run later),
  /// but run it now. This also cancels and clears out the timeout for
  /// that function.
  static void runAndClear(Function target) {
    if (timeouts.containsKey(target)) {
      timeouts[target].runNow();
      timeouts.remove(target);
    }
  }

  /// Calls [duration] with a timeout specified in seconds.
  static void seconds(int timeoutSeconds, Function target,
      [List<dynamic> args]) {
    duration(new Duration(seconds: timeoutSeconds), target, args);
  }
}

// _DebounceTimer allows us to keep track of the target function
// along with it's timer.
class _DebounceTimer {
  Timer timer;
  Function _target;
  List<dynamic> _args;

  _DebounceTimer(Duration timeout, Function target, List<dynamic> args) {
    _target = target;
    _args = args;
    timer = new Timer(timeout, () {
      Function.apply(_target, _args);
    });
  }

  void cancel() {
    timer.cancel();
  }

  void runNow() {
    cancel();
    Function.apply(_target, _args);
  }
}
