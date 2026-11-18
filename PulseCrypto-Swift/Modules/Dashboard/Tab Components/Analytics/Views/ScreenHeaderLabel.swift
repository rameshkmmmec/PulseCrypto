//
//  ScreenHeaderLabel.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

final class ScreenHeaderLabel: UILabel {
    
    init(title: String = "", font: CGFloat = 24) {
        super.init(frame: .zero)
        self.text = title
        self.font = UIFont.appFont(size: font, weight: .semiBold)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        //self.font = UIFont.appFont(size: 24, weight: .semiBold)
        self.textColor = .white
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
