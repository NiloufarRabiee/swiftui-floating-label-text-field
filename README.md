# FloatingLabelTextField

[![CI](https://github.com/NiloufarRabiee/swiftui-floating-label-text-field/actions/workflows/ci.yml/badge.svg)](https://github.com/NiloufarRabiee/swiftui-floating-label-text-field/actions/workflows/ci.yml)
![Swift](https://img.shields.io/badge/Swift-5.9%2B-orange)
![iOS](https://img.shields.io/badge/iOS-16%2B-blue)
![macOS](https://img.shields.io/badge/macOS-13%2B-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A lightweight reusable **SwiftUI text field with animated floating labels, focus states, validation feedback, and accessible form behavior**.

## Features

- Native SwiftUI
- Animated floating label
- Focus-aware border styling
- Normal, success, and error states
- Optional helper text
- Optional error text
- Clear button
- Secure entry with visibility toggle
- Keyboard configuration on iOS
- Reduce Motion support
- Accessibility labels and validation feedback
- No third-party dependencies
- iOS and macOS support
- Swift Package Manager support

## Requirements

- iOS 16+
- macOS 13+
- Swift 5.9+

## Installation

### Swift Package Manager

In Xcode:

1. Open your project.
2. Go to **File > Add Package Dependencies...**
3. Enter:

```
https://github.com/NiloufarRabiee/swiftui-floating-label-text-field
```

4. Add the `FloatingLabelTextField` package to your app target.

Then import it:

```swift
import FloatingLabelTextField
```

## Basic Usage

```swift
FloatingLabelTextField(
    "Email",
    text: $email
)
```

The label moves above the input when the field is focused or contains text.

## Helper Text

```swift
FloatingLabelTextField(
    "Username",
    text: $username,
    helperText: "3–20 characters"
)
```

## Validation

```swift
FloatingLabelTextField(
    "Email",
    text: $email,
    errorText: "Enter a valid email address.",
    state: emailIsValid ? .success : .error,
    keyboard: .emailAddress
)
```

Validation states use both color and status symbols.

## Secure Entry

```swift
FloatingLabelTextField(
    "Password",
    text: $password,
    helperText: "At least 8 characters.",
    isSecure: true
)
```

Secure fields include an optional visibility toggle.

## Clear Button

The clear button appears automatically when the field contains text.

Disable it when needed:

```swift
FloatingLabelTextField(
    "Search",
    text: $query,
    showsClearButton: false
)
```

## Keyboard Types

On iOS, choose from:

```swift
.standard
.emailAddress
.numberPad
.phonePad
.url
.decimalPad
```

The keyboard option is ignored on macOS.

## Accessibility

The field exposes its visible label to assistive technologies. Clear, secure-entry, success, and error controls include accessibility labels.

Animations are disabled automatically when Reduce Motion is enabled.

## Examples

Two examples are included:

```
Examples/SignInFormExample.swift
Examples/ValidationExample.swift
```

## Testing

The package includes unit tests for:

- Focus-driven floating behavior
- Filled-state floating behavior
- Empty unfocused state
- Focused border emphasis
- Validation border emphasis

Run:

```bash
swift test
```

## Contributing

Contributions and improvements are welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is available under the MIT License.

See [LICENSE](LICENSE).

---

Created by **Niloufar Rabiee**
