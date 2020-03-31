//
//  CustomView.swift
//  Weather App
//
//  Created by Simo on 3/30/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
           didSet {
            self.layer.shadowOffset = shadowOffset
            
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.2 {
            didSet {
               self.layer.shadowOpacity = shadowOpacity
           }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
            didSet {
               self.layer.shadowRadius = shadowRadius
           }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray {
            didSet {
                self.layer.shadowColor = shadowColor.cgColor
           }
    }
    
    
    
    

}
