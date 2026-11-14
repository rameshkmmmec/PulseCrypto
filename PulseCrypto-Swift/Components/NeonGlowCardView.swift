//
//  NeonGlowCardView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

//class NeonGlowCardView: UIView {
//    
//    // MARK: - Sublayers
//    private let diagonalGlowLayer = CAGradientLayer()
//    private let borderBloomLayer = CAShapeLayer()
//    private let borderCoreLayer = CAShapeLayer()
//    
//    // Customizable corner radius
//    var cornerRadiusValue: CGFloat = 24.0 {
//        didSet {
//            layer.cornerRadius = cornerRadiusValue
//            diagonalGlowLayer.cornerRadius = cornerRadiusValue
//            setNeedsLayout()
//        }
//    }
//
//    // MARK: - Initializers
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupStyle()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupStyle()
//    }
//
//    // MARK: - Setup Layers
//    private func setupStyle() {
//        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = UIColor(red: 8/255, green: 17/255, blue: 30/255, alpha: 1.0)
//        layer.cornerRadius = cornerRadiusValue
//        
//        // Outer atmospheric cyan shadow glow
//        let ambientCyan = UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1.0)
//        layer.shadowColor = ambientCyan.cgColor
//        layer.shadowOpacity = 0.50
//        layer.shadowRadius = 24
//        layer.shadowOffset = .zero
//        
//        // 1. Diagonal Gradient
//        diagonalGlowLayer.cornerRadius = cornerRadiusValue
//        diagonalGlowLayer.masksToBounds = true
//        diagonalGlowLayer.colors = [
//            UIColor(red: 195/255, green: 235/255, blue: 245/255, alpha: 0.42).cgColor,
//            UIColor(red: 90/255,  green: 185/255, blue: 215/255, alpha: 0.26).cgColor,
//            UIColor(red: 35/255,  green: 110/255, blue: 155/255, alpha: 0.15).cgColor,
//            UIColor(red: 15/255,  green: 55/255,  blue: 90/255,  alpha: 0.08).cgColor,
//            UIColor(red: 8/255,   green: 17/255,  blue: 30/255,  alpha: 0.02).cgColor
//        ]
//        diagonalGlowLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        diagonalGlowLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        diagonalGlowLayer.locations = [0.0, 0.22, 0.48, 0.78, 1.0]
//        
//        // 2. Border Bloom (Subtle inner/outer soft line)
//        borderBloomLayer.lineWidth = 3.0
//        borderBloomLayer.fillColor = UIColor.clear.cgColor
//        borderBloomLayer.strokeColor = UIColor(red: 210/255, green: 245/255, blue: 255/255, alpha: 0.28).cgColor
//        
//        // 3. Core Hairline (Sharp neon border)
//        borderCoreLayer.lineWidth = 1.0
//        borderCoreLayer.fillColor = UIColor.clear.cgColor
//        borderCoreLayer.strokeColor = UIColor(red: 0/255, green: 220/255, blue: 255/255, alpha: 0.85).cgColor
//        
//        // Add layers in precise sequence
//        layer.insertSublayer(diagonalGlowLayer, at: 0)
//        layer.addSublayer(borderBloomLayer)
//        layer.addSublayer(borderCoreLayer)
//    }
//
//    // MARK: - Auto-sync Layers with View Bounds
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        CATransaction.begin()
//        CATransaction.setDisableActions(true) // Frame change animation artifacts rokne ke liye
//        
//        diagonalGlowLayer.frame = bounds
//        
//        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusValue).cgPath
//        borderBloomLayer.path = path
//        borderCoreLayer.path = path
//        
//        // Shadow path set karne se performance fast rehti hai (Rasterize cost bachti hai)
//        layer.shadowPath = path
//        
//        CATransaction.commit()
//    }
//}


//==================

import UIKit

// MARK: - Reusable Style Configuration Model
struct CardStyleConfig {
    var baseBackgroundColor: UIColor
    var gradientColors: [CGColor]
    var gradientLocations: [NSNumber]?
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    var borderCoreColor: UIColor
    var borderCoreWidth: CGFloat
    var borderBloomColor: UIColor
    var borderBloomWidth: CGFloat
    
    var shadowColor: UIColor
    var shadowOpacity: Float
    var shadowRadius: CGFloat
    
    // Preset 1: Existing Cyan Neon Glow
    static let cyanNeon = CardStyleConfig(
        baseBackgroundColor: UIColor(red: 8/255, green: 17/255, blue: 30/255, alpha: 1.0),
        gradientColors: [
            UIColor(red: 195/255, green: 235/255, blue: 245/255, alpha: 0.42).cgColor,
            UIColor(red: 90/255,  green: 185/255, blue: 215/255, alpha: 0.26).cgColor,
            UIColor(red: 35/255,  green: 110/255, blue: 155/255, alpha: 0.15).cgColor,
            UIColor(red: 15/255,  green: 55/255,  blue: 90/255,  alpha: 0.08).cgColor,
            UIColor(red: 8/255,   green: 17/255,  blue: 30/255,  alpha: 0.02).cgColor
        ],
        gradientLocations: [0.0, 0.22, 0.48, 0.78, 1.0],
        startPoint: CGPoint(x: 0.0, y: 0.0),
        endPoint: CGPoint(x: 1.0, y: 1.0),
        borderCoreColor: UIColor(red: 0/255, green: 220/255, blue: 255/255, alpha: 0.85),
        borderCoreWidth: 1.0,
        borderBloomColor: UIColor(red: 210/255, green: 245/255, blue: 255/255, alpha: 0.28),
        borderBloomWidth: 3.0,
        shadowColor: UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1.0),
        shadowOpacity: 0.50,
        shadowRadius: 24.0
    )
    
    // Preset 2: Screenshot Dark Slate Glass Style ("To" Card)
    static let slateGlass = CardStyleConfig(
        baseBackgroundColor: UIColor(red: 14/255, green: 21/255, blue: 37/255, alpha: 1.0),
        gradientColors: [
            UIColor(red: 43/255, green: 51/255, blue: 69/255, alpha: 0.90).cgColor,
            UIColor(red: 30/255, green: 37/255, blue: 54/255, alpha: 0.95).cgColor,
            UIColor(red: 19/255, green: 26/255, blue: 41/255, alpha: 1.00).cgColor
        ],
        gradientLocations: [0.0, 0.5, 1.0],
        startPoint: CGPoint(x: 0.5, y: 0.0),
        endPoint: CGPoint(x: 0.5, y: 1.0),
        borderCoreColor: UIColor(red: 75/255, green: 85/255, blue: 107/255, alpha: 0.45),
        borderCoreWidth: 1.0,
        borderBloomColor: .clear,
        borderBloomWidth: 0.0,
        shadowColor: .clear,
        shadowOpacity: 0.0,
        shadowRadius: 0.0
    )
}

// MARK: - Configurable Card View
class NeonGlowCardView: UIView {
    
    // Sublayers
    private let gradientLayer = CAGradientLayer()
    private let borderBloomLayer = CAShapeLayer()
    private let borderCoreLayer = CAShapeLayer()
    
    // Customizable Corner Radius
    var cornerRadiusValue: CGFloat = 24.0 {
        didSet {
            layer.cornerRadius = cornerRadiusValue
            gradientLayer.cornerRadius = cornerRadiusValue
            setNeedsLayout()
        }
    }
    
    // Dynamic Style Property
    var style: CardStyleConfig {
        didSet { applyStyle(style) }
    }

    // MARK: - Initializers
    init(style: CardStyleConfig = .cyanNeon, cornerRadius: CGFloat = 24.0) {
        self.style = style
        self.cornerRadiusValue = cornerRadius
        super.init(frame: .zero)
        setupLayers()
        applyStyle(style)
    }
    
    required init?(coder: NSCoder) {
        self.style = .cyanNeon
        super.init(coder: coder)
        setupLayers()
        applyStyle(style)
    }

    // MARK: - Setup Layer Hierarchy
    private func setupLayers() {
        translatesAutoresizingMaskIntoConstraints = false
        gradientLayer.masksToBounds = true
        borderBloomLayer.fillColor = UIColor.clear.cgColor
        borderCoreLayer.fillColor = UIColor.clear.cgColor
        
        layer.insertSublayer(gradientLayer, at: 0)
        layer.addSublayer(borderBloomLayer)
        layer.addSublayer(borderCoreLayer)
    }
    
    // MARK: - Apply Configuration
    func applyStyle(_ config: CardStyleConfig) {
        backgroundColor = config.baseBackgroundColor
        layer.cornerRadius = cornerRadiusValue
        gradientLayer.cornerRadius = cornerRadiusValue
        
        // Gradient setup
        gradientLayer.colors = config.gradientColors
        gradientLayer.locations = config.gradientLocations
        gradientLayer.startPoint = config.startPoint
        gradientLayer.endPoint = config.endPoint
        
        // Borders setup
        borderBloomLayer.lineWidth = config.borderBloomWidth
        borderBloomLayer.strokeColor = config.borderBloomColor.cgColor
        
        borderCoreLayer.lineWidth = config.borderCoreWidth
        borderCoreLayer.strokeColor = config.borderCoreColor.cgColor
        
        // Shadow setup
        layer.shadowColor = config.shadowColor.cgColor
        layer.shadowOpacity = config.shadowOpacity
        layer.shadowRadius = config.shadowRadius
        layer.shadowOffset = .zero
        
        setNeedsLayout()
    }

    // MARK: - Auto-sync Layers with View Bounds
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        gradientLayer.frame = bounds
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusValue).cgPath
        borderBloomLayer.path = path
        borderCoreLayer.path = path
        layer.shadowPath = (style.shadowOpacity > 0) ? path : nil
        
        CATransaction.commit()
    }
}
