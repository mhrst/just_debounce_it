import 'dart:async';

import 'package:just_debounce_it/just_debounce_it.dart';

/// A stream transformer that debounces stream values
class DebounceStreamTransformer<T> extends StreamTransformerBase<T, T> {
  final Duration duration;
  final controller = StreamController<T>();

  /// Transforms a stream by debouncing stream values by [duration]
  DebounceStreamTransformer(this.duration);

  /// Transforms a stream by debouncing stream values by [milliseconds]
  factory DebounceStreamTransformer.milliseconds(int milliseconds) =>
      DebounceStreamTransformer(Duration(milliseconds: milliseconds));

  /// Transforms a stream by throttling stream values by [seconds]
  factory DebounceStreamTransformer.seconds(int seconds) =>
      DebounceStreamTransformer(Duration(seconds: seconds));

  /// Stream values are debounced by calling the [_addEvent] target
  /// through [Debounce.duration]. The new stream will emit
  /// the debounced values.
  @override
  Stream<T> bind(Stream<T> stream) {
    stream.listen((event) {
      Debounce.duration(duration, _addEvent, [event]);
    });
    return controller.stream;
  }

  /// Adds an event to the stream returned by [bind]
  void _addEvent(T event) {
    controller.add(event);
  }
}
