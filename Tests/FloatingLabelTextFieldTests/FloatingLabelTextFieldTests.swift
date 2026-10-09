import XCTest
@testable import FloatingLabelTextField

final class FloatingLabelTextFieldTests: XCTestCase {
    func testLabelFloatsWhileFocused() {
        XCTAssertTrue(
            FloatingLabelFieldLogic.shouldFloat(
                isFocused: true,
                text: ""
            )
        )
    }

    func testLabelFloatsWhenTextExists() {
        XCTAssertTrue(
            FloatingLabelFieldLogic.shouldFloat(
                isFocused: false,
                text: "Hello"
            )
        )
    }

    func testLabelDoesNotFloatWhenEmptyAndUnfocused() {
        XCTAssertFalse(
            FloatingLabelFieldLogic.shouldFloat(
                isFocused: false,
                text: ""
            )
        )
    }

    func testFocusedFieldUsesEmphasizedBorder() {
        XCTAssertEqual(
            FloatingLabelFieldLogic.borderWidth(
                isFocused: true,
                state: .normal
            ),
            1.5,
            accuracy: 0.0001
        )
    }

    func testUnfocusedNormalFieldUsesStandardBorder() {
        XCTAssertEqual(
            FloatingLabelFieldLogic.borderWidth(
                isFocused: false,
                state: .normal
            ),
            1,
            accuracy: 0.0001
        )
    }

    func testValidationStatesUseEmphasizedBorder() {
        XCTAssertEqual(
            FloatingLabelFieldLogic.borderWidth(
                isFocused: false,
                state: .success
            ),
            1.5,
            accuracy: 0.0001
        )

        XCTAssertEqual(
            FloatingLabelFieldLogic.borderWidth(
                isFocused: false,
                state: .error
            ),
            1.5,
            accuracy: 0.0001
        )
    }
}
