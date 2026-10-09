import SwiftUI
import FloatingLabelTextField

struct SignInFormExample: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            FloatingLabelTextField(
                "Email",
                text: $email,
                helperText: "Use the address linked to your account.",
                state: emailState,
                keyboard: .emailAddress
            )

            FloatingLabelTextField(
                "Password",
                text: $password,
                helperText: "At least 8 characters.",
                state: passwordState,
                isSecure: true
            )
        }
        .padding()
        .frame(maxWidth: 480)
    }

    private var emailState: FloatingLabelFieldState {
        if email.isEmpty {
            return .normal
        }

        return email.contains("@") ? .success : .error
    }

    private var passwordState: FloatingLabelFieldState {
        if password.isEmpty {
            return .normal
        }

        return password.count >= 8 ? .success : .error
    }
}
