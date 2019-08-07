# Changelog

## 3.0.0+1
  * Moved repo to main github account (@truthmast)
  * Allow the use of named arguments
      * Arguments are passed as `Map<Symbol, dynamic>` -- using `Symbol` is more error proof than allowing a `String` but not as user friendly. TODO: Parse `Map<String, dynamic>`, but that will be a breaking change for major version `4`

## 2.0.0
  * Update dependencies for Dart 2.0.
  * Remove explicity analysis options YAML.
  * Add `runAndClear` method to immediately dispatch a debounced target.

## 1.0.4

  * Run `dartfmt`.
  * Adjust `analysis_options.yaml` and fix issues.
  * Add travis YAML. 

## 1.0.3

  * Move project into repo. Fix typos in README.md.

## 1.0.2

  * Clean-up README.md.
  
## 1.0.1

  * Improved documentation. Added example.
  
## 1.0.0

  * Initial version of a debounce library.