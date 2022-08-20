//
//  UIKit.swift
//  Spacey
//
//  Created by Max Chuquimia on 20/8/2022.
//

import SwiftUI

struct NiceTextField: View {
    let icon: UIImage?
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocused: Bool

    var body: some View {
        TextField(placeholder, text: $text)
            .focused($isFocused)
            .font(.urbanistBodyMedium)
            .tint(.urbanSecondary)
            .foregroundColor(.urbanPrimary)
            .padding(.vertical, 8)
            .padding(.trailing, 8)
            .padding(.leading,  icon == nil ? 8 : 35)
            .frame(height: 56)
            .background(content: { Color.urbanGrey50 })
            .cornerRadius(16)
            .overlay {
                if let icon = icon {
                    HStack {
                        Spacer()
                            .frame(width: 8)
                        Image(uiImage: icon)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Spacer()
                    }
                }
            }
            .onTapGesture {
                isFocused = true
            }
    }

}

struct FilledButton: View {

    let text: String
    let action: () -> Void

    var body: some View {
        Button(text, action: {
            action()
        })
        .frame(height: 45)
        .font(.urbanistBodyBoldXLarge)
        .foregroundColor(.white)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 23)
                .fill(Color.urbanPrimary)
        )
        .cornerRadius(23)
    }

}

struct TallFilledButton: View {

    enum Style {
        case lighter
        case darker
    }

    let text: String
    let style: Style
    let action: () -> Void

    var body: some View {
        Button(text, action: {
            action()
        })
        .frame(minWidth: 180, minHeight: 58, idealHeight: 58, maxHeight: 58)
        .font(.urbanistBodyBoldXLarge)
        .foregroundColor(style == .lighter ? .urbanPrimary : .white)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 29)
                .fill(style == .lighter ? Color.urbanSecondary300 : Color.urbanPrimary)
        )
        .cornerRadius(29)
    }

}

struct ToggleButton: View {

    let text: String
    @Binding var isSelected: Bool

    var body: some View {
        Button(text, action: {
            isSelected.toggle()
        })
        .frame(height: 38)
        .padding(.horizontal, 12)
        .background(isSelected ? AnyView(RoundedRectangle(cornerRadius: 19).fill(Color.urbanPrimary300)) : AnyView(RoundedRectangle(cornerRadius: 19).stroke(Color.urbanPrimary300, lineWidth: 2))
        )
        .font(.urbanistBodySemiboldLarge)
        .foregroundColor(isSelected ? .white : .urbanPrimary300)
    }

}

struct Lozenge: View {

    let text: String

    var body: some View {
        Text(text)
        .frame(height: 20)
        .font(.urbanistBodyBoldSmall)
        .foregroundColor(.white)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.urbanPrimary300)
        )
        .cornerRadius(16)
    }

}

struct UIKit_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            HStack {
                NiceTextField(icon: nil, placeholder: "Enter text here", text: .constant(""))
                NiceTextField(icon: nil, placeholder: "Enter text here", text: .constant("Hello!"))
                NiceTextField(icon: UIImage(named: "Calendar"), placeholder: "Date", text: .constant(""))
            }
            FilledButton(text: "Do the thing!", action: {})
            HStack {
                ToggleButton(text: "Toggled On", isSelected: .constant(true))
                ToggleButton(text: "Toggled Off", isSelected: .constant(false))
            }
            HStack {
                Lozenge(text: "Small")
                Lozenge(text: "Looooong neck")
            }
            HStack {
                TallFilledButton(text: "Next", style: .darker, action: {})
                TallFilledButton(text: "Back", style: .lighter, action: {})
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
