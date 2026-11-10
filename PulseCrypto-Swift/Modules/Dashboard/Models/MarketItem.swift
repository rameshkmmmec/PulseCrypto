//
//  MarketItem.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

struct MarketData: Codable {
    let screen_title: String
    let coins: [MarketItem]
}


struct MarketItem: Codable, Identifiable {
    
    let id: Int
    let icon_name: String
    let system_icon: String
    let icon_tint_color: String
    let symbol: String
    let name: String
    let price: Double
    let currency_symbol: String
    let change_percentage: Double
    let trend: String
    let chart_color: String
    let market_cap: String
    let volume_24h: String
    let sparkline_points: [CGFloat]
    let gradientFillHex: [String]?

    var gradientFillColors: [CGColor] {
        guard let colors = gradientFillHex, !colors.isEmpty else {
            return [UIColor.clear.cgColor, UIColor.clear.cgColor]
        }
        return colors.compactMap { UIColor(hex: $0)?.cgColor }
    }
}


