//
//  Utils.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//
import UIKit
class Utils {
 static func insertGradientLayer(theView: UIView)
    {
        
        theView.backgroundColor = UIColor.white
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = theView.bounds
        
        let color1 = UIColor(red: 0, green: 0.32, blue: 0.5, alpha: 0.7).cgColor as CGColor
        let color2 = UIColor(red: 0.0, green: 0.1, blue: 0.3, alpha: 1.0).cgColor as CGColor
        
        gradientLayer.colors = [color1, color2]

        theView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
