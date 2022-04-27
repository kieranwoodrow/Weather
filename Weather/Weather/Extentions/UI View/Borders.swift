//
//  Borders.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/27.
//

import Foundation
import UIKit

extension UIView {
    
    enum Side:String {
        case top
        case bottom
        case left
        case right
    }
    
    func addBorder(side:Side, color:UIColor, width:CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        self.layer.addSublayer(border)
    }
}
