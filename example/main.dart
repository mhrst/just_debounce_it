import 'package:just_debounce_it/just_debounce_it.dart';

void main() {
  void printSeconds() => print("Hello World (Debounce.seconds)");
  Debounce.seconds(1, printSeconds);
  Debounce.runAndClear(printSeconds); // Will print immediately

  void printMs() => print("Hello World (Debounce.milliseconds)");
  Debounce.milliseconds(500, printMs);
  Debounce.clear(printMs); // Will not run

  final duration = const Duration(milliseconds: 2000);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
}
