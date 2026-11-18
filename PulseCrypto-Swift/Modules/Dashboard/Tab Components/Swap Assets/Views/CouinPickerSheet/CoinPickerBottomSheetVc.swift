//
//  CoinPickerBottomSheetVc.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 14/11/26.
//

import Foundation
import UIKit

final class CoinPickerBottomSheetVc: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let coins: [MarketItem]
    private let selectedCoinId: Int
    private let sheetTitle: String
    var onSelectCoin: ((MarketItem) -> Void)?
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(size: 20, weight: .semiBold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.08)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 68, bottom: 0, right: 16)
        tableView.rowHeight = 68
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(title: String, coins: [MarketItem], selectedCoinId: Int) {
        self.sheetTitle = title
        self.coins = coins
        self.selectedCoinId = selectedCoinId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 38/255, green: 62/255, blue: 74/255, alpha: 1.0)
        
        titleLabel.text = sheetTitle
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinPickerCell.self, forCellReuseIdentifier: "CoinPickerCell")
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinPickerCell.reuseID, for: indexPath) as? CoinPickerCell else {
            return UITableViewCell()
        }
        let coin = coins[indexPath.row]
        cell.configure(with: coin, isSelected: coin.id == selectedCoinId)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pickedCoin = coins[indexPath.row]
        onSelectCoin?(pickedCoin)
        dismiss(animated: true)
    }
    
}



final class CoinPickerCell: UITableViewCell {
    static let reuseID = "CoinPickerCell"
    
    private let iconBgView = UIView()
    private let iconImg = UIImageView()
    private let symbolLabel = UILabel()
    private let nameLabel = UILabel()
    private let balanceLabel = UILabel()
    private let checkmarkImg = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        iconBgView.layer.cornerRadius = 18
        iconBgView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImg.tintColor = .white
        iconImg.contentMode = .scaleAspectFit
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        
        symbolLabel.font = .systemFont(ofSize: 16, weight: .bold)
        symbolLabel.textColor = .white
        
        nameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        nameLabel.textColor = UIColor(red: 155/255, green: 168/255, blue: 185/255, alpha: 1.0)
        
        let titleStack = UIStackView(arrangedSubviews: [symbolLabel, nameLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 2
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        balanceLabel.font = .systemFont(ofSize: 15, weight: .medium)
        balanceLabel.textColor = .white
        balanceLabel.textAlignment = .right
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        checkmarkImg.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)
        checkmarkImg.tintColor = UIColor(red: 86/255, green: 243/255, blue: 197/255, alpha: 1.0)
        checkmarkImg.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconBgView)
        iconBgView.addSubview(iconImg)
        contentView.addSubview(titleStack)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(checkmarkImg)
        
        NSLayoutConstraint.activate([
            iconBgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconBgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconBgView.widthAnchor.constraint(equalToConstant: 36),
            iconBgView.heightAnchor.constraint(equalToConstant: 36),
            
            iconImg.centerXAnchor.constraint(equalTo: iconBgView.centerXAnchor),
            iconImg.centerYAnchor.constraint(equalTo: iconBgView.centerYAnchor),
            iconImg.widthAnchor.constraint(equalToConstant: 22),
            iconImg.heightAnchor.constraint(equalToConstant: 22),
            
            titleStack.leadingAnchor.constraint(equalTo: iconBgView.trailingAnchor, constant: 12),
            titleStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkmarkImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkmarkImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImg.widthAnchor.constraint(equalToConstant: 20),
            checkmarkImg.heightAnchor.constraint(equalToConstant: 20),
            
            balanceLabel.trailingAnchor.constraint(equalTo: checkmarkImg.leadingAnchor, constant: -10),
            balanceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with coin: MarketItem, isSelected: Bool) {
        //iconBgView.backgroundColor = coin.icon_tint_color
        iconBgView.tintColor = UIColor(hex: coin.icon_tint_color)
        iconImg.image = UIImage(systemName: coin.system_icon)
        symbolLabel.text = coin.symbol
        nameLabel.text = coin.name
        balanceLabel.text = String(format: "%.4g %@", coin.price, coin.symbol)
        checkmarkImg.isHidden = !isSelected
        contentView.backgroundColor = isSelected ? UIColor.white.withAlphaComponent(0.05) : .clear
    }
}
