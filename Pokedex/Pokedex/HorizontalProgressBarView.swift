//
//  HorizontalProgressBarView.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 27/04/21.
//

import UIKit

@IBDesignable
class HorizontalProgressBarView: UIView {

    @IBInspectable var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }
    
    private let bgMask = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {

        bgMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = bgMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color.cgColor
    }

}
