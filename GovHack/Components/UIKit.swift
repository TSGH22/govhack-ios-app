//
//  UIKit.swift
//  Spacey
//
//  Created by Max Chuquimia on 20/8/2022.
//

import SwiftUI

struct HeadingView: View {
    let title: String
    let detail: String

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            HStack {
                Text(title)
                    .font(.urbanistHeading6)
                    .foregroundColor(.urbanGrey900)
                Spacer()
                Text(detail)
                    .font(.urbanistBodyXLarge)
                    .foregroundColor(.urbanGrey500)
            }
        }
    }
}

struct CheckboxView: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            HStack {
                ZStack {
                    if isOn {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.urbanPrimary)
                            .frame(width: 24, height: 24)

                        Image(uiImage: UIImage(named: "Checkmark")!)
                            .resizable()
                            .frame(width: 9, height: 8)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.urbanPrimary, lineWidth: 3)
                            .frame(width: 24, height: 24)
                    }
                }
                Text(title)
                    .font(.urbanistBodySemiboldMedium)
                    .foregroundColor(.urbanGrey900)
                Spacer()
            }
        }
    }
}

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
    let width: CGFloat
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .frame(minWidth: width, minHeight: 58, idealHeight: 58, maxHeight: 58)
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

}

struct ToggleButton: View {

    var image: UIImage? = nil
    let text: String
    @Binding var isSelected: Bool

    var body: some View {
        Button(action: {
            isSelected.toggle()
        }, label: {
            HStack {
                if let i = image {
                    Image(uiImage: i)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .tint(isSelected ? .white : .urbanPrimary300)
                }
                Text(text)
            }
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
    let font: Font
    let backgroundColor: Color
    let textColor: Color
    let image: Image?

    init(
        text: String,
        font: Font = .urbanistBodyBoldSmall,
        backgroundColor: Color = .urbanPrimary300,
        textColor: Color = .white,
        image: Image? = nil
    ) {
        self.text = text
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.image = image
    }

    var cornerRadius: CGFloat {
        image == nil ? 16 : 25
    }

    var body: some View {
        HStack(spacing: .zero) {
            if let image = image {
                image.padding(.trailing, 7)
            }

            Text(text)
            .frame(height: 20)
            .font(font)
            .foregroundColor(textColor)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, image == nil ? 0 : 10)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
        )
        .cornerRadius(cornerRadius)
    }

}

struct UIKit_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            HeadingView(title: "Here are some components", detail: "They are epic")
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
                TallFilledButton(text: "Next", style: .darker, width: 180, action: {})
                TallFilledButton(text: "Back", style: .lighter, width: 180, action: {})
            }

            HStack {
                CheckboxView(title: "Something is off", isOn: .constant(false))
                CheckboxView(title: "Coles Radio", isOn: .constant(true))
            }
            Lozenge(
                text: "Up to 12 people",
                font: .urbanistBodySemiboldMedium,
                backgroundColor: .urbanPurple,
                textColor: .urbanGrey900,
                image: Image("starIcon")
            )
        }
        .previewLayout(.sizeThatFits)
    }
}
