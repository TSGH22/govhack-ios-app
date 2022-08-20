//
//  Font.swift
//  GovSmack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation
import SwiftUI

extension Font {
    static let urbanistHeading1 = Font.custom("Urbanist-Bold", size: 48)
    static let urbanistHeading2 = Font.custom("Urbanist-Bold", size: 40)
    static let urbanistHeading3 = Font.custom("Urbanist-Bold", size: 32)
    static let urbanistHeading4 = Font.custom("Urbanist-Bold", size: 24)
    static let urbanistHeading5 = Font.custom("Urbanist-Bold", size: 20)
    static let urbanistHeading6 = Font.custom("Urbanist-Bold", size: 18)

    static let urbanistBodyXLarge = Font.custom("Urbanist-Regular", size: 18)
    static let urbanistBodyLarge = Font.custom("Urbanist-Regular", size: 16)
    static let urbanistBodyMedium = Font.custom("Urbanist-Regular", size: 14)
    static let urbanistBodySmall = Font.custom("Urbanist-Regular", size: 12)
    static let urbanistBodyXSmall = Font.custom("Urbanist-Regular", size: 10)
}

extension Color {

    static let urbanPrimary = Color(hex: 0x2B1766)
    static let urbanSecondary = Color(hex: 0x61C1C8)
    static let urbanError = Color(hex: 0xF75555)
    static let urbanSuccess = Color(hex: 0x0BDD74)

    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }

}
