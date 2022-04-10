//
//  SwiftUIView 2.swift
//
//
//  Created by Kit Langton on 12/22/20.
//

import SwiftUI

public struct MultiTextField: View {
    var title: String
    @Binding var text: String
    var isFocused: Binding<Bool>?
    var font: UIFont = .systemFont(ofSize: 16)
    @State var height: CGFloat = 0
    var returnKeyType: ReturnKeyType
    var onCommit: (() -> Void)?
    var onTab: (() -> Void)?
    var onBackTab: (() -> Void)?

    /// Creates a multiline text field with a text label.
    ///
    /// - Parameters:
    ///   - title: The title of the text field.
    ///   - text: The text to display and edit.
    ///   - isFocused: Whether or not the field should be focused.
    ///   - returnKeyType: The type of return key to be used on iOS.
    ///   - onCommit: An action to perform when the user presses the
    ///     Return key) while the text field has focus. If `nil`, a newline
    ///     will be inserted.
    public init<S: StringProtocol>(
        _ title: S,
        text: Binding<String>,
        isFocused: Binding<Bool>? = nil,
        returnKeyType: ReturnKeyType = .default,
        font: UIFont = .systemFont(ofSize: 16),
        onTab: (() -> Void)? = nil,
        onBackTab: (() -> Void)? = nil,
        onCommit: (() -> Void)? = nil
    ) {
        self.title = String(title)
        _text = text
        self.isFocused = isFocused
        self.font = font
        self.returnKeyType = returnKeyType
        self.onCommit = onCommit
        self.onTab = onTab
        self.onBackTab = onBackTab
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            Text(title)
                .foregroundColor(.secondary)
                .opacity(text.isEmpty ? 0.5 : 0)
                .animation(nil)

            #if os(iOS)
                MultiTextFieldRep(
                    text: $text,
                    isFocused: isFocused,
                    height: $height,
                    font: font,
                    returnKeyType: returnKeyType,
                    onCommit: onCommit
                )
                .frame(height: height)
            #elseif os(macOS)
                MultiTextFieldRep(
                    text: $text,
                    isFocused: isFocused,
                    height: $height,
                    font: font,
                    onCommit: onCommit,
                    onTab: onTab,
                    onBackTab: onBackTab
                )
                .frame(height: height)
            #endif
        }
    }
}

// MARK: - ReturnKeyType

public extension MultiTextField {
    enum ReturnKeyType: String, CaseIterable {
        case done
        case next
        case `default`
        case `continue`
        case go
        case search
        case send

        #if os(iOS)
            var uiReturnKey: UIReturnKeyType {
                switch self {
                case .done:
                    return .done
                case .next:
                    return .next
                case .default:
                    return .default
                case .continue:
                    return .continue
                case .go:
                    return .go
                case .search:
                    return .search
                case .send:
                    return .send
                }
            }
        #endif
    }
}
