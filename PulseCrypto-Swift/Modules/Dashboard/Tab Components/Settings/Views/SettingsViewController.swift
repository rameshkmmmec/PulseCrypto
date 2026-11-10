//
//  SettingsViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import UIKit
import Combine

class SettingsViewController: UIViewController {

    private let headerLabel = ScreenHeaderLabel(title: "Settings")
    private let userCardView = UserCardView()
    
    private let viewModel: SettingsViewModel
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }

    private func setupLayout(){
        
        self.view.addSubview(headerLabel)
        self.view.addSubview(userCardView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            userCardView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            userCardView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            userCardView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        if let profData = viewModel.settingsData?.profile {
            userCardView.configure(name: profData.name, detail: profData.tier, imageName: profData.avatarImage)
        }
    }

}
