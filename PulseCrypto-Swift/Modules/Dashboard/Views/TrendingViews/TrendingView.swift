//
//  TrendingView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 03/11/26.
//

import Foundation
import UIKit


final class TrendingView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // Card size matching the reference proportions
        layout.itemSize = CGSize(width: 132, height: 94)
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(TrendingCoinCell.self, forCellWithReuseIdentifier: TrendingCoinCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // Exact Wave Curves Matching Reference
    private let tokens: [TrendingItem] = [
        TrendingItem(
            id: "1",
            symbol: "ALPHA",
            iconName: "sparkle",
            iconTintColor: UIColor(red: 45/255, green: 220/255, blue: 255/255, alpha: 1.0),
            changePercentage: "+12.4%",
            wavePoints: [0.25, 0.45, 0.30, 0.65, 0.45, 0.85], // Rising Cyan-Green wave
            waveColor: UIColor(red: 52/255, green: 211/255, blue: 153/255, alpha: 1.0),
            gradientFillColors: [
                UIColor(red: 52/255, green: 211/255, blue: 153/255, alpha: 0.28).cgColor,
                UIColor(red: 52/255, green: 211/255, blue: 153/255, alpha: 0.0).cgColor
            ]
        ),
        TrendingItem(
            id: "2",
            symbol: "BETA",
            iconName: "suit.diamond.fill",
            iconTintColor: UIColor(red: 100/255, green: 225/255, blue: 245/255, alpha: 1.0),
            changePercentage: "+11.3%",
            wavePoints: [0.35, 0.20, 0.55, 0.40, 0.70, 0.50, 0.75], // Orange-Pink multi-hump wave
            waveColor: UIColor(red: 251/255, green: 146/255, blue: 60/255, alpha: 1.0),
            gradientFillColors: [
                UIColor(red: 251/255, green: 146/255, blue: 60/255, alpha: 0.28).cgColor,
                UIColor(red: 251/255, green: 146/255, blue: 60/255, alpha: 0.0).cgColor
            ]
        ),
        TrendingItem(
            id: "3",
            symbol: "NOVA",
            iconName: "hexagon.fill",
            iconTintColor: UIColor(red: 195/255, green: 140/255, blue: 255/255, alpha: 1.0),
            changePercentage: "+12.3%",
            wavePoints: [0.30, 0.60, 0.40, 0.75, 0.55, 0.80], // Violet wave
            waveColor: UIColor(red: 192/255, green: 132/255, blue: 252/255, alpha: 1.0),
            gradientFillColors: [
                UIColor(red: 192/255, green: 132/255, blue: 252/255, alpha: 0.28).cgColor,
                UIColor(red: 192/255, green: 132/255, blue: 252/255, alpha: 0.0).cgColor
            ]
        )
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 108),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tokens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendingCoinCell.reuseIdentifier,
            for: indexPath
        ) as? TrendingCoinCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: tokens[indexPath.item])
        return cell
    }
}
