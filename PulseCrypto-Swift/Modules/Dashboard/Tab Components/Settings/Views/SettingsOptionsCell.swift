//
//  SettingsOptionsCell.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 12/11/26.
//

import Foundation
import UIKit

final class SettingsOptionsCell: UITableViewCell {
    
    static let reuseIndentier = "SettingsOptionsCell"
    
    private let icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let switchView: UISwitch = {
        let switchVw = UISwitch()
        switchVw.isOn = false
        
        switchVw.onTintColor = UIColor(red: 45/255, green: 212/255, blue: 191/255, alpha: 1.0)
        switchVw.backgroundColor = UIColor(red: 42/255, green: 48/255, blue: 62/255, alpha: 1.0)
        switchVw.layer.cornerRadius = switchVw.bounds.height / 2
        switchVw.clipsToBounds = true
        switchVw.thumbTintColor = .white
        
        switchVw.translatesAutoresizingMaskIntoConstraints = false
        return switchVw
    }()
    
    private let nextArrow: UIImageView = {
       let imageVw = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        imageVw.image = UIImage(systemName: "chevron.right", withConfiguration: config)
        imageVw.tintColor = .lightGray
        imageVw.contentMode = .scaleAspectFit
        imageVw.translatesAutoresizingMaskIntoConstraints = false
        return imageVw
    }()
    
    
    // Title + Subtitle ko clean handle karne ke liye vertical stack
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLbl: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let detailLbl: UILabel = {
       let detail = UILabel()
        detail.font = .systemFont(ofSize: 16, weight: .medium)
        detail.textColor = UIColor.init(red: 137/255, green: 142/255, blue: 156/255, alpha: 1.0)
        detail.translatesAutoresizingMaskIntoConstraints = false
        return detail
    }()
    
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayoutViews()
    }
    
    func setupLayoutViews(){
        
        self.backgroundColor = .clear
        selectionStyle = .none
        
        textStackView.addArrangedSubview(titleLbl)
        textStackView.addArrangedSubview(detailLbl)
        
        textStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLbl.setContentHuggingPriority(.defaultLow, for: .horizontal)
        detailLbl.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        contentView.addSubview(icon)
        contentView.addSubview(switchView)
        contentView.addSubview(nextArrow)
        contentView.addSubview(textStackView)
        contentView.addSubview(seperatorView)
        
        
        NSLayoutConstraint.activate([
            
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 34),
            icon.heightAnchor.constraint(equalToConstant: 34),
            
            switchView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nextArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nextArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nextArrow.widthAnchor.constraint(equalToConstant: 12),
            nextArrow.heightAnchor.constraint(equalToConstant: 18),
            
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            textStackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 14),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            
            seperatorView.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 20),
            seperatorView.leadingAnchor.constraint(equalTo: textStackView.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
    
    func configCellData(data: SettingItem, isLast:Bool) {
        
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        icon.image = UIImage(systemName: data.icon, withConfiguration: config)
        icon.tintColor = .lightGray
        
        titleLbl.text = data.title
        detailLbl.text = data.subtitle
        
        detailLbl.isHidden = (data.subtitle == nil || data.subtitle?.isEmpty == true)
        
        switchView.isHidden = !(data.type == .toggle)
        switchView.isOn = data.isEnabled
        nextArrow.isHidden = (data.type == .toggle)
        
        seperatorView.isHidden = isLast
    }
}
