//
//  DashboardViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 02/11/26.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    
    private let headerView = DashboardHeaderView()
    private let portfolioView = PortfolioCardView()
    private let trendingView = TrendingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDetails()
    }
    
    private func setupDetails() {
        
        view.backgroundColor = UIColor(hex: "#070D18")?.withAlphaComponent(1)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(headerView)
        view.addSubview(portfolioView)
        view.addSubview(trendingView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 56),
            
            portfolioView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            portfolioView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            portfolioView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            trendingView.topAnchor.constraint(equalTo: portfolioView.bottomAnchor, constant: 25),
            trendingView.leadingAnchor.constraint(equalTo: portfolioView.leadingAnchor),
            trendingView.trailingAnchor.constraint(equalTo: portfolioView.trailingAnchor)
        ])

        
        headerView.onProfileTapped = {
            print("profile button tapped")
        }
        
        headerView.onSearchTapped = {
            print("search button tapped")
        }
        
        portfolioView.onSendTapped = {
            print("send button tapped")
        }
        
        portfolioView.onReceiveTapped = {
            print("recieve button tapped")
        }
        
        portfolioView.onSwapTapped = {
            print("swap button tapped")
        }
    }
}
