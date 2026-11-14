//
//  SwapViewModel.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 14/11/26.
//

import Foundation
import Combine

final class SwapViewModel: ObservableObject {
    
    @Published private(set) var coins = [MarketItem]()
    @Published var fromCoin: MarketItem? = nil
    @Published var toCoin: MarketItem? = nil
    @Published var usdAmount: Double = 8500.00
    @Published var slippage: Double = 0.1
    
    init(coins: [MarketItem]? = nil) {
        if let data = try? Bundle.main.decode(MarketData.self, from: "market.json"){
            
            self.coins = data.coins
            if data.coins.count > 0 {
                self.fromCoin = data.coins[0]
                self.toCoin = data.coins.count > 1 ? data.coins[1]:data.coins[0]
            }
        }
    }

    
    
    func selectFromCoin(_ coin: MarketItem){
        
        if let tocoin = toCoin, coin.id == tocoin.id {
            toCoin = fromCoin
        }
        fromCoin = coin
    }
    
    func selectToCoin(_ coin: MarketItem) {
        if let fromcoin = fromCoin, coin.id == fromcoin.id {
            fromCoin = toCoin
        }
        toCoin = coin
    }
    
    func swapPositions() {
        let temp = fromCoin
        fromCoin = toCoin
        toCoin = temp
    }
    
//    // MARK: - Computed Swap Values
//    var fromQuantity: Double {
//        guard fromCoin?.price ?? 0 > 0 else { return 0 }
//        return usdAmount / (fromCoin?.price ?? 0)
//    }
//    
//    var toQuantity: Double {
//        guard toCoin?.price ?? 0 > 0 else { return 0 }
//        return usdAmount / (toCoin?.price ?? 0)
//    }
//    
//    var conversionRate: Double {
//        guard toCoin?.price ?? 0 > 0 else { return 0 }
//        return fromCoin?.price ?? 0 / (toCoin?.price ?? 0)
//    }
//    
//    var fromAvailableInUSD: Double {
//        return 9.08
//        //return fromCoin. * fromCoin.price
//    }
//    
//    // MARK: - Formatted Strings for UI
//    var formattedUSDAmount: String {
//        return String(format: "%@%.2f", fromCoin?.currency_symbol ?? "", usdAmount)
//    }
//    
//    var formattedFromQty: String {
//        return String(format: "(%.4g %@)", fromQuantity, fromCoin?.symbol ?? "")
//    }
//    
//    var formattedAvailableBalance: String {
//        return String(format: "%@%.0f %@", fromCoin?.currency_symbol ?? "", fromAvailableInUSD, fromCoin?.symbol ?? "")
//    }
//    
//    var formattedToQty: String {
//        return String(format: "(%.4g %@)", toQuantity, toCoin?.symbol ?? "")
//    }
//    
//    var formattedRateText: String {
//        return String(format: "1 %@ ≈ %.4g %@", fromCoin?.symbol ?? "", conversionRate, toCoin?.symbol ?? "")
//    }
//    
//    var formattedApproxFrom: String {
//        return String(format: "%.2f ≈", fromQuantity)
//    }
//    
//    var formattedSlippage: String {
//        return String(format: "%.1f%%", slippage)
//    }
}
