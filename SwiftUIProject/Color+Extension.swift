//
//  Color+Extension.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 05/04/22.
//

import Foundation
import SwiftUI

extension Color{
    static let neutral000 = Color.init(UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00))
    static let neutral100 = Color.init(UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00))
    static let neutral200 = Color.init(UIColor(red: 0.97, green: 0.98, blue: 0.99, alpha: 1.00))
    static let neutral300 = Color.init(UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1.00))
    static let neutral400 = Color.init(UIColor(red: 0.80, green: 0.84, blue: 0.88, alpha: 1.00))
    static let neutral500 = Color.init(UIColor(red: 0.71, green: 0.75, blue: 0.80, alpha: 1.00))
    static let neutral600 = Color.init(UIColor(red: 0.58, green: 0.64, blue: 0.72, alpha: 1.00))
    static let neutral700 = Color.init(UIColor(red: 0.46, green: 0.51, blue: 0.58, alpha: 1.00))
    static let neutral800 = Color.init(UIColor(red: 0.28, green: 0.33, blue: 0.41, alpha: 1.00))
    static let neutral900 = Color.init(UIColor(red: 0.06, green: 0.09, blue: 0.16, alpha: 1.00))
    
    static let blue100 = Color.init(UIColor(red: 0.94, green: 0.96, blue: 1.00, alpha: 1.00))
    static let blue200 = Color.init(UIColor(red: 0.86, green: 0.92, blue: 1.00, alpha: 1.00))
    static let blue300 = Color.init(UIColor(red: 0.75, green: 0.86, blue: 1.00, alpha: 1.00))
    static let blue400 = Color.init(UIColor(red: 0.58, green: 0.77, blue: 0.99, alpha: 1.00))
    static let blue500 = Color.init(UIColor(red: 0.23, green: 0.51, blue: 0.96, alpha: 1.00))
    static let blue600 = Color.init(UIColor(red: 0.15, green: 0.39, blue: 0.92, alpha: 1.00))
    static let blue700 = Color.init(UIColor(red: 0.11, green: 0.31, blue: 0.85, alpha: 1.00))
    static let blue800 = Color.init(UIColor(red: 0.12, green: 0.23, blue: 0.54, alpha: 1.00))
    static let blue900 = Color.init(UIColor(red: 0.07, green: 0.14, blue: 0.33, alpha: 1.00))
    
    static let violet100 = Color.init(UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1.00))
    static let violet200 = Color.init(UIColor(red: 0.93, green: 0.91, blue: 1.00, alpha: 1.00))
    static let violet300 = Color.init(UIColor(red: 0.87, green: 0.84, blue: 1.00, alpha: 1.00))
    static let violet400 = Color.init(UIColor(red: 0.78, green: 0.71, blue: 0.99, alpha: 1.00))
    static let violet500 = Color.init(UIColor(red: 0.43, green: 0.23, blue: 0.97, alpha: 1.00))
    static let violet600 = Color.init(UIColor(red: 0.33, green: 0.09, blue: 0.81, alpha: 1.00))
    static let violet700 = Color.init(UIColor(red: 0.24, green: 0.04, blue: 0.64, alpha: 1.00))
    static let violet800 = Color.init(UIColor(red: 0.14, green: 0.01, blue: 0.39, alpha: 1.00))
    static let violet900 = Color.init(UIColor(red: 0.08, green: 0.00, blue: 0.24, alpha: 1.00))
    
    static let textPrimary = neutral900
    static let textSecondary = neutral800
    static let textTertiary = neutral600
    
    static let icon = neutral600
    
    static var navigation = Color(hex: "#F7F8F9")
    static var search = Color(hex: "#EAEAEC")
    static var divider = Color(hex: "#EBECED")
    
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
    
}
