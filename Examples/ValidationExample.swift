import SwiftUI
import FloatingLabelTextField

struct ValidationExample: View {
    @State private var username = ""

    var body: some View {
        FloatingLabelTextField(
            "Username",
            text: $username,
            helperText: "3–20 characters",
            errorText: "Username is too short.",
            state: validationState,
            showsClearButton: true
        )
        .padding()
        .frame(maxWidth: 420)
    }

    private var validationState: FloatingLabelFieldState {
        guard !username.isEmpty else {
            return .normal
        }

        return username.count >= 3 ? .success : .error
    }
}
