import 'package:just_debounce_it/just_debounce_it.dart';

main() {
  printSeconds() => print("Hello World (Debounce.seconds)");
  Debounce.seconds(1, printSeconds);
  Debounce.seconds(1, printSeconds);
  Debounce.seconds(1, printSeconds);
  Debounce.seconds(1, printSeconds);
  Debounce.seconds(1, printSeconds);

  printMs() => print("Hello World (Debounce.milliseconds)");
  Debounce.milliseconds(500, printMs);
  Debounce.milliseconds(500, printMs);
  Debounce.milliseconds(500, printMs);
  Debounce.milliseconds(500, printMs);
  Debounce.milliseconds(500, printMs);

  Duration duration = new Duration(milliseconds: 2000);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
  Debounce.duration(duration, print, ["Hello World (Debounce.duration)"]);
}