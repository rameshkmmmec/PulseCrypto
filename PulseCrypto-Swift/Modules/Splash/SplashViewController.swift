//
//  SplashViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 02/11/26.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 7/255, green: 13/255, blue: 24/255, alpha: 1.0) // #070D18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppLogo") // assets se logo link karein
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Niche wala dynamic indicator/dot
    private let pulseDot: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1.0) // #00D2FF Glowing Cyan
        view.layer.cornerRadius = 4 // 8x8 width ka circle banane ke liye half radius
        
        // Subtle Glowing effect (Shadow)
        view.layer.shadowColor = UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1.0).cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.8
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startPulsingAnimation()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        // Add Subviews
        view.addSubview(backgroundView)
        view.addSubview(logoImageView)
        view.addSubview(pulseDot)
        
        NSLayoutConstraint.activate([
            // Background View fill completely
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Logo exactly center me rahega
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 240),
            logoImageView.heightAnchor.constraint(equalToConstant: 240),
            
            // Pulse Dot screen ke bottom (safe area) se 60 points upar
            pulseDot.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pulseDot.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            pulseDot.widthAnchor.constraint(equalToConstant: 8),
            pulseDot.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    // MARK: - Animation
    
    private func startPulsingAnimation() {
        // Simple scale aur fade breath effect
        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       options: [.repeat, .autoreverse, .curveEaseInOut],
                       animations: {
            self.pulseDot.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.pulseDot.alpha = 0.35
        }, completion: nil)
    }
}
