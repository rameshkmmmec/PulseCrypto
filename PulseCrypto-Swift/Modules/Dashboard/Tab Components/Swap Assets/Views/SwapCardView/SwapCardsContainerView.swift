//
//  SwapCardsContainerView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 14/11/26.
//

import Foundation
import UIKit

final class SwapCardItemView: NeonGlowCardView {
    
    let titleLabel = UILabel()
    let coinView = UIView()
    let coinImg = UIImageView()
    let coinLabel = UILabel()
    let coinArrow = UIImageView()
    let amountLabel = UILabel()
    let rateLabel = UILabel()
    let dividerView = UIView()
    let bottomLeftLabel = UILabel()
    let bottomRightLabel = UILabel()
    
    let extraLeftLabel = UILabel()
    let extraRightLabel = UILabel()
    
    init(style: CardStyleConfig, showSlipperRow: Bool = false) {
        super.init(style: style, cornerRadius: 20)
        self.configureSubViews()
        setupConstraints(showSlipperRow: showSlipperRow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    private func configureSubViews() {
        
        titleLabel.textColor = .white.withAlphaComponent(0.90)
        titleLabel.font = .appFont(size: 20, weight: .semiBold)
        
        coinView.backgroundColor = .clear
        coinView.layer.cornerRadius = 8
        coinView.layer.borderWidth = 1
        coinView.layer.borderColor = UIColor.init(red: 76/255, green: 97/255, blue: 111/255, alpha: 1).cgColor
        
        coinImg.contentMode = .scaleAspectFit
        coinImg.layer.cornerRadius = 17
        coinImg.clipsToBounds = true
        
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        coinArrow.image = UIImage(systemName: "chevron.down", withConfiguration: config)
        coinArrow.tintColor = .white.withAlphaComponent(0.85)
        coinView.contentMode = .scaleAspectFit
        
        amountLabel.font = .appFont(size: 32, weight: .black)
        amountLabel.textColor = .white
        
        rateLabel.font = .appFont(size: 17, weight: .regular)
        rateLabel.textColor = UIColor(red: 142/255, green: 146/255, blue: 159/255, alpha: 1)
        rateLabel.textAlignment = .right
        
        dividerView.backgroundColor = UIColor.init(red: 48/255, green: 54/255, blue: 67/255, alpha: 1)

        bottomLeftLabel.font = .appFont(size: 17, weight: .regular)
        bottomLeftLabel.text = "Available Balance"
        bottomLeftLabel.textColor = UIColor(red: 142/255, green: 146/255, blue: 159/255, alpha: 1)
        
        bottomRightLabel.font = .appFont(size: 18, weight: .medium)
        bottomRightLabel.textColor = UIColor(red: 242/255, green: 247/255, blue: 252/255, alpha: 1)
        bottomRightLabel.textAlignment = .right
        
        extraLeftLabel.font = .appFont(size: 18, weight: .medium)
        extraLeftLabel.textColor = UIColor(red: 242/255, green: 247/255, blue: 252/255, alpha: 1)
        
        extraRightLabel.font = .appFont(size: 18, weight: .medium)
        extraRightLabel.textColor = UIColor(red: 242/255, green: 247/255, blue: 252/255, alpha: 1)
        extraRightLabel.textAlignment = .right
    }
    
    private func setupConstraints(showSlipperRow: Bool) {
        
        [titleLabel, coinView, coinImg, coinLabel, coinArrow, amountLabel, rateLabel, dividerView, bottomLeftLabel, bottomRightLabel, extraLeftLabel, extraRightLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(titleLabel)
        addSubview(coinView)
        coinView.addSubview(coinImg)
        coinView.addSubview(coinLabel)
        coinView.addSubview(coinArrow)
        
        addSubview(amountLabel)
        addSubview(rateLabel)
        addSubview(dividerView)
        addSubview(bottomLeftLabel)
        addSubview(bottomRightLabel)

        [titleLabel, amountLabel, bottomLeftLabel, bottomRightLabel, extraLeftLabel, extraRightLabel].forEach {
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
            $0.setContentHuggingPriority(.required, for: .vertical)
        }
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            coinView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            coinView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            coinView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            coinView.heightAnchor.constraint(equalToConstant: 60),
            
            coinImg.leadingAnchor.constraint(equalTo: coinView.leadingAnchor, constant: 10),
            coinImg.centerYAnchor.constraint(equalTo: coinView.centerYAnchor),
            coinImg.widthAnchor.constraint(equalToConstant: 34),
            coinImg.heightAnchor.constraint(equalToConstant: 34),
            
            coinLabel.centerYAnchor.constraint(equalTo: coinImg.centerYAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: coinImg.trailingAnchor, constant: 8),
            coinLabel.trailingAnchor.constraint(equalTo: coinArrow.leadingAnchor, constant: -8),

            coinArrow.centerYAnchor.constraint(equalTo: coinImg.centerYAnchor),
            coinArrow.trailingAnchor.constraint(equalTo: coinView.trailingAnchor, constant: -10),
            coinArrow.widthAnchor.constraint(equalToConstant: 20),
            coinArrow.heightAnchor.constraint(equalToConstant: 20),
                        
            amountLabel.topAnchor.constraint(equalTo: coinView.bottomAnchor, constant: 20),
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            rateLabel.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            dividerView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 16),
            dividerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            bottomLeftLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            bottomLeftLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            bottomRightLabel.centerYAnchor.constraint(equalTo: bottomLeftLabel.centerYAnchor),
            bottomRightLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        if showSlipperRow {
            addSubview(extraLeftLabel)
            addSubview(extraRightLabel)
            
            NSLayoutConstraint.activate([
                extraLeftLabel.topAnchor.constraint(equalTo: bottomLeftLabel.bottomAnchor, constant: 10),
                extraLeftLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                extraLeftLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                
                extraRightLabel.centerYAnchor.constraint(equalTo: extraLeftLabel.centerYAnchor),
                extraRightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
        } else {
            NSLayoutConstraint.activate([
                //bottomLeftLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
                bottomLeftLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                bottomRightLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
            ])
        }
    }
    
    func setCoinTitle(name: String, symbol: String) {
        
        let attributed = NSMutableAttributedString(string: "\(symbol) ", attributes: [.font: UIFont.appFont(size: 18, weight: .bold), .foregroundColor: UIColor.white])
        
        attributed.append(NSAttributedString(string: "(\(name))", attributes: [.font: UIFont.appFont(size: 18, weight: .regular), .foregroundColor: UIColor.init(red: 175/255, green: 186/255, blue: 196/255, alpha: 1)]))
        
        coinLabel.attributedText = attributed
    }
}

final class FloatingSwapButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // Mint Green (#56F3C5) to Electric Cyan (#24C6FF)
        gradientLayer.colors = [
            UIColor(red: 86/255, green: 243/255, blue: 197/255, alpha: 1.0).cgColor,
            UIColor(red: 36/255, green: 198/255, blue: 255/255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Swap Icon
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        let swapImage = UIImage(systemName: "arrow.left.arrow.right", withConfiguration: config)
        setImage(swapImage, for: .normal)
        tintColor = UIColor(red: 10/255, green: 25/255, blue: 38/255, alpha: 1.0)
        
        // Ambient Mint-Cyan Shadow
        layer.shadowColor = UIColor(red: 60/255, green: 225/255, blue: 225/255, alpha: 1.0).cgColor
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 16
        layer.shadowOffset = .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = bounds.height / 2
        layer.cornerRadius = radius
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = radius
        layer.shadowPath = UIBezierPath(ovalIn: bounds).cgPath
        
        if let imageView = imageView {
            bringSubviewToFront(imageView)
        }
    }
}

final class ReviewSwapButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // Mint Green (#56F3C5) to Electric Cyan (#24C6FF)
        gradientLayer.colors = [
            UIColor(red: 86/255, green: 243/255, blue: 197/255, alpha: 1.0).cgColor,
            UIColor(red: 36/255, green: 198/255, blue: 255/255, alpha: 1.0).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        setTitle("Review Swap", for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.appFont(size: 18, weight: .bold)
        
        
        // Ambient Mint-Cyan Shadow
        layer.shadowColor = UIColor(red: 60/255, green: 225/255, blue: 225/255, alpha: 1.0).cgColor
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 16
        layer.shadowOffset = .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = bounds.height / 2
        layer.cornerRadius = radius
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = radius
        layer.shadowPath = UIBezierPath(ovalIn: bounds).cgPath
        
        if let imageView = imageView {
            bringSubviewToFront(imageView)
        }
    }
}

final class SwapCardsContainerView: UIView {
    
    let fromCardView = SwapCardItemView(style: .cyanNeon, showSlipperRow: false)
    let toCardView = SwapCardItemView(style: .slateGlass, showSlipperRow: true)
    let swapButton = FloatingSwapButton()
    let reviewButton = ReviewSwapButton()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDetails()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDetails()
    }
    
    func setupDetails() {
        
        translatesAutoresizingMaskIntoConstraints = false
        fromCardView.translatesAutoresizingMaskIntoConstraints = false
        toCardView.translatesAutoresizingMaskIntoConstraints = false
        swapButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(fromCardView)
        addSubview(toCardView)
        addSubview(swapButton)
        addSubview(reviewButton)
        
        NSLayoutConstraint.activate([
            
            fromCardView.topAnchor.constraint(equalTo: topAnchor),
            fromCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fromCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            toCardView.topAnchor.constraint(equalTo: fromCardView.bottomAnchor, constant: 40),
            toCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            toCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            swapButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            swapButton.centerYAnchor.constraint(equalTo: fromCardView.bottomAnchor, constant: 20),
            swapButton.widthAnchor.constraint(equalToConstant: 70),
            swapButton.heightAnchor.constraint(equalToConstant: 70),
            
            reviewButton.topAnchor.constraint(equalTo: toCardView.bottomAnchor, constant: 16),
            reviewButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            reviewButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            reviewButton.heightAnchor.constraint(equalToConstant: 60),
            reviewButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}


