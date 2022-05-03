library just_debounce_it_test;

import 'dart:async';
import 'package:test/test.dart';
import 'package:just_debounce_it/just_debounce_it.dart';

void main() {
  final debounceIterations = 1000;
  final debounceSeconds = 1;
  final debounceMilliseconds = 1000;
  final debounceDuration = Duration(seconds: debounceSeconds);

  int _counter = 0;

  int _targetNoArgs() => _counter = _counter + 1;
  int _target(int incrementBy, {int multiplier = 1}) =>
      _counter = (_counter + incrementBy) * multiplier;
  int _targetNamedOnly({int multiplier = 1}) =>
      _counter = (_counter + 1) * multiplier;

  setUp(() => _counter = 0);

  tearDown(() {
    Debounce.clear(_target);
    Debounce.clear(_targetNoArgs);
    Debounce.clear(_targetNamedOnly);
  });

  void debounceIt(Function debounceFn) {
    // Call debounceFn multiple times
    for (var i = 0; i < debounceIterations; i++) {
      debounceFn();
    }
  }

  /// Produces events faster than [t.duration]
  ///
  /// Returns the duration of the stream in milliseconds
  int debounceStream(DebounceStreamTransformer t) {
    int _ms = 0;

    // Stream values every 1/100 of [DebounceStreamTransformer.duration]
    int _periodMs = t.duration.inMilliseconds ~/ 100;

    final sc = StreamController();
    Timer.periodic(Duration(milliseconds: _periodMs), (timer) {
      _ms += _periodMs;
      sc.add(_ms);

      // Close stream after _periodMs * debounceIterations
      if (_ms == _periodMs * debounceIterations) {
        timer.cancel();
        sc.close();
      }
    });

    // Increment counter when stream emits value
    sc.stream.transform(t)..listen((event) => _counter++);

    return _periodMs * debounceIterations;
  }

  group('Debounce.duration', () {
    group('without arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.duration(debounceDuration, _targetNoArgs));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(1));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.duration(debounceDuration, _targetNoArgs));
        expect(_counter, equals(0));
      });
    });
    group('with positional arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.duration(debounceDuration, _target, [2]));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(2));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.duration(debounceDuration, _target, [2]));
        expect(_counter, equals(0));
      });
    });
    group('with named arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.duration(
            debounceDuration, _targetNamedOnly, [], {Symbol("multiplier"): 2}));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(2));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.duration(
            debounceDuration, _targetNamedOnly, [], {Symbol("multiplier"): 2}));
        expect(_counter, equals(0));
      });
    });
    group('with named and positional arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.duration(
            debounceDuration, _target, [2], {Symbol("multiplier"): 2}));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(4));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.duration(
            debounceDuration, _target, [2], {Symbol("multiplier"): 2}));
        expect(_counter, equals(0));
      });
    });
  });

  group('Debounce.milliseconds', () {
    group('without arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(
            () => Debounce.milliseconds(debounceMilliseconds, _targetNoArgs));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(1));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(
            () => Debounce.milliseconds(debounceMilliseconds, _targetNoArgs));
        expect(_counter, equals(0));
      });
    });
    group('with positional arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(
            () => Debounce.milliseconds(debounceMilliseconds, _target, [2]));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(2));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(
            () => Debounce.milliseconds(debounceMilliseconds, _target, [2]));
        expect(_counter, equals(0));
      });
    });
    group('with named arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.milliseconds(debounceMilliseconds,
            _targetNamedOnly, [], {Symbol("multiplier"): 2}));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(2));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.milliseconds(debounceMilliseconds,
            _targetNamedOnly, [], {Symbol("multiplier"): 2}));
        expect(_counter, equals(0));
      });
    });
    group('with named and positional arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.milliseconds(
            debounceMilliseconds, _target, [2], {Symbol("multiplier"): 2}));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(4));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.milliseconds(
            debounceMilliseconds, _target, [2], {Symbol("multiplier"): 2}));
        expect(_counter, equals(0));
      });
    });
  });

  group('Debounce.seconds', () {
    group('without arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.seconds(debounceSeconds, _targetNoArgs));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(1));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.seconds(debounceSeconds, _targetNoArgs));
        expect(_counter, equals(0));
      });
    });
    group('with positional arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.seconds(debounceSeconds, _target, [2]));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(2));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.seconds(debounceSeconds, _target, [2]));
        expect(_counter, equals(0));
      });
    });
    group('with named arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.seconds(
            debounceSeconds, _targetNamedOnly, [], {Symbol("multiplier"): 2}));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(2));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.seconds(
            debounceSeconds, _targetNamedOnly, [], {Symbol("multiplier"): 2}));
        expect(_counter, equals(0));
      });
    });
    group('with named and positional arguments', () {
      test('Should increment counter only once after repeated calls to target',
          () async {
        debounceIt(() => Debounce.seconds(
            debounceSeconds, _target, [2], {Symbol("multiplier"): 2}));
        await Future.delayed(debounceDuration);
        expect(_counter, equals(4));
      });

      test('Should NOT increment counter before specified duration', () {
        debounceIt(() => Debounce.seconds(
            debounceSeconds, _target, [2], {Symbol("multiplier"): 2}));
        expect(_counter, equals(0));
      });
    });
  });

  group('Debounce.clear', () {
    test('Should cancel debounced target', () async {
      debounceIt(() => Debounce.duration(debounceDuration, _targetNoArgs));
      Debounce.clear(_targetNoArgs);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(0));
    });
  });

  group('Debounce.runAndClear', () {
    test('Should run debounced target immediately and cancel', () async {
      debounceIt(() => Debounce.duration(debounceDuration, _targetNoArgs));
      Debounce.runAndClear(_targetNoArgs);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(1));
    });

    test('Should run debounced target with same positional arguments',
        () async {
      debounceIt(() => Debounce.duration(debounceDuration, _target, [2]));
      Debounce.runAndClear(_target);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(2));
    });

    test('Should run debounced target with same named arguments', () async {
      debounceIt(() => Debounce.duration(
          debounceDuration, _targetNamedOnly, [], {Symbol("multiplier"): 2}));
      Debounce.runAndClear(_targetNamedOnly);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(2));
    });

    test('Should run debounced target with same positional and named arguments',
        () async {
      debounceIt(() => Debounce.duration(
          debounceDuration, _target, [2], {Symbol("multiplier"): 2}));
      Debounce.runAndClear(_target);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(4));
    });

    test('Should run debounced target with new positional arugments', () async {
      debounceIt(() => Debounce.duration(debounceDuration, _target, [3]));
      Debounce.runAndClear(_target);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(3));
    });

    test('Should run debounced target with new named arguments', () async {
      debounceIt(() => Debounce.duration(
          debounceDuration, _targetNamedOnly, [], {Symbol("multiplier"): 3}));
      Debounce.runAndClear(_targetNamedOnly);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(3));
    });

    test('Should run debounced target with new positional and named arguments',
        () async {
      debounceIt(() => Debounce.duration(
          debounceDuration, _target, [3], {Symbol("multiplier"): 3}));
      Debounce.runAndClear(_target);
      await Future.delayed(debounceDuration);
      expect(_counter, equals(9));
    });
  });

  group('DebounceStreamTransformer', () {
    test('Should debounce stream by duration', () async {
      final durationMs = debounceStream(
          DebounceStreamTransformer(Duration(seconds: debounceSeconds)));
      await Future.delayed(
          Duration(milliseconds: durationMs + debounceMilliseconds + 100));
      expect(_counter, equals(1));
    });

    test('Should throttle stream by seconds', () async {
      final durationMs =
          debounceStream(DebounceStreamTransformer.seconds(debounceSeconds));
      await Future.delayed(
          Duration(milliseconds: durationMs + debounceMilliseconds + 100));
      expect(_counter, equals(1));
    });

    test('Should throttle stream by milliseconds', () async {
      final durationMs = debounceStream(
          DebounceStreamTransformer.milliseconds(debounceMilliseconds));
      await Future.delayed(
          Duration(milliseconds: durationMs + debounceMilliseconds + 100));
      expect(_counter, equals(1));
    });
  });
}
