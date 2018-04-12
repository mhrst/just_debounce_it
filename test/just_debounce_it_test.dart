library just_debounce_it_test;

import 'dart:async';
import 'package:test/test.dart';
import 'package:just_debounce_it/just_debounce_it.dart';

void main() {
  final debounceSeconds = 1;
  final debounceIterations = 1000;

  Future<int> debounceIt(Function debounceFn, Function targetFn,
      {Duration duration, int milliseconds, int seconds}) {
    // Call debounceFn multiple times
    for (var i = 0; i < debounceIterations; i++) {
      Function
          .apply(debounceFn, [duration ?? milliseconds ?? seconds, targetFn]);
    }

    duration ??= new Duration(milliseconds: milliseconds ?? (seconds * 1000));

    return new Future.delayed(duration);
  }

  group('`Debounce.duration', () {
    int counter;
    setUp(() => counter = 0);
    int target() => counter = counter + 1;
    final duration = new Duration(seconds: debounceSeconds);

    test('Should increment counter only once after repeated calls to target',
        () async {
      await debounceIt(Debounce.duration, target, duration: duration);
      expect(counter, equals(1));
    });

    test('Should NOT increment counter before specified duration', () {
      debounceIt(Debounce.duration, target, duration: duration);
      expect(counter, equals(0));
    });
  });

  group('`Debounce.milliseconds', () {
    int counter;
    setUp(() => counter = 0);
    int target() => counter = counter + 1;
    final durationMs = debounceSeconds * 1000;

    test('Should increment counter only once after repeated calls to target',
        () async {
      await debounceIt(Debounce.milliseconds, target, milliseconds: durationMs);
      expect(counter, equals(1));
    });

    test('Should NOT increment counter before specified duration', () {
      debounceIt(Debounce.milliseconds, target, milliseconds: durationMs);
      expect(counter, equals(0));
    });
  });

  group('`Debounce.seconds', () {
    int counter;
    setUp(() => counter = 0);
    int target() => counter = counter + 1;

    test('Should increment counter only once after repeated calls to target',
        () async {
      await debounceIt(Debounce.seconds, target, seconds: debounceSeconds);
      expect(counter, equals(1));
    });

    test('Should NOT increment counter before specified duration', () {
      debounceIt(Debounce.seconds, target, seconds: debounceSeconds);
      expect(counter, equals(0));
    });
  });
}
