//
//  Extensions.swift
//  GreystoneApp
//
//  Created by Ashish Mishra on 6/17/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit
import QuartzCore


class Extensions: NSObject {

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIView {
    
    func roundedCorners(radius : CGFloat) {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.TopRight, .TopLeft], cornerRadii: CGSizeMake(radius, radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.CGPath
        self.layer.mask = maskLayer
    }
    
    func roundedCorners(radius : CGFloat, roundingCorners : UIRectCorner) {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSizeMake(radius, radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.CGPath
        self.layer.mask = maskLayer
    }
}

extension CALayer {
    
    func setBorderColorFromUIcolor(color : UIColor) {
        self.borderColor! = color.CGColor
    }
    
        var borderColorFromUIColor: UIColor {
            get {
                return UIColor(CGColor: self.borderColor!)
            } set {
                self.borderColor = newValue.CGColor
            }
        }
    
    func roundedCorners(radius : CGFloat, roundingCorners : UIRectCorner) {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSizeMake(radius, radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.CGPath
        self.mask = maskLayer
    }
}
