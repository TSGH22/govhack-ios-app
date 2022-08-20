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

    static let urbanistBodySemiboldXLarge = Font.custom("Urbanist-SemiBold", size: 18)
    static let urbanistBodySemiboldLarge = Font.custom("Urbanist-SemiBold", size: 16)
    static let urbanistBodySemiboldMedium = Font.custom("Urbanist-SemiBold", size: 14)
    static let urbanistBodySemiboldSmall = Font.custom("Urbanist-SemiBold", size: 12)
    static let urbanistBodySemiboldXSmall = Font.custom("Urbanist-SemiBold", size: 10)

    static let urbanistBodyBoldXLarge = Font.custom("Urbanist-Bold", size: 18)
    static let urbanistBodyBoldLarge = Font.custom("Urbanist-Bold", size: 16)
    static let urbanistBodyBoldMedium = Font.custom("Urbanist-Bold", size: 14)
    static let urbanistBodyBoldSmall = Font.custom("Urbanist-Bold", size: 12)
    static let urbanistBodyBoldXSmall = Font.custom("Urbanist-Bold", size: 10)
}

extension Color {

    static let urbanPrimary = Color(hex: 0x2B1766)
    static let urbanPrimary400 = Color(hex: 0x402E75)
    static let urbanPrimary300 = Color(hex: 0x554585)
    static let urbanSecondary = Color(hex: 0x61C1C8)
    static let urbanSecondary400 = Color(hex: 0x90D4D9)
    static let urbanSecondary300 = Color(hex: 0xC0E6E9)
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
