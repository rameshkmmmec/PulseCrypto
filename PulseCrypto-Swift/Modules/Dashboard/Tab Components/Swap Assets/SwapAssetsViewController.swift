//
//  SwapAssetsViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import UIKit

class SwapAssetsViewController: UIViewController {

    private let headerLbl: UILabel = {
        let header = UILabel()
        header.text = "Swap Assets"
        header.font = .systemFont(ofSize: 22, weight: .regular)
        header.textColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(headerLbl)
        
        NSLayoutConstraint.activate([
        
            headerLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            headerLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

}
