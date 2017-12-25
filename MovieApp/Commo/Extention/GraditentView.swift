//
//  GraditentView.swift
//  MovieApp
//
//  Created by ADMIN on 12/22/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit



class GraditentView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [
            UIColor.init(red: 1, green: 1, blue: 1, alpha: 0).cgColor, UIColor.black.cgColor
        ]
        backgroundColor = UIColor.clear
    }
}

