//
//  NeonGlowCardView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

class NeonGlowCardView: UIView {
    
    // MARK: - Sublayers
    private let diagonalGlowLayer = CAGradientLayer()
    private let borderBloomLayer = CAShapeLayer()
    private let borderCoreLayer = CAShapeLayer()
    
    // Customizable corner radius
    var cornerRadiusValue: CGFloat = 24.0 {
        didSet {
            layer.cornerRadius = cornerRadiusValue
            diagonalGlowLayer.cornerRadius = cornerRadiusValue
            setNeedsLayout()
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    // MARK: - Setup Layers
    private func setupStyle() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 8/255, green: 17/255, blue: 30/255, alpha: 1.0)
        layer.cornerRadius = cornerRadiusValue
        
        // Outer atmospheric cyan shadow glow
        let ambientCyan = UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1.0)
        layer.shadowColor = ambientCyan.cgColor
        layer.shadowOpacity = 0.50
        layer.shadowRadius = 24
        layer.shadowOffset = .zero
        
        // 1. Diagonal Gradient
        diagonalGlowLayer.cornerRadius = cornerRadiusValue
        diagonalGlowLayer.masksToBounds = true
        diagonalGlowLayer.colors = [
            UIColor(red: 195/255, green: 235/255, blue: 245/255, alpha: 0.42).cgColor,
            UIColor(red: 90/255,  green: 185/255, blue: 215/255, alpha: 0.26).cgColor,
            UIColor(red: 35/255,  green: 110/255, blue: 155/255, alpha: 0.15).cgColor,
            UIColor(red: 15/255,  green: 55/255,  blue: 90/255,  alpha: 0.08).cgColor,
            UIColor(red: 8/255,   green: 17/255,  blue: 30/255,  alpha: 0.02).cgColor
        ]
        diagonalGlowLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        diagonalGlowLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        diagonalGlowLayer.locations = [0.0, 0.22, 0.48, 0.78, 1.0]
        
        // 2. Border Bloom (Subtle inner/outer soft line)
        borderBloomLayer.lineWidth = 3.0
        borderBloomLayer.fillColor = UIColor.clear.cgColor
        borderBloomLayer.strokeColor = UIColor(red: 210/255, green: 245/255, blue: 255/255, alpha: 0.28).cgColor
        
        // 3. Core Hairline (Sharp neon border)
        borderCoreLayer.lineWidth = 1.0
        borderCoreLayer.fillColor = UIColor.clear.cgColor
        borderCoreLayer.strokeColor = UIColor(red: 0/255, green: 220/255, blue: 255/255, alpha: 0.85).cgColor
        
        // Add layers in precise sequence
        layer.insertSublayer(diagonalGlowLayer, at: 0)
        layer.addSublayer(borderBloomLayer)
        layer.addSublayer(borderCoreLayer)
    }

    // MARK: - Auto-sync Layers with View Bounds
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true) // Frame change animation artifacts rokne ke liye
        
        diagonalGlowLayer.frame = bounds
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusValue).cgPath
        borderBloomLayer.path = path
        borderCoreLayer.path = path
        
        // Shadow path set karne se performance fast rehti hai (Rasterize cost bachti hai)
        layer.shadowPath = path
        
        CATransaction.commit()
    }
}
