//
//  GradientView.swift
//  Indigo
//
//  Created by Saša Vujanovic on 09/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import UIKit

class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2068095207, green: 0.2519137561, blue: 0.2926518917, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1450980392, green: 0.2901960784, blue: 0.4352941176, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
