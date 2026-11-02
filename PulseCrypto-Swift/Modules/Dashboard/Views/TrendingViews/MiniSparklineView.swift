//
//  MiniSparklineView.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 03/11/26.
//

import Foundation
import UIKit


final class MiniSparklineView: UIView {
    
    private let strokeLayer = CAShapeLayer()
    private let fillLayer = CAGradientLayer()
    private let fillMask = CAShapeLayer()
    
    private var normalizedPoints: [CGFloat] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayers() {
        backgroundColor = .clear
        
        strokeLayer.fillColor = UIColor.clear.cgColor
        strokeLayer.lineWidth = 2.0
        strokeLayer.lineCap = .round
        strokeLayer.lineJoin = .round
        
        fillLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        fillLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        fillLayer.mask = fillMask
        
        layer.addSublayer(fillLayer)
        layer.addSublayer(strokeLayer)
    }
    
    func configure(points: [CGFloat], strokeColor: UIColor, fillColors: [CGColor]) {
        self.normalizedPoints = points
        strokeLayer.strokeColor = strokeColor.cgColor
        fillLayer.colors = fillColors
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.width > 0, bounds.height > 0, normalizedPoints.count > 1 else { return }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        fillLayer.frame = bounds
        
        let width = bounds.width
        let height = bounds.height
        let stepX = width / CGFloat(normalizedPoints.count - 1)
        
        var cgPoints: [CGPoint] = []
        for (index, val) in normalizedPoints.enumerated() {
            let x = CGFloat(index) * stepX
            // Invert Y axis: 0.0 is bottom, 1.0 is top peak
            let y = height - (val * height)
            cgPoints.append(CGPoint(x: x, y: y))
        }
        
        let path = UIBezierPath()
        path.move(to: cgPoints[0])
        
        for i in 1..<cgPoints.count {
            let prev = cgPoints[i - 1]
            let current = cgPoints[i]
            let midPoint = CGPoint(x: (prev.x + current.x) / 2.0, y: (prev.y + current.y) / 2.0)
            let controlPoint1 = CGPoint(x: (prev.x + midPoint.x) / 2.0, y: prev.y)
            let controlPoint2 = CGPoint(x: (midPoint.x + current.x) / 2.0, y: current.y)
            path.addQuadCurve(to: midPoint, controlPoint: controlPoint1)
            path.addQuadCurve(to: current, controlPoint: controlPoint2)
        }
        
        strokeLayer.path = path.cgPath
        
        // Gradient fill mask below the curve
        let fillPath = UIBezierPath(cgPath: path.cgPath)
        fillPath.addLine(to: CGPoint(x: width, y: height))
        fillPath.addLine(to: CGPoint(x: 0, y: height))
        fillPath.close()
        fillMask.path = fillPath.cgPath
        
        CATransaction.commit()
    }
}
