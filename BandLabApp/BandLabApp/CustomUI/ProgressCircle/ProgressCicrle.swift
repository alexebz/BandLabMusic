//
//  ProgressCicrle.swift
//  BandLabApp
//
//  Created by l.vasilyeva on 25.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

class ProgressCicrle: UIView {
    
    // MARK: - Interface
    func setProgress(_ progress: Double) {
        guard progress >= 0 && progress <= 1.0 else { return }
        self.progress = progress
        progressAnimation(progressValue: progress)
    }
    
    // MARK: - Properties
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var animSpeeed: Double = 0.1
    private var progress: Double = 0.0
    
    var progressColor:UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor:UIColor = UIColor.white {
        didSet {
            circleLayer.strokeColor = trackColor.cgColor
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private
    private func setupView() {
        createCircularPath()
    }
    
    private func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width / 2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                         y: frame.size.height / 2.0),
                                      radius: (frame.size.width - 1.5)/2,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = trackColor.cgColor
        circleLayer.lineWidth = 2.0
        circleLayer.strokeEnd = 1.0
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 2.0
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
        
    }
    
    private func progressAnimation(progressValue: Double) {
        progressLayer.strokeEnd = progressValue
    }
}
