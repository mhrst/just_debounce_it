# just_debounce_it

[![Build Status](https://api.travis-ci.org/localhurst/just_debounce_it.svg?branch=master)](https://travis-ci.org/localhurst/just_debounce_it)

A simple debounce library.

```dart
import 'package:just_debounce_it/just_debounce_it.dart';

Debounce.milliseconds(1000, print, ["Debounce World!"]);
```

## Static methods

There are three methods available for debouncing:

```dart
Debounce.seconds(int timeoutSeconds, Function target, [List<dynamic> args])
```
```dart
Debounce.milliseconds(int timeoutMs, Function target, [List<dynamic> args])
```
```dart
Debounce.duration(Duration timeout, Function target, [List<dynamic> args])
```

All methods differ only by the first parameter used to specify timeout values in different formats.

## Example

A quick demonstration can be found in the `example` directory. To run the example:

`pub run example/main.dart`

#### Credits

[https://gist.github.com/marc-hughes/8302149](https://gist.github.com/marc-hughes/8302149)