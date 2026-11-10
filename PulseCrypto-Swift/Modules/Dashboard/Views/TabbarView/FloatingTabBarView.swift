//
//  TabbarView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

protocol FloatingTabBarDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

final class FloatingTabBarView: UIView {
    
    weak var delegate: FloatingTabBarDelegate?
    private(set) var selectedIndex: Int = 0
    
    private let tabIcons: [String] = [
        "house.fill",
        "chart.bar",
        "arrow.left.arrow.right",
        "wallet.pass",
        "gearshape"
    ]
    
    private var itemButtons: [UIButton] = []
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 215/255, alpha: 1.0) // Neon cyan
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Soft radial glow behind active tab
    private let activeGlowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 215/255, alpha: 0.28)
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private var indicatorCenterXConstraint: NSLayoutConstraint?
    private var glowCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Pill radius
        layer.cornerRadius = bounds.height / 2
        blurEffectView.layer.cornerRadius = bounds.height / 2
    }
    
    // MARK: - Setup UI
    private func setupView() {
        backgroundColor = UIColor(red: 15/255, green: 25/255, blue: 38/255, alpha: 0.65)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 120/255, green: 230/255, blue: 255/255, alpha: 0.25).cgColor
        clipsToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Soft drop shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.5
        
        addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(activeGlowView)
        blurEffectView.contentView.addSubview(indicatorView)
        blurEffectView.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: blurEffectView.contentView.topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -10),
            
            // Active Tab Indicator sizing
            indicatorView.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -1),
            indicatorView.widthAnchor.constraint(equalToConstant: 24),
            indicatorView.heightAnchor.constraint(equalToConstant: 3),
            
            // Active Glow sizing
            activeGlowView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            activeGlowView.widthAnchor.constraint(equalToConstant: 30),
            activeGlowView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func setupButtons() {
        for (index, iconName) in tabIcons.enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            
            let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
            let image = UIImage(systemName: iconName, withConfiguration: config)
            button.setImage(image, for: .normal)
            
            button.tintColor = (index == 0)
            ? UIColor(red: 0/255, green: 235/255, blue: 215/255, alpha: 1.0)
            : UIColor(white: 0.55, alpha: 1.0)
            
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            itemButtons.append(button)
        }
        
        // Initial pin to first tab (Index 0)
        guard let firstButton = itemButtons.first else { return }
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor)
        glowCenterXConstraint = activeGlowView.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor)
        
        indicatorCenterXConstraint?.isActive = true
        glowCenterXConstraint?.isActive = true
    }
    
    // MARK: - Actions
    @objc private func tabTapped(_ sender: UIButton) {
        selectTab(at: sender.tag, animated: true)
        delegate?.didSelectTab(at: sender.tag)
    }
    
    func selectTab(at index: Int, animated: Bool) {
        guard index >= 0 && index < itemButtons.count else { return }
        selectedIndex = index
        let targetButton = itemButtons[index]
        
        // Re-attach center constraints
        indicatorCenterXConstraint?.isActive = false
        glowCenterXConstraint?.isActive = false
        
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: targetButton.centerXAnchor)
        glowCenterXConstraint = activeGlowView.centerXAnchor.constraint(equalTo: targetButton.centerXAnchor)
        
        indicatorCenterXConstraint?.isActive = true
        glowCenterXConstraint?.isActive = true
        
        let updateBlock = {
            for (i, btn) in self.itemButtons.enumerated() {
                btn.tintColor = (i == index)
                ? UIColor(red: 0/255, green: 235/255, blue: 215/255, alpha: 1.0)
                : UIColor(white: 0.55, alpha: 1.0)
                btn.transform = (i == index) ? CGAffineTransform(scaleX: 1.12, y: 1.12) : .identity
            }
            self.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                updateBlock()
            }
        } else {
            updateBlock()
        }
    }
    
}
