//
//  MarketView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

class MarketView: UIView, UITableViewDelegate, UITableViewDataSource {

    private var marketData: MarketData?
    private var markets: [MarketItem] = []
    
    private var containerView: UIView = {
        let containerVw = UIView()
        containerVw.translatesAutoresizingMaskIntoConstraints = false
        return containerVw
    }()
    
    private var marketLabel: UILabel = {
        let marketLbl = UILabel()
        marketLbl.font = .systemFont(ofSize: 20, weight: .bold)
        marketLbl.textColor = .white
        marketLbl.translatesAutoresizingMaskIntoConstraints = false
        return marketLbl
    }()
    
    private var tableView: IntrinsicTableView = {
        let tableVw = IntrinsicTableView()
        tableVw.backgroundColor = .clear
        tableVw.isScrollEnabled = false
        tableVw.separatorStyle = .none
        tableVw.translatesAutoresizingMaskIntoConstraints = false
        return tableVw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //print("MarketView Frame:", self.frame)
        //print("TableView Frame:", self.tableView.frame)
    }
    
    private func setupLayout(){
        
        translatesAutoresizingMaskIntoConstraints = false

        tableView.register(MarketCell.self, forCellReuseIdentifier: MarketCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.addSubview(containerView)
        containerView.addSubview(marketLabel)
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            marketLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            marketLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: marketLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        if let data = try? Bundle.main.decode(MarketData.self, from: "market.json"){
            self.marketData = data
            self.markets = data.coins
            self.marketLabel.text = data.screen_title
            self.tableView.reloadData()
        }
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tblCell = self.tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as? MarketCell else {
            return UITableViewCell()
        }
        tblCell.configCell(data: markets[indexPath.row])
        return tblCell
    }
    
    
}
