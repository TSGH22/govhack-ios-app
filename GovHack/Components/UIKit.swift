//
//  UIKit.swift
//  Spacey
//
//  Created by Max Chuquimia on 20/8/2022.
//

import SwiftUI

struct FilledButton: View {

    let text: String
    let action: () -> Void

    var body: some View {
        Button(text, action: {
            action()
        })
        .frame(height: 32)
        .font(.urbanistBodySemiboldMedium)
        .foregroundColor(.white)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.urbanPrimary)
        )
        .cornerRadius(16)
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
        .background(isSelected ? AnyView(RoundedRectangle(cornerRadius: 19).fill(Color.urbanPrimary)) : AnyView(RoundedRectangle(cornerRadius: 19).stroke(Color.urbanPrimary, lineWidth: 2))
        )
        .font(.urbanistBodySemiboldLarge)
        .foregroundColor(isSelected ? .white : .urbanPrimary)
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
                .fill(Color.urbanPrimary)
        )
        .cornerRadius(16)
    }

}

struct UIKit_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            FilledButton(text: "Do the thing!", action: {})
            HStack {
                ToggleButton(text: "Toggled On", isSelected: .constant(true))
                Spacer()
            }
            ToggleButton(text: "Toggled Off", isSelected: .constant(false))
            Lozenge(text: "Small")
            Lozenge(text: "Looooong neck")
        }
        .previewLayout(.sizeThatFits)
    }
}
