//
//  UIFont.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 14/11/26.
//

import Foundation
import UIKit

enum AppFont: String {
    
    case thin = "Inter-Thin"
    case extraLight = "Inter-ExtraLight"
    case light = "Inter-Light"
    case regular = "Inter-Regular"
    case medium = "Inter-Medium"
    case semiBold = "Inter-SemiBold"
    case bold = "Inter-Bold"
    case extraBold = "Inter-ExtraBold"
    case black = "Inter-Black"
}

extension UIFont {
    
    static func appFont(size: CGFloat, weight: AppFont, monoSpacedDigits: Bool = false) -> UIFont {
        
        let baseFont = UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: size)
        
        guard monoSpacedDigits else { return baseFont }
        
        let descriptor = baseFont.fontDescriptor.addingAttributes([
            .featureSettings : [
                [
                    UIFontDescriptor.FeatureKey.type : kNumberSpacingType,
                    UIFontDescriptor.FeatureKey.selector : kMonospacedNumbersSelector
                ]
            ]
        ])
        return UIFont(descriptor: descriptor, size: size)
    }
}
