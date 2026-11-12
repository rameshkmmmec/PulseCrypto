//
//  SettingsLogoutView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 12/11/26.
//

import Foundation
import UIKit

final class SettingsLogoutView: UIView {
        
    private let logoutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 34/255, blue: 45/255, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoutIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let logoutText: UILabel = {
        let logout = UILabel()
        logout.textColor = UIColor(red: 192/255, green: 108/255, blue: 109/255, alpha: 1)
        logout.font = .systemFont(ofSize: 20, weight: .semibold)
        logout.translatesAutoresizingMaskIntoConstraints = false
        return logout
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder")
    }
    
    private func setupDetails(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        logoutView.addSubview(logoutIcon)
        logoutView.addSubview(logoutText)
        self.addSubview(logoutView)
        
        NSLayoutConstraint.activate([
        
            logoutIcon.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            logoutIcon.leadingAnchor.constraint(equalTo: logoutView.leadingAnchor, constant: 10),
            logoutIcon.widthAnchor.constraint(equalToConstant: 34),
            logoutIcon.heightAnchor.constraint(equalToConstant: 34),
            
            logoutText.centerYAnchor.constraint(equalTo: logoutIcon.centerYAnchor),
            logoutText.leadingAnchor.constraint(equalTo: logoutIcon.trailingAnchor, constant: 10),
            logoutText.trailingAnchor.constraint(equalTo: logoutView.trailingAnchor, constant: -10),
            
            logoutView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoutView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoutView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            logoutView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configLogoutData(data: LogoutAction){
        
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        logoutIcon.image = UIImage(systemName: data.icon, withConfiguration: config)
        logoutIcon.tintColor = UIColor(red: 192/255, green: 108/255, blue: 109/255, alpha: 1)
        
        logoutText.text = data.title
    }
}
