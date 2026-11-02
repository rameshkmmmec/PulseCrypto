//
//  PortfolioCardView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 02/11/26.
//

import Foundation
import UIKit


final class PortfolioCardView: UIView {
    
    // MARK: - Actions
    var onSendTapped: (() -> Void)?
    var onReceiveTapped: (() -> Void)?
    var onSwapTapped: (() -> Void)?
    
    // Layers for atmospheric lighting and border bloom
    private let diagonalGlowLayer = CAGradientLayer()
    private let borderBloomLayer = CAShapeLayer()
    private let borderCoreLayer = CAShapeLayer()
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Portfolio Balance"
        label.textColor = UIColor(red: 116/255, green: 131/255, blue: 146/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "$38,420.50"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trendBadge: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 109/255, green: 220/255, blue: 145/255, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 52/255, green: 211/255, blue: 153/255, alpha: 0.45).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let trendLabel: UILabel = {
        let label = UILabel()
        label.text = "+5.8% (24h)"
        label.textColor = UIColor.black.withAlphaComponent(0.60)//UIColor(red: 52/255, green: 211/255, blue: 153/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainer()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Container & Lighting
    
    private func setupContainer() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 8/255, green: 17/255, blue: 30/255, alpha: 1.0)
        layer.cornerRadius = 24
        
        // Outer atmospheric cyan glow
        let ambientCyan = UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1.0)
        layer.shadowColor = ambientCyan.cgColor
        layer.shadowOpacity = 0.50
        layer.shadowRadius = 24
        layer.shadowOffset = .zero
        
        // 1. Diagonal gradient: Top-left kone ka dull whitish color pure card par halka hote huye failega
        diagonalGlowLayer.cornerRadius = 24
        diagonalGlowLayer.masksToBounds = true
        diagonalGlowLayer.colors = [
            UIColor(red: 195/255, green: 235/255, blue: 245/255, alpha: 0.42).cgColor, // Top corner dull whitish core
            UIColor(red: 90/255,  green: 185/255, blue: 215/255, alpha: 0.26).cgColor, // Upper middle spread
            UIColor(red: 35/255,  green: 110/255, blue: 155/255, alpha: 0.15).cgColor, // Mid card transition
            UIColor(red: 15/255,  green: 55/255,  blue: 90/255,  alpha: 0.08).cgColor, // Action buttons zone tak subtle haze
            UIColor(red: 8/255,   green: 17/255,  blue: 30/255,  alpha: 0.02).cgColor  // Bottom right me natural fade
        ]
        diagonalGlowLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        diagonalGlowLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        diagonalGlowLayer.locations = [0.0, 0.22, 0.48, 0.78, 1.0]
        
        // 2. Border bloom: Border line ke andar aur bahar dull whitish spread
        borderBloomLayer.lineWidth = 3.0
        borderBloomLayer.fillColor = UIColor.clear.cgColor
        borderBloomLayer.strokeColor = UIColor(red: 210/255, green: 245/255, blue: 255/255, alpha: 0.28).cgColor
        
        // 3. Core border hairline (clean neon cyan)
        borderCoreLayer.lineWidth = 1.0
        borderCoreLayer.fillColor = UIColor.clear.cgColor
        borderCoreLayer.strokeColor = UIColor(red: 0/255, green: 220/255, blue: 255/255, alpha: 0.85).cgColor
        
        layer.insertSublayer(diagonalGlowLayer, at: 0)
        layer.addSublayer(borderBloomLayer)
        layer.addSublayer(borderCoreLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        diagonalGlowLayer.frame = bounds
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: layer.cornerRadius).cgPath
        borderBloomLayer.path = path
        borderBloomLayer.frame = bounds
        borderCoreLayer.path = path
        borderCoreLayer.frame = bounds
        
        CATransaction.commit()
    }
    
    // MARK: - Hierarchy & Layout
    
    private func setupLayout() {
        trendBadge.addSubview(trendLabel)
        NSLayoutConstraint.activate([
            trendLabel.topAnchor.constraint(equalTo: trendBadge.topAnchor, constant: 4),
            trendLabel.bottomAnchor.constraint(equalTo: trendBadge.bottomAnchor, constant: -4),
            trendLabel.leadingAnchor.constraint(equalTo: trendBadge.leadingAnchor, constant: 10),
            trendLabel.trailingAnchor.constraint(equalTo: trendBadge.trailingAnchor, constant: -10)
        ])
        
        let sendButton = createActionButton(title: "Send", systemIcon: "arrow.up.right", action: #selector(handleSend))
        let receiveButton = createActionButton(title: "Receive", systemIcon: "arrow.down.left", action: #selector(handleReceive))
        let swapButton = createActionButton(title: "Swap", systemIcon: "arrow.triangle.2.circlepath", action: #selector(handleSwap))
        
        actionsStackView.addArrangedSubview(sendButton)
        actionsStackView.addArrangedSubview(receiveButton)
        actionsStackView.addArrangedSubview(swapButton)
        
        addSubview(titleLabel)
        addSubview(balanceLabel)
        addSubview(trendBadge)
        addSubview(actionsStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            balanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            balanceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            trendBadge.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            trendBadge.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            actionsStackView.topAnchor.constraint(equalTo: trendBadge.bottomAnchor, constant: 20),
            actionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            actionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            actionsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
        
    private func createActionButton(title: String, systemIcon: String, action: Selector) -> UIView {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            
            // 1. Background disc container (Gradient & Border yahan rahega)
            let backgroundCircle = UIView()
            backgroundCircle.translatesAutoresizingMaskIntoConstraints = false
            backgroundCircle.layer.cornerRadius = 24
            backgroundCircle.layer.borderWidth = 1.0
            backgroundCircle.layer.borderColor = UIColor(red: 120/255, green: 230/255, blue: 255/255, alpha: 0.35).cgColor
            backgroundCircle.clipsToBounds = true
            backgroundCircle.isUserInteractionEnabled = false
            
            let btnGradient = CAGradientLayer()
            btnGradient.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
            btnGradient.cornerRadius = 24
            btnGradient.colors = [
                UIColor(red: 195/255, green: 240/255, blue: 255/255, alpha: 0.30).cgColor, // Top-left soft whitish sheen
                UIColor(red: 25/255,  green: 55/255,  blue: 85/255,  alpha: 0.65).cgColor, // Mid tone
                UIColor(red: 10/255,  green: 20/255,  blue: 35/255,  alpha: 0.95).cgColor  // Deep dark base
            ]
            btnGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            btnGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            backgroundCircle.layer.addSublayer(btnGradient)
            
            // 2. Pure Foreground Button (Icon par koi layer ya tint fade nahi aayega)
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .clear
            
            let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
            let iconImage = UIImage(systemName: systemIcon, withConfiguration: config)?.withRenderingMode(.alwaysTemplate)
            button.setImage(iconImage, for: .normal)
            button.tintColor = UIColor(red: 0/255, green: 230/255, blue: 255/255, alpha: 1.0) // Solid punchy neon cyan
            button.addTarget(self, action: action, for: .touchUpInside)
            
            let label = UILabel()
            label.text = title
            label.textColor = UIColor(white: 0.8, alpha: 1.0)
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            container.addSubview(backgroundCircle)
            container.addSubview(button)
            container.addSubview(label)
            
            NSLayoutConstraint.activate([
                backgroundCircle.topAnchor.constraint(equalTo: container.topAnchor),
                backgroundCircle.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                backgroundCircle.widthAnchor.constraint(equalToConstant: 48),
                backgroundCircle.heightAnchor.constraint(equalToConstant: 48),
                
                button.topAnchor.constraint(equalTo: backgroundCircle.topAnchor),
                button.leadingAnchor.constraint(equalTo: backgroundCircle.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: backgroundCircle.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: backgroundCircle.bottomAnchor),
                
                label.topAnchor.constraint(equalTo: backgroundCircle.bottomAnchor, constant: 6),
                label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
            
            return container
        }
    
    // MARK: - Handlers
    @objc private func handleSend() { onSendTapped?() }
    @objc private func handleReceive() { onReceiveTapped?() }
    @objc private func handleSwap() { onSwapTapped?() }
}
