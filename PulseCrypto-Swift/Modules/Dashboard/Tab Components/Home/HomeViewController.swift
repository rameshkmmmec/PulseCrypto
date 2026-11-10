//
//  HomeViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import UIKit

class HomeViewController: UIViewController {

    private let headerView = DashboardHeaderView()
    private let portfolioView = PortfolioCardView()
    private let trendingView = TrendingView()
    private let marketView = MarketView()
    
    private let scrollView: UIScrollView = {
        let scrollVw = UIScrollView()
        scrollVw.showsVerticalScrollIndicator = false
        scrollVw.showsHorizontalScrollIndicator = false
        scrollVw.alwaysBounceVertical = true
        scrollVw.translatesAutoresizingMaskIntoConstraints = false
        return scrollVw
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDetails()
    }
    
    private func setupDetails() {
        
        view.backgroundColor = UIColor(hex: "#070D18")?.withAlphaComponent(1)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(portfolioView)
        scrollView.addSubview(trendingView)
        scrollView.addSubview(marketView)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           
            headerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 48),
            
            portfolioView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            portfolioView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),//16),
            portfolioView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),//-16),
            
            trendingView.topAnchor.constraint(equalTo: portfolioView.bottomAnchor, constant: 25),
            trendingView.leadingAnchor.constraint(equalTo: portfolioView.leadingAnchor),
            trendingView.trailingAnchor.constraint(equalTo: portfolioView.trailingAnchor),
            
            marketView.topAnchor.constraint(equalTo: trendingView.bottomAnchor, constant: 24),
            marketView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            marketView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            marketView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
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
