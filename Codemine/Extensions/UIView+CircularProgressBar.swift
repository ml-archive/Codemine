//
//  UIView+CircularProgressBar.swift
//  Codemine
//
//  Created by Himshikhar Gayan on 20/10/19.
//  Copyright © 2019 Nodes. All rights reserved.
//

import UIKit

extension UIView {
    func circularProgressBar(shapeStrokeColor: CGColor,progressStrokeColor: CGColor,progress: CGFloat){
        var backgroundPath: UIBezierPath!
        var shapeLayer: CAShapeLayer!
        var progressLayer: CAShapeLayer!
        
        backgroundPath = UIBezierPath()
        
        let x = self.frame.width/2
        let y = self.frame.height/2
        let center = CGPoint(x: x, y: y)
        print(x,y,center)
        backgroundPath.addArc(withCenter: center, radius: x/CGFloat(2), startAngle: CGFloat(0), endAngle: CGFloat(6.28), clockwise: true)
        backgroundPath.close()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = backgroundPath.cgPath
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = shapeStrokeColor
        
        progressLayer = CAShapeLayer()
        progressLayer.path = backgroundPath.cgPath
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.lineWidth = 3
        progressLayer.strokeColor = progressStrokeColor
        progressLayer.strokeEnd = 0.0
        progressLayer.lineCap = .round

        progressLayer.strokeEnd = progress
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(progressLayer)
    }
}
