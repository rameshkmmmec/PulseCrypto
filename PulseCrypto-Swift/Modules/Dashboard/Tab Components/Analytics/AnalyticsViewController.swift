//
//  AnalyticsViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import UIKit

class AnalyticsViewController: UIViewController {

    private let headerLabel = ScreenHeaderLabel(title: "Analytics")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupLayout()
    }

    private func setupLayout(){
        
        self.view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
