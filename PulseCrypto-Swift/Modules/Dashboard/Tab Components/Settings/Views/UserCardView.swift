//
//  UserCardView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

final class UserCardView: UIView {
    
    let profileCardView = NeonGlowCardView()
    
    private let profileImg: UIImageView = {
        let imageView = UIImageView()
        let arrowConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
        imageView.image = UIImage(systemName: "person.crop.circle.fill", withConfiguration: arrowConfig)
        imageView.tintColor = UIColor(red: 120/255, green: 220/255, blue: 255/255, alpha: 1.0)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Ramesh Kumar"
        name.textColor = .white
        name.font = .systemFont(ofSize: 17, weight: .medium)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let detailLabel: UILabel = {
        let detail = UILabel()
        detail.text = "Senior IOS Developer"
        detail.textColor = UIColor.init(red: 137/255, green: 142/255, blue: 155/255, alpha: 1)
        detail.font = .systemFont(ofSize: 14, weight: .regular)
        detail.translatesAutoresizingMaskIntoConstraints = false
        return detail
    }()
    
    private let arrow: UIImageView = {
       let arrow = UIImageView()
        let arrowConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
        arrow.image = UIImage(systemName: "chevron.right", withConfiguration: arrowConfig)
        arrow.tintColor = UIColor(white: 0.6, alpha: 1.0)
        arrow.contentMode = .scaleAspectFit
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder)")
    }
    
    private func setupLayout() {
        
        profileCardView.translatesAutoresizingMaskIntoConstraints = false
        profileCardView.cornerRadiusValue = 16
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(profileCardView)
        profileCardView.addSubview(profileImg)
        profileCardView.addSubview(nameLabel)
        profileCardView.addSubview(detailLabel)
        profileCardView.addSubview(arrow)
        
        NSLayoutConstraint.activate([
        
            profileCardView.topAnchor.constraint(equalTo: topAnchor),
            profileCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileCardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImg.centerYAnchor.constraint(equalTo: profileCardView.centerYAnchor),
            profileImg.leadingAnchor.constraint(equalTo: profileCardView.leadingAnchor, constant: 16),
            profileImg.heightAnchor.constraint(equalToConstant: 40),
            profileImg.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: profileImg.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrow.leadingAnchor, constant: -8),
            
            detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrow.leadingAnchor, constant: -8),
            detailLabel.bottomAnchor.constraint(equalTo: profileCardView.bottomAnchor, constant: -18),
            
            arrow.centerYAnchor.constraint(equalTo: profileImg.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: profileCardView.trailingAnchor, constant: -16),
            arrow.widthAnchor.constraint(equalToConstant: 18),
            arrow.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func configure(name: String, detail: String, imageName: String? = nil) {
        
        nameLabel.text = name
        detailLabel.text = detail
        
        if let imageName = imageName, let customImg = UIImage(named: imageName) {
            profileImg.image = customImg
        }
    }
}
