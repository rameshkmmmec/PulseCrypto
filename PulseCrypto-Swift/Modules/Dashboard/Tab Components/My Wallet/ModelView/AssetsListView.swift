//
//  AssetsListView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 18/11/26.
//

import Foundation
import UIKit

final class AssetsListView: UIView, UITableViewDataSource, UITableViewDelegate {

    private var items = [MarketItem]()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented.")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    private let assetLbl: UILabel = {
        let label = UILabel()
        label.text = "Assets"
        label.textColor = .white
        label.font = .appFont(size: 22, weight: .semiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: IntrinsicTableView = {
        let tableVw = IntrinsicTableView()
        tableVw.backgroundColor = .clear
        tableVw.separatorStyle = .none
        tableVw.register(AssetsCell.self, forCellReuseIdentifier: AssetsCell.reuseIdentifier)
        tableVw.translatesAutoresizingMaskIntoConstraints = false
        return tableVw
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("DEBUG -> AssetsListView:", self.frame, "TableView:", self.tableView.frame)
    }
    
    private func setupLayout(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.addSubview(assetLbl)
        self.addSubview(tableView)
                
        NSLayoutConstraint.activate([
        
            assetLbl.topAnchor.constraint(equalTo: topAnchor),
            assetLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            assetLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: assetLbl.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: assetLbl.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: assetLbl.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configAssetData(with data:[MarketItem]){
        self.items = data
        self.tableView.reloadData()
        self.tableView.invalidateIntrinsicContentSize()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableCell = self.tableView.dequeueReusableCell(withIdentifier: AssetsCell.reuseIdentifier, for: indexPath) as? AssetsCell else {
            return UITableViewCell()
        }
        
        tableCell.configuew(with: items[indexPath.row], index: indexPath.row)
        tableCell.selectionStyle = .none
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        items[indexPath.row].isSelected.toggle()
//        
//        let isExpandable = items[indexPath.row].isSelected
//        
//        if let cell = self.tableView.cellForRow(at: indexPath) as? AssetsCell{
//            cell.setExpanded(isExpandable, animated: true)
//        }
//        
//        self.tableView.performBatchUpdates(nil, completion: nil)
    }

}
