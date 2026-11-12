//
//  SettingsOptionsView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 12/11/26.
//

import Foundation
import UIKit

final class SettingsOptionsView: UIView, UITableViewDelegate, UITableViewDataSource {

    private var settings: [SettingItem] = []
    private var logoutView = SettingsLogoutView(frame: CGRect(x: 0, y: 0, width: 0, height: 80))
    
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: IntrinsicTableView = {
        let tableVw = IntrinsicTableView()
        tableVw.isScrollEnabled = false
        tableVw.backgroundColor = .clear
        tableVw.separatorStyle = .none
        tableVw.register(SettingsOptionsCell.self, forCellReuseIdentifier: SettingsOptionsCell.reuseIndentier)
        tableVw.translatesAutoresizingMaskIntoConstraints = false
        return tableVw
    }()
                                                        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupBasicDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                                                
    func setupBasicDetails(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        logoutView.translatesAutoresizingMaskIntoConstraints = true
        logoutView.autoresizingMask = [.flexibleWidth]
        tableView.tableFooterView = logoutView
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configure(with settingData: SettingsData) {
        
        if let items = settingData.sections.first?.items {
            self.settings = items
        }
        logoutView.configLogoutData(data: settingData.logoutAction)
        self.tableView.reloadData()
        self.tableView.invalidateIntrinsicContentSize()
    }
    
    func setUpLogoutData(data: LogoutAction){
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableCell = self.tableView.dequeueReusableCell(withIdentifier: SettingsOptionsCell.reuseIndentier, for: indexPath) as? SettingsOptionsCell else {
            return UITableViewCell()
        }
        tableCell.configCellData(data: settings[indexPath.row], isLast: (indexPath.row == settings.count-1))
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.settings[indexPath.row]
        if item.type == .toggle{
            self.settings[indexPath.row].isEnabled = !(self.settings[indexPath.row].isEnabled)
            self.tableView.reloadData()
        }
    }
}
