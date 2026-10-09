import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

public enum FloatingLabelFieldState: Equatable, Sendable {
    case normal
    case success
    case error
}

public enum FloatingLabelKeyboard: Equatable, Sendable {
    case standard
    case emailAddress
    case numberPad
    case phonePad
    case url
    case decimalPad
}

public struct FloatingLabelTextField: View {
    private let title: String
    @Binding private var text: String

    private let helperText: String?
    private let errorText: String?
    private let state: FloatingLabelFieldState
    private let keyboard: FloatingLabelKeyboard
    private let isSecure: Bool
    private let showsClearButton: Bool
    private let showsSecureToggle: Bool
    private let animation: Animation

    @FocusState private var isFocused: Bool
    @State private var revealsSecureText = false

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        _ title: String,
        text: Binding<String>,
        helperText: String? = nil,
        errorText: String? = nil,
        state: FloatingLabelFieldState = .normal,
        keyboard: FloatingLabelKeyboard = .standard,
        isSecure: Bool = false,
        showsClearButton: Bool = true,
        showsSecureToggle: Bool = true,
        animation: Animation = .easeInOut(duration: 0.18)
    ) {
        self.title = title
        _text = text
        self.helperText = helperText
        self.errorText = errorText
        self.state = state
        self.keyboard = keyboard
        self.isSecure = isSecure
        self.showsClearButton = showsClearButton
        self.showsSecureToggle = showsSecureToggle
        self.animation = animation
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            fieldContainer
            supportingText
        }
        .animation(reduceMotion ? nil : animation, value: isFloating)
        .animation(reduceMotion ? nil : animation, value: state)
    }

    private var fieldContainer: some View {
        VStack(alignment: .leading, spacing: isFloating ? 3 : 0) {
            if isFloating {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(labelColor)
                    .accessibilityHidden(true)
            }

            HStack(spacing: 8) {
                ZStack(alignment: .leading) {
                    if !isFloating {
                        Text(title)
                            .foregroundStyle(.secondary)
                            .accessibilityHidden(true)
                    }

                    inputField
                }

                trailingControls
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, isFloating ? 9 : 13)
        .frame(minHeight: 56)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.primary.opacity(0.035))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(borderColor, lineWidth: borderWidth)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }

    @ViewBuilder
    private var inputField: some View {
        if isSecure && !revealsSecureText {
            SecureField("", text: $text)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .modifier(KeyboardModifier(keyboard: keyboard))
                .accessibilityLabel(Text(title))
        } else {
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .modifier(KeyboardModifier(keyboard: keyboard))
                .accessibilityLabel(Text(title))
        }
    }

    @ViewBuilder
    private var trailingControls: some View {
        if showsClearButton && !text.isEmpty {
            Button {
                text = ""
                isFocused = true
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Clear text")
        }

        if isSecure && showsSecureToggle {
            Button {
                revealsSecureText.toggle()
                isFocused = true
            } label: {
                Image(
                    systemName: revealsSecureText ? "eye.slash" : "eye"
                )
                .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(
                revealsSecureText ? "Hide text" : "Show text"
            )
        }

        if state == .success {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .accessibilityLabel("Valid")
        } else if state == .error {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.red)
                .accessibilityLabel("Error")
        }
    }

    @ViewBuilder
    private var supportingText: some View {
        if state == .error, let errorText, !errorText.isEmpty {
            Label(errorText, systemImage: "exclamationmark.circle")
                .font(.caption)
                .foregroundStyle(.red)
                .accessibilityLabel(Text("Error: \(errorText)"))
        } else if let helperText, !helperText.isEmpty {
            Text(helperText)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var isFloating: Bool {
        FloatingLabelFieldLogic.shouldFloat(
            isFocused: isFocused,
            text: text
        )
    }

    private var labelColor: Color {
        switch state {
        case .normal:
            return isFocused ? .accentColor : .secondary
        case .success:
            return .green
        case .error:
            return .red
        }
    }

    private var borderColor: Color {
        switch state {
        case .normal:
            return isFocused
                ? .accentColor
                : Color.secondary.opacity(0.35)
        case .success:
            return .green
        case .error:
            return .red
        }
    }

    private var borderWidth: CGFloat {
        FloatingLabelFieldLogic.borderWidth(
            isFocused: isFocused,
            state: state
        )
    }
}

enum FloatingLabelFieldLogic {
    static func shouldFloat(
        isFocused: Bool,
        text: String
    ) -> Bool {
        isFocused || !text.isEmpty
    }

    static func borderWidth(
        isFocused: Bool,
        state: FloatingLabelFieldState
    ) -> CGFloat {
        if state != .normal {
            return 1.5
        }

        return isFocused ? 1.5 : 1
    }
}

private struct KeyboardModifier: ViewModifier {
    let keyboard: FloatingLabelKeyboard

    @ViewBuilder
    func body(content: Content) -> some View {
        #if canImport(UIKit)
        content.keyboardType(keyboard.uiKeyboardType)
        #else
        content
        #endif
    }
}

#if canImport(UIKit)
private extension FloatingLabelKeyboard {
    var uiKeyboardType: UIKeyboardType {
        switch self {
        case .standard:
            return .default
        case .emailAddress:
            return .emailAddress
        case .numberPad:
            return .numberPad
        case .phonePad:
            return .phonePad
        case .url:
            return .URL
        case .decimalPad:
            return .decimalPad
        }
    }
}
#endif
