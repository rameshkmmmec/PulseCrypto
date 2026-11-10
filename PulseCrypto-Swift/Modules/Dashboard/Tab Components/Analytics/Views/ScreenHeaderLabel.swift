//
//  ScreenHeaderLabel.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

final class ScreenHeaderLabel: UILabel {
    
    init(title: String = "") {
        super.init(frame: .zero)
        self.text = title
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        self.font = .systemFont(ofSize: 20, weight: .semibold)
        self.textColor = .white
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
