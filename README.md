# just_debounce_it

A simple debounce library. Supports debouncing by function and stream debouncing.

```dart
import 'package:just_debounce_it/just_debounce_it.dart';

Debounce.milliseconds(1000, print, ["Debounce World!"]);
```

## Static methods

There are three methods available for debouncing. All methods differ only by the first parameter used to specify timeout values in different formats. The `target` Function provided must be the same object every time `Debounce` is called.

```dart
Debounce.seconds(int timeoutSeconds, 
    Function target,
    [List<dynamic> positionalArguments, 
    Map<Symbol, dynamic> namedArguments])
```
```dart
Debounce.milliseconds(int timeoutMs, 
    Function target,
    [List<dynamic> positionalArguments, 
    Map<Symbol, dynamic> namedArguments])
```
```dart
Debounce.duration(Duration timeout, 
    Function target,
    [List<dynamic> positionalArguments, 
    Map<Symbol, dynamic> namedArguments])
```

To immediately dispatch a `target` that has previously been debounced, use `runAndClear`.
Optional `args` can be provided to override the debounced arguments:
```dart
Debounce.runAndClear( 
    Function target,
    [List<dynamic> positionalArguments, 
    Map<Symbol, dynamic> namedArguments])
```

To clear a debounced `target`:
```dart
Debounce.clear( 
    Function target,
    [List<dynamic> positionalArguments, 
    Map<Symbol, dynamic> namedArguments])
```

## Stream Debouncing

Use `DebounceStreamTransfomer` to debounce any stream by a specified duration.

```dart
DebounceStreamTransfomer(Duration timeout)
```
```dart
DebounceStreamTransfomer.seconds(int timeoutSeconds)
```
```dart
DebounceStreamTransfomer.milliseconds(int timeoutMs)
```

```dart
Stream debounceStream(Stream input) => input.transform(DebounceStreamTransfomer.seconds(1));
```


## Example

A quick demonstration can be found in the `example` directory. To run the example:

`pub run example/main.dart`

#### Credits

[https://gist.github.com/marc-hughes/8302149](https://gist.github.com/marc-hughes/8302149)

[https://github.com/dtq](https://github.com/dtq/)
