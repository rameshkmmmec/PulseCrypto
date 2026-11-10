//
//  Untitled.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

final class MarketCell: UITableViewCell {
    
    private let sparklineView = MiniSparklineView()
    static let identifier = "MarketCell"

    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.05)
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor(white: 1.0, alpha: 0.10).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imgVw = UIImageView()
        imgVw.contentMode = .scaleAspectFit
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        return imgVw
    }()
    
    private let title: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let detail: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = UIColor.init(red: 128/255, green: 137/255, blue: 150/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let priceLabel: UILabel = {
        let priceLbl = UILabel()
        priceLbl.font = .systemFont(ofSize: 18, weight: .semibold)
        priceLbl.textColor = .white
        priceLbl.translatesAutoresizingMaskIntoConstraints = false
        return priceLbl
    }()
    
    private let percentageLabel: UILabel = {
        let pLbl = UILabel()
        pLbl.font = .systemFont(ofSize: 13, weight: .regular)
        pLbl.textColor = UIColor.init(red: 116/255, green: 198/255, blue: 153/255, alpha: 1)
        pLbl.translatesAutoresizingMaskIntoConstraints = false
        return pLbl
    }()
    
    private let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        //self.selectionStyle = .none
        self.setupDetails()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDetails(){
        
        sparklineView.translatesAutoresizingMaskIntoConstraints = false
        
        imageContainer.addSubview(iconImageView)
        contentView.addSubview(imageContainer)
        contentView.addSubview(title)
        contentView.addSubview(detail)
        contentView.addSubview(sparklineView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(dividerView)
        
        // Right side ke labels shrink na hon
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        percentageLabel.setContentHuggingPriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        percentageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // Sparkline fixed size maintain kare
        sparklineView.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 50),
            imageContainer.heightAnchor.constraint(equalToConstant: 50),
            
            iconImageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 12),
            
            detail.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            detail.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            
            sparklineView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 35),
            sparklineView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            sparklineView.widthAnchor.constraint(equalToConstant: 64),
            sparklineView.heightAnchor.constraint(equalToConstant: 28),
            
            priceLabel.topAnchor.constraint(equalTo: title.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            percentageLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            percentageLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            
            dividerView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            dividerView.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: 10),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }
    
    func configCell(data: MarketItem){
        
        let defaultColor = UIColor(red: 251/255, green: 146/255, blue: 60/255, alpha: 1.0)
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        iconImageView.image = UIImage(systemName: data.system_icon, withConfiguration: config)
        iconImageView.tintColor = UIColor(hex: data.icon_tint_color)
        
        title.text = data.symbol
        detail.text = data.name
        
        priceLabel.text = "\(data.price)\(data.currency_symbol)"
        
        percentageLabel.text = "\(data.change_percentage)%"
        percentageLabel.textColor = UIColor(hex: data.chart_color)
        
        sparklineView.configure(
            points: data.sparkline_points,
            strokeColor: UIColor(hex: data.chart_color) ?? defaultColor,
            fillColors: data.gradientFillColors
        )
    }
}
