library just_debounce_it;

import 'dart:async';

/// Map of functions currently being debounced.
Map<Function, _DebounceTimer> timeouts = <Function, _DebounceTimer>{};

/// A collection of of static functions to debounce calls to a target function.
class Debounce {
  /// Calls [duration] with a timeout specified in milliseconds.
  static void milliseconds(int timeoutMs, Function target,
      [List<dynamic> args]) {
    duration(Duration(milliseconds: timeoutMs), target, args);
  }

  /// Calls [duration] with a timeout specified in seconds.
  static void seconds(int timeoutSeconds, Function target,
      [List<dynamic> args]) {
    duration(Duration(seconds: timeoutSeconds), target, args);
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

    final _DebounceTimer timer = _DebounceTimer(timeout, target, args);

    timeouts[target] = timer;
  }

  /// Run a function which is already debounced (queued to be run later),
  /// but run it now. This also cancels and clears out the timeout for
  /// that function.
  /// 
  /// If [args] is not null or empty, a new version of [target] will be
  /// called with those arguments.
  static void runAndClear(Function target, [List<dynamic> args]) {
    if (timeouts.containsKey(target)) {
      if (args == null || args.isEmpty) {
        timeouts[target].runNow();
      } else {
        Function.apply(target, args);
      }
      timeouts.remove(target);
    }
  }

  /// Clear a function that has been debounced. Returns [true] if
  /// a debounced function has been removed.
  static bool clear(Function target) {
    if (timeouts.containsKey(target)) {
      timeouts.remove(target);
      return true;
    }

    return false;
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
    timer = Timer(timeout, () {
      Function.apply(_target, _args);
    });
  }

  void runNow() {
    cancel();
    Function.apply(_target, _args);
  }

  void cancel() {
    timer.cancel();
  }
}
