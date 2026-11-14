//
//  UIViewController+Extensions.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 14/11/26.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String, bottom: CGFloat = 40, duration: TimeInterval = 2.0) {
        let toastContainer = UIView()
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        toastContainer.layer.cornerRadius = 10
        toastContainer.clipsToBounds = true
        toastContainer.alpha = 0
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = .appFont(size: 16, weight: .medium)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        toastContainer.addSubview(messageLabel)
        view.addSubview(toastContainer)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -16),
            
            toastContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottom),
            toastContainer.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            toastContainer.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
        
        UIView.animate(withDuration: 0.25) {
            toastContainer.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: 0.25, animations: {
                toastContainer.alpha = 0
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        }
    }
}
