# just_debounce_it

A simple debounce library.

```dart
import 'package:just_debounce_it/just_debounce_it.dart';

Debounce.milliseconds(1000, print, ["Debounce World!"]);
```

## Static methods

There are three methods available for debouncing. All methods differ only by the first parameter used to specify timeout values in different formats:

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

## Example

A quick demonstration can be found in the `example` directory. To run the example:

`pub run example/main.dart`

#### Credits

[https://gist.github.com/marc-hughes/8302149](https://gist.github.com/marc-hughes/8302149)

[https://github.com/dtq](https://github.com/dtq/)
