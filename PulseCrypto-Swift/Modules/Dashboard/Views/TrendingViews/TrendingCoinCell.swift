//
//  TrendingCoinCell.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 03/11/26.
//

import Foundation
import UIKit


final class TrendingCoinCell: UICollectionViewCell {
    static let reuseIdentifier = "TrendingCoinCell"
    
    private let cardGradientLayer = CAGradientLayer()
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.05)
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor(white: 1.0, alpha: 0.10).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sparklineView = MiniSparklineView()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = UIColor(red: 9/255, green: 18/255, blue: 32/255, alpha: 0.98)
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.08).cgColor
        contentView.clipsToBounds = true
        
        // Subtle top glass sheen on each card
        cardGradientLayer.cornerRadius = 18
        cardGradientLayer.colors = [
            UIColor(white: 1.0, alpha: 0.06).cgColor,
            UIColor(white: 1.0, alpha: 0.0).cgColor
        ]
        cardGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        cardGradientLayer.endPoint = CGPoint(x: 1, y: 1)
        contentView.layer.insertSublayer(cardGradientLayer, at: 0)
        
        sparklineView.translatesAutoresizingMaskIntoConstraints = false
        
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(iconContainer)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(sparklineView)
        contentView.addSubview(changeLabel)
        
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            iconContainer.widthAnchor.constraint(equalToConstant: 26),
            iconContainer.heightAnchor.constraint(equalToConstant: 26),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 14),
            iconImageView.heightAnchor.constraint(equalToConstant: 14),
            
            symbolLabel.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 8),
            symbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            
            // Sparkline centered vertically between header and return
            sparklineView.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 6),
            sparklineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            sparklineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            sparklineView.heightAnchor.constraint(equalToConstant: 28),
            
            changeLabel.topAnchor.constraint(equalTo: sparklineView.bottomAnchor, constant: 6),
            changeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            changeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        cardGradientLayer.frame = bounds
        CATransaction.commit()
    }
    
    func configure(with token: TrendingItem) {
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        iconImageView.image = UIImage(systemName: token.iconName, withConfiguration: config)
        iconImageView.tintColor = token.iconTintColor
        
        symbolLabel.text = token.symbol
        changeLabel.text = token.changePercentage
        changeLabel.textColor = token.waveColor
        
        sparklineView.configure(
            points: token.wavePoints,
            strokeColor: token.waveColor,
            fillColors: token.gradientFillColors
        )
    }
}
