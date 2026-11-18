//
//  MyWalletViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import UIKit

class MyWalletViewController: UIViewController {

    private let headerLabel = ScreenHeaderLabel(title: "My Wallet")
    private let balanceView = WalletBalanceView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupLayout()
    }


    func setupLayout(){
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(headerLabel)
        self.view.addSubview(balanceView)
        
        NSLayoutConstraint.activate([
        
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            balanceView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            balanceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            //balanceView.heightAnchor.constraint(equalToConstant: 120)
            
        ])
        
        //balanceView.configure(amount: 38420.50)
    }
}
