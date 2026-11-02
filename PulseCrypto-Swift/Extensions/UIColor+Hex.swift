//
//  UIColor+Hex.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 02/11/26.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        // Spaces aur # symbol remove karein
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        let length = hexSanitized.count
        let r, g, b, a: CGFloat

        switch length {
        case 3: // RGB (12-bit) e.g., #FFF
            r = CGFloat((rgb >> 8) & 0xF) / 15.0
            g = CGFloat((rgb >> 4) & 0xF) / 15.0
            b = CGFloat(rgb & 0xF) / 15.0
            a = 1.0

        case 6: // RGB (24-bit) e.g., #007AFF
            r = CGFloat((rgb >> 16) & 0xFF) / 255.0
            g = CGFloat((rgb >> 8) & 0xFF) / 255.0
            b = CGFloat(rgb & 0xFF) / 255.0
            a = 1.0

        case 8: // RGBA (32-bit) e.g., #007AFFFF
            r = CGFloat((rgb >> 24) & 0xFF) / 255.0
            g = CGFloat((rgb >> 16) & 0xFF) / 255.0
            b = CGFloat((rgb >> 8) & 0xFF) / 255.0
            a = CGFloat(rgb & 0xFF) / 255.0

        default:
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
