//
//  AssetsCell.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 18/11/26.
//

import Foundation
import UIKit


final class AssetsCell: UITableViewCell {
    
    static let reuseIdentifier = "AssetsCell"
    private let baseGlassView = NeonGlowCardView(style: .slateGlass, cornerRadius: 14)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupDetails()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let expandleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let headerContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let expandleView: UIView = {
        let view = UIView()
        //view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 21
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoIcon: UIImageView = {
       let imageVw = UIImageView()
        imageVw.contentMode = .scaleAspectFit
        imageVw.translatesAutoresizingMaskIntoConstraints = false
        return imageVw
    }()
    
    private let titleLbl: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .appFont(size: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLbl: UILabel = {
        let label = UILabel()
        label.textColor = .whitishGrey
        label.font = .appFont(size: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rateLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .appFont(size: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLbl: UILabel = {
        let label = UILabel()
        label.textColor = .seafoamGreen
        label.font = .appFont(size: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLeftLbl: UILabel = {
        let label = UILabel()
        label.textColor = .whitishGrey
        label.font = .appFont(size: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomRightLbl: UILabel = {
        let label = UILabel()
        label.textColor = .seafoamGreen
        label.font = .appFont(size: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sparklineView: MiniSparklineView = {
        let view = MiniSparklineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupDetails(){
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
        self.contentView.addSubview(baseGlassView)
        baseGlassView.addSubview(mainStackView)
        baseGlassView.addSubview(expandleStackView)
        
        // Top always fixed view
        iconContainerView.addSubview(logoIcon)
        headerContainerView.addSubview(iconContainerView)
        headerContainerView.addSubview(titleLbl)
        headerContainerView.addSubview(detailLbl)
        headerContainerView.addSubview(amountLbl)
        headerContainerView.addSubview(rateLbl)
        
        expandleStackView.addArrangedSubview(sparklineView)
        expandleView.addSubview(bottomLeftLbl)
        expandleView.addSubview(bottomRightLbl)
        expandleStackView.addArrangedSubview(expandleView)
        
        mainStackView.addArrangedSubview(headerContainerView)
        mainStackView.addArrangedSubview(expandleStackView)
        
        let sparklineHeight = sparklineView.heightAnchor.constraint(equalToConstant: 56)
        sparklineHeight.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            
            baseGlassView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            baseGlassView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baseGlassView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            baseGlassView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            mainStackView.topAnchor.constraint(equalTo: baseGlassView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: baseGlassView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: baseGlassView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: baseGlassView.bottomAnchor, constant: -8),
            
            iconContainerView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 5),
            iconContainerView.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor),
            iconContainerView.heightAnchor.constraint(equalToConstant: 42),
            iconContainerView.widthAnchor.constraint(equalToConstant: 42),
            
            logoIcon.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            logoIcon.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            logoIcon.widthAnchor.constraint(equalToConstant: 30),
            logoIcon.heightAnchor.constraint(equalToConstant: 30),
            
            titleLbl.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 2),
            titleLbl.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 10),
            //titleLbl.trailingAnchor.constraint(equalTo: rateLbl.leadingAnchor, constant: 8),
            
            detailLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            detailLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            detailLbl.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -2),
            
            amountLbl.topAnchor.constraint(equalTo: titleLbl.topAnchor),
            amountLbl.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            amountLbl.leadingAnchor.constraint(greaterThanOrEqualTo: titleLbl.trailingAnchor, constant: 8),
            
            rateLbl.topAnchor.constraint(equalTo: detailLbl.topAnchor),
            rateLbl.trailingAnchor.constraint(equalTo: amountLbl.trailingAnchor),
            rateLbl.leadingAnchor.constraint(greaterThanOrEqualTo: detailLbl.trailingAnchor, constant: 8),

            sparklineHeight,
            
            bottomLeftLbl.topAnchor.constraint(equalTo: sparklineView.bottomAnchor, constant: 10),
            bottomLeftLbl.leadingAnchor.constraint(equalTo: expandleStackView.leadingAnchor, constant: 10),
            bottomLeftLbl.bottomAnchor.constraint(equalTo: expandleStackView.bottomAnchor),
            
            bottomRightLbl.centerYAnchor.constraint(equalTo: bottomLeftLbl.centerYAnchor),
            bottomRightLbl.trailingAnchor.constraint(equalTo: expandleStackView.trailingAnchor)
        ])
    }
    
    func configuew(with item: MarketItem, index: Int) {
        
        let defaultColor = UIColor(red: 251/255, green: 146/255, blue: 60/255, alpha: 1.0)
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        logoIcon.image = UIImage(systemName: item.system_icon, withConfiguration: config)
        logoIcon.tintColor = UIColor(hex: item.icon_tint_color)
        
        let rate = "\(item.change_percentage) \(item.symbol)"

        titleLbl.text = "\(item.symbol) (\(item.name)"
        detailLbl.text = rate
        
        let pricing = String(format: "%@ %.2f", item.currency_symbol, item.price)
        amountLbl.text = pricing
        rateLbl.text = rate
                
        sparklineView.configure(
            points: item.sparkline_points,
            strokeColor: UIColor(hex: item.chart_color) ?? defaultColor,
            fillColors: item.gradientFillColors
        )
        
        bottomLeftLbl.text = "Mini trend Sparkline"
        bottomRightLbl.text = pricing
        
        if index == 1{
            self.expandleStackView.isHidden = true
        } else if index == 2{
            self.expandleView.isHidden = true
        }
    }
    
    func setExpanded(_ expanded: Bool, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut]) {
                self.expandleView.isHidden = !expanded
                self.expandleView.alpha = expanded ? 1.0 : 0.0
                self.layoutIfNeeded()
            }
        } else {
            expandleView.isHidden = !expanded
            expandleView.alpha = expanded ? 1.0 : 0.0
        }
    }
}
