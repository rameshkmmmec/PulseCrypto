//
//  DashboardViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 02/11/26.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController, FloatingTabBarDelegate {

    private let tabbarView = FloatingTabBarView()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var homeVc = HomeViewController()
    private lazy var analyticsVc = AnalyticsViewController()
    private lazy var walletVc = MyWalletViewController()
    private lazy var swapVc = SwapAssetsViewController()
    private lazy var settingsVc = SettingsViewController()

    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDetails()
        switchTab(to: homeVc)
    }
    
    private func setupDetails() {
        
        view.backgroundColor = UIColor(hex: "#070D18")?.withAlphaComponent(1)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabbarView.delegate = self
        
        view.addSubview(containerView)
        view.addSubview(tabbarView)
        view.bringSubviewToFront(tabbarView)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           
            tabbarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 25),
            tabbarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tabbarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tabbarView.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    func didSelectTab(at index: Int) {
        switch index {
        case 0:
            switchTab(to: homeVc)
        case 1:
            switchTab(to: analyticsVc) // 📊
        case 2:
            switchTab(to: swapVc)      // 🔄
        case 3:
            switchTab(to: walletVc)    // 👛
        case 4:
            switchTab(to: settingsVc)  // ⚙️
        default:
            break
        }
    }
    
    private func switchTab(to targetVC: UIViewController) {
        // Agar same tab par baar baar click kiya toh ignore karein
        guard currentViewController != targetVC else { return }
        
        // 1. Old view controller remove karein process hierarchy se
        if let previousVC = currentViewController {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        
        // 2. New view controller attach karein stack me
        addChild(targetVC)
        targetVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(targetVC.view)
        
        NSLayoutConstraint.activate([
            targetVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            targetVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            targetVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            targetVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        targetVC.didMove(toParent: self)
        currentViewController = targetVC
        
        // Smooth transition effect
        targetVC.view.alpha = 0
        UIView.animate(withDuration: 0.2) {
            targetVC.view.alpha = 1
        }
    }
    
}
