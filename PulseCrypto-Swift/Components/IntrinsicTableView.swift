//
//  IntrinsicTableView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import UIKit

//final class IntrinsicTableView: UITableView {
//    
//    override var intrinsicContentSize: CGSize {
//        layoutIfNeeded()
//        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if bounds.size != intrinsicContentSize {
//            invalidateIntrinsicContentSize()
//        }
//    }
//}

//final class IntrinsicTableView: UITableView {
//    
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//        commonInit()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//    
//    private func commonInit() {
//        isScrollEnabled = false
//        estimatedRowHeight = 60
//        rowHeight = UITableView.automaticDimension
//    }
//    
//    override var contentSize: CGSize {
//        didSet {
//            if oldValue.height != contentSize.height {
//                invalidateIntrinsicContentSize()
//            }
//        }
//    }
//    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
//    }
//}


final class IntrinsicTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        isScrollEnabled = false
        estimatedRowHeight = 72
        rowHeight = UITableView.automaticDimension
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var contentSize: CGSize {
        didSet {
            if oldValue.height != contentSize.height {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        if contentSize.height == 0, numberOfRows(inSection: 0) > 0 {
            let estimatedTotal = CGFloat(numberOfRows(inSection: 0)) * estimatedRowHeight
            return CGSize(width: UIView.noIntrinsicMetric, height: estimatedTotal)
        }
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
