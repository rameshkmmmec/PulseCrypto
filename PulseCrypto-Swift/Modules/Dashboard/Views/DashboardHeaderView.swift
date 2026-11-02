//
//  DashboardHeaderView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 02/11/26.
//

import Foundation
import UIKit


final class DashboardHeaderView: UIView {
    
    var onProfileTapped: (() -> Void)?
    var onSearchTapped: (() -> Void)?
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "ic_profile")
        button.setImage(image, for: .normal)        
        button.tintColor = UIColor(hex: "#1C2E4C")?.withAlphaComponent(0.9)
        button.backgroundColor = UIColor(hex: "#101C33")?.withAlphaComponent(0.8)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#1C2E4C")?.cgColor
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "PulseCypto"
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    private let titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let font = UIFont.systemFont(ofSize: 20, weight: .bold)
            
            let attributedString = NSMutableAttributedString(
                string: "Pulse",
                attributes: [
                    .font: font,
                    .foregroundColor: UIColor.white
                ]
            )
            
            let cryptoString = NSAttributedString(
                string: "Crypto",
                attributes: [
                    .font: font,
                    .foregroundColor: UIColor(red: 152/255, green: 169/255, blue: 187/255, alpha: 1.0) // Soft Ice-Cyan
                ]
            )
            
            attributedString.append(cryptoString)
            label.attributedText = attributedString
            
            return label
        }()
    
    private let searchButton: UIButton = {
        
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        let imag = UIImage(systemName: "magnifyingglass", withConfiguration: config)
        button.setImage(imag, for: .normal)
        button.tintColor = UIColor(white: 0.85, alpha: 1)
        button.backgroundColor = UIColor(hex: "#101C33")?.withAlphaComponent(0.8)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#1C2E4C")?.withAlphaComponent(1).cgColor
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupActions()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profileButton)
        addSubview(titleLabel)
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
                
            // 1. Profile button
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
                  
            // 2. Title Text
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            // 3. Search button
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
    
    private func setupActions() {
        profileButton.addTarget(self, action: #selector(handleProfileTap), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(handleSearchTap), for: .touchUpInside)
    }
    
    @objc private func handleProfileTap(){
        onProfileTapped?()
    }
    
    @objc private func handleSearchTap(){
        onSearchTapped?()
    }
}

