//
//  WalletBalanceView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 18/11/26.
//

import Foundation
import UIKit

final class WalletBalanceView: UIView {
    
    private let balanceCardView = NeonGlowCardView(cornerRadius: 14)
    private let assetView = AssetsListView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBasicDetail()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not be implemented")
    }
    
    private var scrollView: UIScrollView = {
        let scrollVw = UIScrollView()
        scrollVw.showsVerticalScrollIndicator = false
        scrollVw.showsHorizontalScrollIndicator = false
        scrollVw.alwaysBounceVertical = true
        scrollVw.translatesAutoresizingMaskIntoConstraints = false
        return scrollVw
    }()
    
    private let headerLbl: UILabel = {
        let label = UILabel()
        label.text = "Total Balance"
        label.textColor = .whitishGrey
        label.font = UIFont.appFont(size: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLbl: UILabel = {
        let label = UILabel()
        label.text = "$38,420.50"
        label.textColor = .white
        label.font = UIFont.appFont(size: 38, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupBasicDetail(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.assetView.translatesAutoresizingMaskIntoConstraints = false
        self.balanceCardView.translatesAutoresizingMaskIntoConstraints = false
        
        self.balanceCardView.addSubview(self.headerLbl)
        self.balanceCardView.addSubview(self.amountLbl)
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.balanceCardView)
        self.scrollView.addSubview(self.assetView)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
                        
            headerLbl.topAnchor.constraint(equalTo: balanceCardView.topAnchor, constant: 16),
            headerLbl.centerXAnchor.constraint(equalTo: balanceCardView.centerXAnchor),
            
            amountLbl.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 8),
            amountLbl.centerXAnchor.constraint(equalTo: headerLbl.centerXAnchor),
            amountLbl.bottomAnchor.constraint(equalTo: balanceCardView.bottomAnchor, constant: -16),
            
            balanceCardView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            balanceCardView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            balanceCardView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            balanceCardView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            assetView.topAnchor.constraint(equalTo: balanceCardView.bottomAnchor, constant: 20),
            assetView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            assetView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            assetView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        // to send data in asset view
        if let data = try? Bundle.main.decode(MarketData.self, from: "market.json"){
            if data.coins.count > 3 {
                assetView.configAssetData(with: Array(data.coins.prefix(3)))
            }
        }
    }
    
    func configure(amount: Double) {
        self.amountLbl.text = String(format: "%.2f", amount)
    }
}
