//
//  TrendingItem.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 03/11/26.
//

import Foundation
import UIKit

struct TrendingItem {
    let id: String
    let symbol: String
    let iconName: String
    let iconTintColor: UIColor
    let changePercentage: String
    let wavePoints: [CGFloat]
    let waveColor: UIColor
    let gradientFillColors: [CGColor]
}
