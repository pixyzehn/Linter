# Linter
[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://github.com/apple/swift-package-manager)

Linter helps you to set up `.swiftlint.yml` based on initial warnings and errors by executing `swiftlint`. It also tells you about how many warnings and errors occur in each identifier and which identifier are [correctable](https://github.com/realm/SwiftLint#auto-correct) (it means you can use `swiftlint autocorrect` to fix).

After using linter, you'll see the following `.swiftlint.yml` for instance.

```yaml
disabled_rules:
  - trailing_semicolon # (48) Correctable (you can use `swiftlint autocorrect` to fix)
  - redundant_optional_initialization # (13) Correctable (you can use `swiftlint autocorrect` to fix)
  - trailing_newline # (5) Correctable (you can use `swiftlint autocorrect` to fix)
  - statement_position # (28) Correctable (you can use `swiftlint autocorrect` to fix)
  - for_where # (6)
  - weak_delegate # (1)
  ...
```

So, you can fix the warnings and errors step by step along with your project's spec.
I highly recommend you to customize more after setting up `.swiftlint.yml` by Linter.

This package is built by [PackageBuilder](https://github.com/pixyzehn/PackageBuilder).

```console
$ linter help
Linter
   help: Display general or command-specific help.
   --included: Paths to include during linting and add to `.swiftlint.yml` as `included:`.
   --excluded: Paths to ignore during linting and add to `.swiftlint.yml` as `excluded:`.
```

## Requirements

Linter requires / supports the following environments:

- Swift 4.0
- SwiftLint 0.22.0 or later

## Installation

On macOS

### Makefile

```console
$ git clone git@github.com:pixyzehn/Linter.git && cd Linter
$ make
```

### SwiftPM

```console
$ git clone git@github.com:pixyzehn/Linter.git && cd Linter
$ swift build -c release -Xswiftc -static-stdlib
$ cp -f .build/release/Linter /usr/local/bin/Linter
```

See also [SwiftLint's installation](https://github.com/realm/SwiftLint#installation)

## Usage

```console
$ linter --included Sources Tests
$ linter --included AwesomeiOS AwesomeiOSTests --excluded Pods Carthage
```

## Contributing

1. Fork it ( https://github.com/pixyzehn/Linter )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

## License
[MIT License](https://github.com/pixyzehn/Linter/blob/master/LICENSE)
