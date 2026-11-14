//
//  SwapAssetsViewController.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import UIKit
import Combine

class SwapAssetsViewController: UIViewController {

    private let swapCardView = SwapCardsContainerView()
    private let viewModel: SwapViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(vm: SwapViewModel = SwapViewModel()) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let headerLbl: UILabel = {
        let header = UILabel()
        header.text = "Swap Assets"
        header.font = UIFont.appFont(size: 24, weight: .semiBold)
        header.textColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private let scrollView: UIScrollView = {
        let scrollVw = UIScrollView()
        scrollVw.showsVerticalScrollIndicator = false
        scrollVw.showsHorizontalScrollIndicator = false
        scrollVw.alwaysBounceVertical = true
        scrollVw.translatesAutoresizingMaskIntoConstraints = false
        return scrollVw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swapCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(headerLbl)
        scrollView.addSubview(swapCardView)
        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                       
            headerLbl.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 64),
            headerLbl.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            headerLbl.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            
            swapCardView.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 20),
            swapCardView.leadingAnchor.constraint(equalTo: headerLbl.leadingAnchor),
            swapCardView.trailingAnchor.constraint(equalTo: headerLbl.trailingAnchor),
            swapCardView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -60)
        ])
        
        self.setupActions()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        Publishers.CombineLatest(viewModel.$fromCoin, viewModel.$toCoin)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _, _ in
                self?.refreshSwapUI()
            }
            .store(in: &cancellables)
    }
}

extension SwapAssetsViewController {
    
    private func setupActions() {
        
        swapCardView.swapButton.addTarget(self, action: #selector(hanldleSwapCoinTapped), for: .touchUpInside)
        
        let fromCoinTap = UITapGestureRecognizer(target: self, action: #selector(handleFromCoinTapped))
        swapCardView.fromCardView.coinView.isUserInteractionEnabled = true
        swapCardView.fromCardView.coinView.addGestureRecognizer(fromCoinTap)
        
        let toCoinTap = UITapGestureRecognizer(target: self, action: #selector(handleToCoinTapped))
        swapCardView.toCardView.coinView.isUserInteractionEnabled = true
        swapCardView.toCardView.coinView.addGestureRecognizer(toCoinTap)
        
        swapCardView.reviewButton.addTarget(self, action: #selector(handleReviewCoinTapped), for: .touchUpInside)
    }
        
    @objc func hanldleSwapCoinTapped() {
        
        UIView.animate(withDuration: 0.3) {
            self.swapCardView.swapButton.transform = self.swapCardView.swapButton.transform.rotated(by: .pi)
            let tempFromCoin = viewModel.fromCoin
            viewModel.fromCoin = viewModel.toCoin
            viewModel.toCoin = tempFromCoin
            self.refreshSwapUI()
        }
    }
    
    private func presentCoinPicker(title: String, current: MarketItem?, completion: @escaping (MarketItem) -> Void) {
        
        let pickerVC = CoinPickerBottomSheetVc(title: title, coins: viewModel.coins, selectedCoinId: current?.id ?? 0)
        pickerVC.onSelectCoin = completion
        
        if let sheet = pickerVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(pickerVC, animated: true)
    }
    
    @objc func handleFromCoinTapped() {
        
        presentCoinPicker(title: "Select From Asset", current: viewModel.fromCoin) { [weak self] pickedCoin in
            guard let self = self else { return }
            viewModel.fromCoin = pickedCoin
            self.refreshSwapUI()
        }
    }
    
    @objc func handleToCoinTapped() {
        
        presentCoinPicker(title: "Select To Asset", current: viewModel.toCoin) { [weak self] pickedCoin in
            guard let self = self else { return }
            viewModel.fromCoin = pickedCoin
            self.refreshSwapUI()
        }
    }
    
    @objc func handleReviewCoinTapped() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showToast(message: "Congratulations, swapping occured successlly.", bottom: 120)
        }
    }
    
    private func refreshSwapUI() {
        
        if let fromCoin = viewModel.fromCoin {
            let fromCard = swapCardView.fromCardView
            fromCard.coinImg.image = UIImage(systemName: fromCoin.system_icon)
            fromCard.coinImg.tintColor = UIColor(hex: fromCoin.icon_tint_color)
            fromCard.setCoinTitle(name: fromCoin.name, symbol: fromCoin.symbol)
            fromCard.amountLabel.text = String(format: "%@%.2f", fromCoin.currency_symbol, fromCoin.price)
            fromCard.bottomLeftLabel.text = "Available Balance"
//          fromCard.rateLabel.text = String(format: "(%.4g %@)", fromQty, fromCoin.symbol)
//          fromCard.bottomRightLabel.text = String(format: "$%.0f %@", availableInUSD, fromCoin.symbol)
        }
        
        if let toCoin = viewModel.toCoin {
            let toCard = swapCardView.toCardView
            toCard.coinImg.image = UIImage(systemName: toCoin.system_icon)
            toCard.coinImg.tintColor = UIColor(hex: toCoin.icon_tint_color)
            toCard.setCoinTitle(name: toCoin.name, symbol: toCoin.symbol)
            toCard.amountLabel.text = String(format: "%@%.2f", toCoin.currency_symbol, toCoin.price)
            if let fromCoin = viewModel.fromCoin {
                toCard.bottomLeftLabel.text = String(format: "1\(fromCoin.symbol) = %.2f%@", fromCoin.change_percentage*toCoin.price, toCoin.symbol)
            }
            toCard.bottomRightLabel.textColor = UIColor(red: 155/255, green: 168/255, blue: 185/255, alpha: 1.0)
//            fromCard.rateLabel.text = String(format: "(%.4g %@)", fromQty, fromCoin.symbol)
//            fromCard.bottomLeftLabel.text = "Available Balance"
//            fromCard.bottomRightLabel.text = String(format: "$%.0f %@", availableInUSD, fromCoin.symbol)
            toCard.extraLeftLabel.text = "Slippage"
            toCard.extraRightLabel.text = "0.1%"
        }
    }
}
