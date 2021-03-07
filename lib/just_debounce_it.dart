library just_debounce_it;

import 'dart:async';

/// Map of functions currently being debounced.
Map<Function, _DebounceTimer> timeouts = <Function, _DebounceTimer>{};

/// A collection of of static functions to debounce calls to a target function.
class Debounce {
  /// Clear a function that has been debounced. Returns [true] if
  /// a debounced function has been removed.
  static bool clear(Function target) {
    if (timeouts.containsKey(target)) {
      timeouts[target]?.cancel();
      timeouts.remove(target);
      return true;
    }

    return false;
  }

  /// Calls [target] with the latest supplied [positionalArguments] and [namedArguments]
  /// after a [timeout] duration.
  ///
  /// Repeated calls to [duration] (or any debounce operation in this library)
  /// with the same [Function target] will reset the specified [timeout].
  static void duration(Duration timeout, Function target,
      [List<dynamic> positionalArguments = const [],
      Map<Symbol, dynamic> namedArguments = const {}]) {
    if (timeouts.containsKey(target)) {
      timeouts[target]?.cancel();
    }

    final _DebounceTimer timer =
        _DebounceTimer(timeout, target, positionalArguments, namedArguments);

    timeouts[target] = timer;
  }

  /// Calls [duration] with a timeout specified in milliseconds.
  static void milliseconds(int timeoutMs, Function target,
      [List<dynamic> positionalArguments = const [],
      Map<Symbol, dynamic> namedArguments = const {}]) {
    duration(Duration(milliseconds: timeoutMs), target, positionalArguments,
        namedArguments);
  }

  /// Run a function which is already debounced (queued to be run later),
  /// but run it now. This also cancels and clears out the timeout for
  /// that function.
  ///
  /// If [positionalArguments] and [namedArguments] is not null or empty,
  /// a new version of [target] will be called with those arguments.
  static void runAndClear(Function target,
      [List<dynamic> positionalArguments = const [],
      Map<Symbol, dynamic> namedArguments = const {}]) {
    if (timeouts.containsKey(target)) {
      if (positionalArguments.isNotEmpty || namedArguments.isNotEmpty) {
        timeouts[target]?.cancel();
        Function.apply(target, positionalArguments, namedArguments);
      } else {
        timeouts[target]?.runNow();
      }
      timeouts.remove(target);
    }
  }

  /// Calls [duration] with a timeout specified in seconds.
  static void seconds(int timeoutSeconds, Function target,
      [List<dynamic> positionalArguments = const [],
      Map<Symbol, dynamic> namedArguments = const {}]) {
    duration(Duration(seconds: timeoutSeconds), target, positionalArguments,
        namedArguments);
  }
}

// _DebounceTimer allows us to keep track of the target function
// along with it's timer.
class _DebounceTimer {
  final Timer timer;
  final Function target;
  final List<dynamic> positionalArguments;
  final Map<Symbol, dynamic> namedArguments;

  _DebounceTimer(Duration timeout, this.target,
      [this.positionalArguments = const [], this.namedArguments = const {}])
      : timer = Timer(timeout, () {
          Function.apply(target, positionalArguments, namedArguments);
        });

  void cancel() {
    timer.cancel();
  }

  void runNow() {
    cancel();
    Function.apply(target, positionalArguments, namedArguments);
  }
}
